// CrossBilateral by Shiandow
//
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 3.0 of the License, or (at your option) any later version.
// 
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public
// License along with this library.


//!HOOK CHROMA
//!BIND HOOKED
//!BIND LUMA
//!SAVE DOWNSCALEDLUMAX
//!HEIGHT LUMA.h
//!COMPONENTS 4

// -- Downscaling --
#define offset   (-vec2(0.0, 0.0)*LUMA_size*CHROMA_pt) // -chromaOffset*LUMA_size/CHROMA_size

#define dxdy     (vec2(CHROMA_pt.x, LUMA_pt.y)) // 1/output_size
#define ddxddy   (LUMA_pt)                      // 1/input_size

#define factor   ((ddxddy*vec2(CHROMA_size.x, LUMA_size.y))[axis])

#define axis 0

#define Kernel(x) clamp(0.5 + (0.5 - abs(x)) / factor, 0.0, 1.0)
#define taps (1.0 + factor)

vec4 hook() {
    //if (CHROMA_size.x >= LUMA_size.x) return vec4(0);
    // Calculate bounds
    float low  = floor((LUMA_pos - 0.5*taps*dxdy) * LUMA_size - offset + 0.5)[axis];
    float high = floor((LUMA_pos + 0.5*taps*dxdy) * LUMA_size - offset + 0.5)[axis];

    float W = 0.0;
    vec2 avg = vec2(0);
    vec2 pos = LUMA_pos;

    for (int k = 0; k < int(high - low); k++) {
        pos[axis] = ddxddy[axis] * (float(k) + low + 0.5);
        float rel = (pos[axis] - LUMA_pos[axis])*vec2(CHROMA_size.x, LUMA_size.y)[axis] + offset[axis]*factor;
        float w = Kernel(rel);

        avg += w * vec2(textureLod(LUMA_raw, pos, 0.0).x, pow(textureLod(LUMA_raw, pos, 0.0).x, 2.0));
        W += w;
    }
    avg /= vec2(W);

    return vec4(avg[0], avg[1] - avg[0]*avg[0], 0, 0);
}

//!HOOK CHROMA
//!BIND HOOKED
//!BIND DOWNSCALEDLUMAX
//!SAVE LOWRES_YUV
//!COMPONENTS 4

// -- Downscaling --
#define offset   (-vec2(0.0, 0.0)*DOWNSCALEDLUMAX_size*CHROMA_pt)

#define dxdy     (CHROMA_pt)
#define ddxddy   (DOWNSCALEDLUMAX_pt)

#define factor   ((ddxddy*CHROMA_size)[axis])

#define axis 1

#define Kernel(x) clamp(0.5 + (0.5 - abs(x)) / factor, 0.0, 1.0)
#define taps (1.0 + factor)

vec4 hook() {
    // Calculate bounds
    float low  = floor((DOWNSCALEDLUMAX_pos - 0.5*taps*dxdy) * DOWNSCALEDLUMAX_size - offset + 0.5)[axis];
    float high = floor((DOWNSCALEDLUMAX_pos + 0.5*taps*dxdy) * DOWNSCALEDLUMAX_size - offset + 0.5)[axis];

    float W = 0.0;
    vec2 avg = vec2(0);
    vec2 pos = DOWNSCALEDLUMAX_pos;

    for (int k = 0; k < int(high - low); k++) {
        pos[axis] = ddxddy[axis] * (float(k) + low + 0.5);
        float rel = (pos[axis] - DOWNSCALEDLUMAX_pos[axis])*CHROMA_size[axis] + offset[axis]*factor;
        float w = Kernel(rel);

        avg += w * vec2(textureLod(DOWNSCALEDLUMAX_raw, pos, 0.0).x, textureLod(DOWNSCALEDLUMAX_raw, pos, 0.0).y + pow(textureLod(DOWNSCALEDLUMAX_raw, pos, 0.0).x, 2.0));
        W += w;
    }
    avg /= vec2(W);

    return vec4(avg[0], texture(CHROMA_raw, CHROMA_pos).xy, avg[1]-avg[0]*avg[0]);
}

//!HOOK NATIVE
//!BIND HOOKED
//!BIND LOWRES_YUV

// -- CrossBilateral --

// -- Misc --
#define power  0.5

// -- Convenience --
#define sqr(x) dot(x,x)
#define noise  0.05
#define bitnoise 1.0/(2.0*255.0)

#define dxdy   (NATIVE_pt)
#define ddxddy (LOWRES_YUV_pt)
#define chromaOffset vec2(0.0, 0.0)
#define radius 0.5

// -- Window Size --
#define taps 4.0
#define even (taps - 2.0 * floor(taps / 2.0) == 0.0)
#define minX int(1.0-ceil(taps/2.0))
#define maxX int(floor(taps/2.0))

