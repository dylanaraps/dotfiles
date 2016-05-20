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

//!HOOK POSTKERNEL
//!BIND HOOKED
//!BIND PREKERNEL
//!SAVE DOWNSCALEDX
//!WIDTH PREKERNEL.w
//!COMPONENTS 4

// -- Downscaling --
#define dxdy   (vec2(PREKERNEL_pt.x, POSTKERNEL_pt.y))
#define ddxddy (POSTKERNEL_pt)

#define factor ((ddxddy*vec2(PREKERNEL_size.x, POSTKERNEL_size.y))[axis])

#define axis 0

#define offset vec2(0,0)

#define Kernel(x) clamp(0.5 + (0.5 - abs(x)) / factor, 0.0, 1.0)
#define taps (1.0 + factor)

vec4 hook() {
    if (PREKERNEL_size.x >= POSTKERNEL_size.x) return vec4(0);
    // Calculate bounds
    float low  = floor((POSTKERNEL_pos - 0.5*taps*dxdy) * POSTKERNEL_size - offset + 0.5)[axis];
    float high = floor((POSTKERNEL_pos + 0.5*taps*dxdy) * POSTKERNEL_size - offset + 0.5)[axis];

    float W = 0.0;
    vec4 avg = vec4(0);
    vec2 pos = POSTKERNEL_pos;

    for (int k = 0; k < int(high - low); k++) {
        pos[axis] = ddxddy[axis] * (float(k) + low + 0.5);
        float rel = (pos[axis] - POSTKERNEL_pos[axis])*vec2(PREKERNEL_size.x, POSTKERNEL_size.y)[axis] + offset[axis]*factor;
        float w = Kernel(rel);

        avg += w * textureLod(POSTKERNEL_raw, pos, 0.0);
        W += w;
    }
    avg /= vec4(W);

    return avg;
}

//!HOOK POSTKERNEL
//!BIND HOOKED
//!BIND DOWNSCALEDX
//!BIND PREKERNEL
//!SAVE LOWRES
//!WIDTH PREKERNEL.w
//!HEIGHT PREKERNEL.h
//!COMPONENTS 4

// -- Downscaling --
#define dxdy   (PREKERNEL_pt)
#define ddxddy (DOWNSCALEDX_pt)

#define factor ((ddxddy*PREKERNEL_size)[axis])

#define axis 1

#define offset vec2(0,0)

#define Kernel(x) clamp(0.5 + (0.5 - abs(x)) / factor, 0.0, 1.0)
#define taps (1.0 + factor)

#define Kb 0.0722
#define Kr 0.2126
#define Luma(rgb) ( dot(vec3(Kr, 1.0 - Kr - Kb, Kb), rgb) )

vec4 hook() {
    if (PREKERNEL_size.y >= POSTKERNEL_size.y) return vec4(0);
    // Calculate bounds
    float low  = floor((DOWNSCALEDX_pos - 0.5*taps*dxdy) * DOWNSCALEDX_size - offset + 0.5)[axis];
    float high = floor((DOWNSCALEDX_pos + 0.5*taps*dxdy) * DOWNSCALEDX_size - offset + 0.5)[axis];

    float W = 0.0;
    vec4 avg = vec4(0);
    vec2 pos = DOWNSCALEDX_pos;

    for (int k = 0; k < int(high - low); k++) {
        pos[axis] = ddxddy[axis] * (float(k) + low + 0.5);
        float rel = (pos[axis] - DOWNSCALEDX_pos[axis])*PREKERNEL_size[axis] + offset[axis]*factor;
        float w = Kernel(rel);

        avg += w * textureLod(DOWNSCALEDX_raw, pos, 0.0);
        W += w;
    }
    avg /= vec4(W);

    return vec4(avg.xyz, Luma(avg.xyz));
}

//!HOOK POSTKERNEL
//!BIND HOOKED
//!BIND PREKERNEL
//!BIND LOWRES

// SuperRes final pass

#define FinalPass 1

#define strength  1.0
#define softness  0.0

// -- Edge detection options --
#define acuity 6.0
#define radius 0.5
#define power  1.0

// -- Skip threshold --
#define threshold 1
#define skip (1==0)//(c0.a < threshold/255.0);

