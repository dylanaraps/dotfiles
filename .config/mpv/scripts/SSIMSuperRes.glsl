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

#define Kb 0.0722
#define Kr 0.2126
#define Luma(rgb)   ( dot(vec3(Kr, 1.0 - Kr - Kb, Kb), rgb) )

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

        avg += w * vec4(textureLod(POSTKERNEL_raw, pos, 0.0).xyz, pow(Luma(textureLod(POSTKERNEL_raw, pos, 0.0).xyz), 2.0));
        W += w;
    }
    avg /= vec4(W);

    return vec4(avg.xyz, avg[3] - pow(Luma(avg.xyz), 2.0));
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
#define Luma(rgb)   ( dot(vec3(Kr, 1.0 - Kr - Kb, Kb), rgb) )

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

        avg += w * vec4(textureLod(DOWNSCALEDX_raw, pos, 0.0).xyz, textureLod(DOWNSCALEDX_raw, pos, 0.0).w + pow(Luma(textureLod(DOWNSCALEDX_raw, pos, 0.0).xyz), 2.0));
        W += w;
    }
    avg /= vec4(W);

    return vec4(avg.xyz, avg[3] - pow(Luma(avg.xyz), 2.0));
}

//!HOOK POSTKERNEL
//!BIND HOOKED
//!BIND PREKERNEL
//!BIND LOWRES
//!SAVE R
//!COMPONENTS 4

#define sqr(x)      pow(x,2.0)
#define GetH(x,y)   LOWRES_texOff(vec2(x,y))
#define GetL(x,y)   PREKERNEL_texOff(vec2(x,y))
#define spread      0.5

#define Gamma(x)    ( pow(max(x, 0.0), vec3(1.0/2.0)) )
#define Kb 0.0722
#define Kr 0.2126
#define Luma(rgb)   ( dot(vec3(Kr, 1.0 - Kr - Kb, Kb), rgb) )

vec4 hook() {
    if (PREKERNEL_size.y >= POSTKERNEL_size.y) return vec4(0);
    vec4 c0 = LOWRES_tex(LOWRES_pos);
    vec4 c1 = PREKERNEL_tex(PREKERNEL_pos);

    float varH = (sqr(Luma(GetH(-1, 0).rgb - c0.rgb)) + sqr(Luma(GetH(0, 1).rgb - c0.rgb)) + sqr(Luma(GetH(1, 0).rgb - c0.rgb)) + sqr(Luma(GetH(0, -1).rgb - c0.rgb))) * sqr(spread) / (1.0 + 4.0 * spread);
    float varL = (sqr(Luma(GetL(-1, 0).rgb - c1.rgb)) + sqr(Luma(GetL(0, 1).rgb - c1.rgb)) + sqr(Luma(GetL(1, 0).rgb - c1.rgb)) + sqr(Luma(GetL(0, -1).rgb - c1.rgb))) * sqr(spread) / (1.0 + 4.0 * spread);

    vec4 meanH = (GetH(0,0) + spread * (GetH(-1, 0) + GetH(0, 1) + GetH(1, 0) + GetH(0, -1)))/(1.0 + 4.0 * spread);
    vec4 meanL = (GetL(0,0) + spread * (GetL(-1, 0) + GetL(0, 1) + GetL(1, 0) + GetL(0, -1)))/(1.0 + 4.0 * spread);

    varH = clamp(varH - sqr(meanH.r - c0.r), 0.0, 1.0) + meanH.w + sqr(0.5/255.0);
    varL = clamp(varL - sqr(meanL.r - c1.r), 0.0, 1.0)           + sqr(0.5/255.0);

    float R = sqrt(varL/varH);

    return vec4(Gamma(meanH.rgb), R);
}

//!HOOK POSTKERNEL
//!BIND HOOKED
//!BIND PREKERNEL
//!BIND LOWRES
//!BIND R

// SuperRes final pass

#define strength  1.0

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
//#define GetY(x,y)   ( textureLod(LOWRES_raw, ddxddy*(pos+vec2(x,y)+0.5), 0.0).a )
#define GetOriginal(x,y)   ( textureLod(PREKERNEL_raw, ddxddy*(pos+vec2(x,y)+0.5), 0.0) )
#define GetR(x,y)   ( textureLod(R_raw, ddxddy*(pos+vec2(x,y)+0.5), 0.0) )
//Downsampled result
#define Lowres(x,y) ( textureLod(LOWRES_raw, ddxddy*(pos+vec2(x,y)+0.5), 0.0) )

#define Gamma(x)    ( pow(max(x, 0.0), vec3(1.0/2.0)) )
#define GammaInv(x) ( pow((x), vec3(2.0)) )
#define Kb 0.0722
#define Kr 0.2126
#define Luma(rgb)   ( dot(vec3(Kr, 1.0 - Kr - Kb, Kb), rgb) )

vec4 hook() {
    vec4 c0 = HOOKED_tex(HOOKED_pos);
    if (any(greaterThanEqual(LOWRES_size, HOOKED_size))) return c0;

    // Calculate position
    vec2 pos = HOOKED_pos * LOWRES_size - vec2(0.5);
    vec2 offset = pos - (even ? floor(pos) : round(pos));
    pos -= offset;

    // Calculate faithfulness force
    float weightSum = 0.0;
    vec3 diff = vec3(0);

    for (int X = minX; X <= maxX; X++)
    for (int Y = minX; Y <= maxX; Y++)
    {
        vec2 krnl = Kernel(vec2(X,Y) - offset);
        float weight = krnl.x * krnl.y / (sqr(Luma(c0.xyz - Lowres(X,Y).xyz)) + Lowres(X,Y).w + sqr(0.5/255.0));

        diff += weight * ((1.0 - GetR(X,Y).w)*Gamma(c0.xyz) - (Gamma(GetOriginal(X,Y).xyz) - GetR(X,Y).xyz*GetR(X,Y).w));
        weightSum += weight;
    }
    diff /= weightSum;
    c0.xyz = Gamma(c0.xyz);
    c0.xyz -= strength * diff;
	c0.xyz = GammaInv(c0.xyz);

    return c0;
}
