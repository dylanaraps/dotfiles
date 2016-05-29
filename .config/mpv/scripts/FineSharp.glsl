//!HOOK NATIVE
//!BIND HOOKED
//!COMPONENTS 4
// RemoveGrain(11,-1) equivalent by -Vit-

#define Src(a,b) HOOKED_texOff(vec2(a,b))

vec4 hook() {
	vec4 o = Src(0,0).xyzx;
	o.x += o.x;
	o.x += Src( 0,-1).x+Src(-1, 0).x+Src( 1, 0).x+Src( 0, 1).x;
	o.x += o.x;
	o.x += Src(-1,-1).x+Src( 1,-1).x+Src(-1, 1).x+Src( 1, 1).x;
	o.x *= 0.0625f;

	return o;
}

//!HOOK NATIVE
//!BIND HOOKED
// RemoveGrain(4,-1) equivalent by -Vit-

#define Src(a,b) HOOKED_texOff(vec2(a,b))

// The variables passed to these median macros will be swapped around as part of the process. A temporary variable t of the same type is also required.
#define sort(a1,a2)                         (t=min(a1,a2),a2=max(a1,a2),a1=t)
#define median3(a1,a2,a3)                   (sort(a2,a3),sort(a1,a2),min(a2,a3))
#define median5(a1,a2,a3,a4,a5)             (sort(a1,a2),sort(a3,a4),sort(a1,a3),sort(a2,a4),median3(a2,a3,a5))
#define median9(a1,a2,a3,a4,a5,a6,a7,a8,a9) (sort(a1,a2),sort(a3,a4),sort(a5,a6),sort(a7,a8),\
                                             sort(a1,a3),sort(a5,a7),sort(a1,a5),sort(a3,a5),sort(a3,a7),\
                                             sort(a2,a4),sort(a6,a8),sort(a4,a8),sort(a4,a6),sort(a2,a6),median5(a2,a4,a5,a7,a9))

vec4 hook() {
	vec4 o = Src(0,0);

	float t;
	float t1 = Src(-1,-1).x;
	float t2 = Src( 0,-1).x;
	float t3 = Src( 1,-1).x;
	float t4 = Src(-1, 0).x;
	float t5 = o.x;
	float t6 = Src( 1, 0).x;
	float t7 = Src(-1, 1).x;
	float t8 = Src( 0, 1).x;
	float t9 = Src( 1, 1).x;
	o.x = median9(t1,t2,t3,t4,t5,t6,t7,t8,t9);
	
	return o;
}

//!HOOK NATIVE
//!BIND HOOKED
// FineSharp by Didйe

#define sstr 1.0   // Strength of sharpening, 0.0 up to 8.0 or more. If you change this, then alter cstr below
#define cstr 1.0   // Strength of equalisation, 0.0 to 2.0 or more. Suggested settings for cstr based on sstr value (if antiring is 0): 
                   // sstr=0->cstr=0, sstr=0.5->cstr=0.1, 1.0->0.6, 2.0->0.9, 2.5->1.00, 3.0->1.09, 3.5->1.15, 4.0->1.19, 8.0->1.249, 255.0->1.5
#define lstr 1.49  // Modifier for non-linear sharpening
#define pstr 1.272 // Exponent for non-linear sharpening
#define ldmp (sstr+0.1f) // "Low damp", to not over-enhance very small differences (noise coming out of flat areas)

// To use the "mode" setting in original you must change shaders earlier in chain: mode=1->RG11 RG4, mode=2->RG4 RG11, mode=3->RG4 RG11 RG4
// Negative modes are not supported

#define Src(a,b) HOOKED_texOff(vec2(a,b))
#define SharpDiff(c) (t=c.a-c.x, sign(t) * (sstr/255.0f) * pow(abs(t)/(lstr/255.0f),1.0f/pstr)* ((t*t)/(t*t+ldmp/(255.0f*255.0f))))

vec4 hook() {
    vec4 o = Src(0,0);
    vec4 x1 = Src(0,-1);
    vec4 x2 = Src(-1,0);
    vec4 x3 = Src(1,0);
    vec4 x4 = Src(0,1);
    vec4 x5 = Src(-1, -1);
    vec4 x6 = Src( 1,-1);
    vec4 x7 = Src(-1, 1);
    vec4 x8 = Src( 1, 1);
    float t;
    float sd = SharpDiff(o);
    o.x = o.a + sd;
    sd += sd;
    sd += SharpDiff(x1) + SharpDiff(x2) + SharpDiff(x3) + SharpDiff(x4);
    sd += sd;
    sd += SharpDiff(x5) + SharpDiff(x6) + SharpDiff(x7) + SharpDiff(x8);
    sd *= 0.0625f;
    o.x -= cstr * sd;
    //o.a = o.x;
    return o;
}