#define dxdy (HOOKED_pt)
#define ddxddy (LOWRES_pt)

// -- Window Size --
#define taps 4.0
#define even (taps - 2.0 * floor(taps / 2.0) == 0.0)
#define minX int(1.0-ceil(taps/2.0))
#define maxX int(floor(taps/2.0))

#define factor (ddxddy*HOOKED_size)
#define Kernel(x) (cos(acos(-1.0)*(x)/taps)) // Hann kernel

// -- Convenience --
#define sqr(x) dot(x,x)

// -- Input processing --
//Current high res value
#define Get(x,y)    ( textureLod(HOOKED_raw, HOOKED_pos + sqrt(ddxddy*HOOKED_size)*dxdy*vec2(x,y), 0.0).xyz )
#define GetY(x,y)   ( textureLod(LOWRES_raw, ddxddy*(pos+vec2(x,y)+0.5), 0.0).a )
//Downsampled result
#define Lowres(x,y) ( textureLod(LOWRES_raw, ddxddy*(pos+vec2(x,y)+0.5), 0.0).xyz )

//#define Gamma(x)    ( mix(x * vec3(12.92), vec3(1.055) * pow(max(x, 0.0), vec3(1.0/2.4)) - vec3(0.055), step(vec3(0.0031308), x)) )
//#define GammaInv(x) ( mix(pow((x + vec3(0.055))/vec3(1.055), vec3(2.4)), x / vec3(12.92), step(x, vec3(0.04045))) )
#define Gamma(x)    ( pow(max(x, 0.0), vec3(1.0/2.0)) )
#define GammaInv(x) ( pow((x), vec3(2.0)) )
#define Kb 0.0722
#define Kr 0.2126
#define Luma(rgb)   ( dot(vec3(Kr, 1.0 - Kr - Kb, Kb), rgb) )

vec4 hook() {
    vec4 c0 = HOOKED_tex(HOOKED_pos);
    if (any(greaterThanEqual(LOWRES_size, HOOKED_size))) return c0;
    vec3 Lin = c0.xyz;

    // Calculate position
    vec2 pos = HOOKED_pos * LOWRES_size - vec2(0.5);
    vec2 offset = pos - (even ? floor(pos) : round(pos));
    pos -= offset;

    // Calculate faithfulness force
    float weightSum = 0.0;
    vec3 diff = vec3(0);
    vec3 soft = vec3(0);

    for (int X = minX; X <= maxX; X++)
    for (int Y = minX; Y <= maxX; Y++)
    {
        float dI2 = sqr(acuity*(max(1.0/(Luma(c0.xyz)),0.0) - max(1.0/(GetY(X,Y)),0.0)));
        //float dXY2 = sqr((vec2(X,Y) - offset)/radius);
        //float weight = exp(-0.5*dXY2) * pow(1.0 + dI2/power, - power);
        vec2 krnl = Kernel(vec2(X,Y) - offset);
        float weight = krnl.x * krnl.y * pow(1.0 + dI2/power, - power);

        diff += weight*(Gamma(Lowres(X,Y)) - Gamma(textureLod(PREKERNEL_raw, ddxddy*(pos+vec2(X,Y)+0.5), 0.0).xyz));
        weightSum += weight;
    }
    diff /= weightSum;
    c0.xyz = Gamma(c0.xyz);
    c0.xyz -= strength * diff;

    // Convert back to linear light;
    c0.xyz = GammaInv(c0.xyz);

#ifndef FinalPass

    if (softness != 0.0) {
        weightSum=0.0;
        #define softAcuity 6.0

        for (int X = -1; X <= 1; X++)
        for (int Y = -1; Y <= 1; Y++)
        if (X != 0 || Y != 0)
        {
            vec3 dI = Get(X,Y) - Lin;
            float dI2 = sqr(softAcuity*dI);
            float dXY2 = sqr(vec2(X,Y)/radius);
            float weight = pow(inversesqrt(dXY2 + dI2),3.0); // Fundamental solution to the 5d Laplace equation
            // float weight = exp(-0.5*dXY2) * pow(1 + dI2/power, - power);

            soft += vec3(weight * dI);
            weightSum += weight;
        }
        soft /= vec3(weightSum);

        c0.xyz += vec3(softness) * soft;
    }

#endif

    return c0;
}