#define factor (dxdy/ddxddy)
// #define Kernel(x) saturate(0.5 + (0.5 - abs(x)) * 2)
#define pi acos(-1.0)
#define Kernel(x) (cos(pi*(x)/taps)) // Hann kernel

#define sinc(x) sin(pi*(x))/(x)
#define BCWeights(B,C,x) (mix(vec2(0.0), mix((((-B/6.0-C)*x + (B+5.0*C))*x + (-2.0*B-8.0*C))*x+vec2((4.0/3.0)*B+4.0*C), ((2.0-1.5*B-C)*x + (-3.0+2.0*B+C))*x*x + vec2(1.0-B/3.0), step(x, vec2(1.0))), step(x, vec2(2.0))))
#define IntKernel(x) (BCWeights(1.0/3.0, 1.0/3.0, abs(x)))
// #define IntKernel(x) (cos(0.5*pi*saturate(abs(x))))

// -- Input processing --
// Luma value
#define GetLuma(x,y)   texture(LOWRES_YUV_raw, HOOKED_pos + dxdy*vec2(x,y))[0]
// Chroma value
#define GetChroma(x,y) texture(LOWRES_YUV_raw, ddxddy*(pos+vec2(x,y)+0.5))

vec4 hook() {
    vec4 c0 = HOOKED_tex(HOOKED_pos);
    if (LOWRES_YUV_size.x >= HOOKED_size.x) return c0;

    // Calculate position
    vec2 pos = HOOKED_pos * LOWRES_YUV_size - chromaOffset - vec2(0.5);
    vec2 offset = pos - (even ? floor(pos) : round(pos));
    pos -= offset;

    float localVar = sqr(noise);

    // Bilateral weighted interpolation
    vec4 fitAvg = vec4(0);
    vec4 fitVar = vec4(0);
    vec4 fitCov = vec4(0);
    vec4 intAvg = vec4(0);
    vec4 intVar = vec4(0);
    for (int X = minX; X <= maxX; X++)
    for (int Y = minX; Y <= maxX; Y++)
    {
        float dI2 = sqr(GetChroma(X,Y).x - c0.x);
        float var = GetChroma(X,Y).w + sqr(bitnoise);
        float dXY2 = sqr((vec2(X,Y) - offset)/radius);

        vec2 kernel = Kernel(vec2(X,Y) - offset);
        float weight = - kernel.x * kernel.y * log(dI2 + var + localVar);

        fitAvg += weight*vec4(GetChroma(X,Y).xyz, 1.0);
        fitVar += weight*vec4((vec4(var, sqr(bitnoise), sqr(bitnoise), 0.0) + GetChroma(X,Y)*GetChroma(X,Y)).xyz, weight);
        fitCov += weight*vec4(GetChroma(X,Y).x*GetChroma(X,Y).yz, var, 0.0);

        kernel = IntKernel(vec2(X,Y) - offset);
        weight = kernel.x * kernel.y;
        intAvg += weight*vec4(GetChroma(X,Y).xyz, 1.0);
        intVar += weight*vec4((vec4(var, sqr(bitnoise), sqr(bitnoise), 0.0) + GetChroma(X,Y)*GetChroma(X,Y)).xyz, weight);
    }    
    float weightSum = fitAvg.w;
    float weightSqrSum = fitVar.w;

    // Linear fit
    fitAvg /= vec4(weightSum);
    vec3 Var = (fitVar / weightSum).xyz - fitAvg.xyz*fitAvg.xyz;
    vec2 Cov = (fitCov / weightSum).xy - fitAvg.x*fitAvg.yz;

    // Interpolation
    float intWeightSum = intAvg.w;
    float intWeightSqrSum = intVar.w;
    intAvg /= vec4(intWeightSum);
    intVar = (intVar / vec4(intWeightSum)) - intAvg*intAvg;

    // Estimate error

    // Coefficient of determination
    vec2 R2 = clamp((Cov * Cov) / (Var.x * Var.yz), 0.0, 1.0);
    // Error of fit
    vec2 errFit = (vec2(1.0)-R2) * vec2((weightSqrSum / sqr(weightSum) + sqr(c0.x - fitAvg.x) / Var.x) / (1.0 - weightSqrSum / sqr(weightSum)));
    // Error of interpolation
    vec2 errInt = mix((intVar.yz / Var.yz) * vec2(intWeightSqrSum / sqr(intWeightSum)), vec2(sqr(c0.x - intAvg.x) + intVar.x) / Var.x, R2);

    // Balance error of interpolation with error of fit.
    vec2 strength = clamp(power * errInt / mix(errFit, errInt, power), 0.0, 1.0);

    // Debugging
    // return vec4(dot(strength,vec2(0.5)), 0.5, 0.5, 1.0);

    // Update c0
    c0.yz = mix(intAvg.yz, fitAvg.yz + ((c0.x - fitAvg.x) * Cov / Var.x), strength);

    return c0;
}
