//!HOOK SCALED
//!BIND HOOKED
//!SAVE BW

vec4 hook() {
    vec4 o = HOOKED_tex(HOOKED_pos);
    o.xyz = vec3(1.0 - dot(vec3(0.3, 0.59, 0.11), o.xyz));
    return o;
}

//!HOOK SCALED
//!BIND BW
//!SAVE BW

vec4 hook() {
    vec4 color = vec4(0.0,0.0,0.0,0.0);
 
    const float gauss0 = 1.0/32.0;
    const float gauss1 = 5.0/32.0;
    const float gauss2 =15.0/32.0;
    const float gauss3 =22.0/32.0;
    const float gauss4 =15.0/32.0;
    const float gauss5 = 5.0/32.0;
    const float gauss6 = 1.0/32.0;   
 
    vec4 gaussFilter[7];
    gaussFilter[0]  = vec4( -3.0*BW_pt.x, 0.0, 0.0, gauss0);
    gaussFilter[1]  = vec4( -2.0*BW_pt.x, 0.0, 0.0, gauss1);
    gaussFilter[2]  = vec4( -1.0*BW_pt.x, 0.0, 0.0, gauss2);
    gaussFilter[3]  = vec4(  0.0*BW_pt.x, 0.0, 0.0, gauss3);
    gaussFilter[4]  = vec4( +1.0*BW_pt.x, 0.0, 0.0, gauss4);
    gaussFilter[5]  = vec4( +2.0*BW_pt.x, 0.0, 0.0, gauss5);
    gaussFilter[6]  = vec4( +3.0*BW_pt.x, 0.0, 0.0, gauss6);
 
    int i;
    for (i=0;i<7;i++)
       color += texture(BW_raw, BW_pos + gaussFilter[i].xy) * gaussFilter[i].w;
 
    return color*0.5;
 }

//!HOOK SCALED
//!BIND BW
//!SAVE BW

vec4 hook() {
	vec4 color = vec4(0.0,0.0,0.0,0.0);
 
    const float gauss0 = 1.0/32.0;
    const float gauss1 = 5.0/32.0;
    const float gauss2 =15.0/32.0;
    const float gauss3 =22.0/32.0;
    const float gauss4 =15.0/32.0;
    const float gauss5 = 5.0/32.0;
    const float gauss6 = 1.0/32.0;   
 
    vec4 gaussFilter[7];
    gaussFilter[0]  = vec4( -3.0*BW_pt.y, 0.0, 0.0, gauss0).yxzw;
    gaussFilter[1]  = vec4( -2.0*BW_pt.y, 0.0, 0.0, gauss1).yxzw;
    gaussFilter[2]  = vec4( -1.0*BW_pt.y, 0.0, 0.0, gauss2).yxzw;
    gaussFilter[3]  = vec4(  0.0*BW_pt.y, 0.0, 0.0, gauss3).yxzw;
    gaussFilter[4]  = vec4( +1.0*BW_pt.y, 0.0, 0.0, gauss4).yxzw;
    gaussFilter[5]  = vec4( +2.0*BW_pt.y, 0.0, 0.0, gauss5).yxzw;
    gaussFilter[6]  = vec4( +3.0*BW_pt.y, 0.0, 0.0, gauss6).yxzw;
 
    for (int i=0;i<7;i++)
       color += texture(BW_raw, BW_pos + gaussFilter[i].xy) * gaussFilter[i].w;
 
    return color*0.5;
 }

 //!HOOK SCALED
//!BIND BW
//!SAVE BW

vec4 hook() {
    vec4 color = vec4(0.0,0.0,0.0,0.0);
 
    const float gauss0 = 1.0/32.0;
    const float gauss1 = 5.0/32.0;
    const float gauss2 =15.0/32.0;
    const float gauss3 =22.0/32.0;
    const float gauss4 =15.0/32.0;
    const float gauss5 = 5.0/32.0;
    const float gauss6 = 1.0/32.0;   
 
    vec4 gaussFilter[7];
    gaussFilter[0]  = vec4( -3.0*BW_pt.x, 0.0, 0.0, gauss0);
    gaussFilter[1]  = vec4( -2.0*BW_pt.x, 0.0, 0.0, gauss1);
    gaussFilter[2]  = vec4( -1.0*BW_pt.x, 0.0, 0.0, gauss2);
    gaussFilter[3]  = vec4(  0.0*BW_pt.x, 0.0, 0.0, gauss3);
    gaussFilter[4]  = vec4( +1.0*BW_pt.x, 0.0, 0.0, gauss4);
    gaussFilter[5]  = vec4( +2.0*BW_pt.x, 0.0, 0.0, gauss5);
    gaussFilter[6]  = vec4( +3.0*BW_pt.x, 0.0, 0.0, gauss6);
 
    int i;
    for (i=0;i<7;i++)
       color += texture(BW_raw, BW_pos + gaussFilter[i].xy) * gaussFilter[i].w;
 
    return color*0.5;
 }

//!HOOK SCALED
//!BIND BW
//!SAVE BW

vec4 hook() {
	vec4 color = vec4(0.0,0.0,0.0,0.0);
 
    const float gauss0 = 1.0/32.0;
    const float gauss1 = 5.0/32.0;
    const float gauss2 =15.0/32.0;
    const float gauss3 =22.0/32.0;
    const float gauss4 =15.0/32.0;
    const float gauss5 = 5.0/32.0;
    const float gauss6 = 1.0/32.0;   
 
    vec4 gaussFilter[7];
    gaussFilter[0]  = vec4( -3.0*BW_pt.y, 0.0, 0.0, gauss0).yxzw;
    gaussFilter[1]  = vec4( -2.0*BW_pt.y, 0.0, 0.0, gauss1).yxzw;
    gaussFilter[2]  = vec4( -1.0*BW_pt.y, 0.0, 0.0, gauss2).yxzw;
    gaussFilter[3]  = vec4(  0.0*BW_pt.y, 0.0, 0.0, gauss3).yxzw;
    gaussFilter[4]  = vec4( +1.0*BW_pt.y, 0.0, 0.0, gauss4).yxzw;
    gaussFilter[5]  = vec4( +2.0*BW_pt.y, 0.0, 0.0, gauss5).yxzw;
    gaussFilter[6]  = vec4( +3.0*BW_pt.y, 0.0, 0.0, gauss6).yxzw;
 
    for (int i=0;i<7;i++)
       color += texture(BW_raw, BW_pos + gaussFilter[i].xy) * gaussFilter[i].w;
 
    return color*0.5;
 }

 //!HOOK SCALED
//!BIND BW
//!SAVE BW

vec4 hook() {
    vec4 color = vec4(0.0,0.0,0.0,0.0);
 
    const float gauss0 = 1.0/32.0;
    const float gauss1 = 5.0/32.0;
    const float gauss2 =15.0/32.0;
    const float gauss3 =22.0/32.0;
    const float gauss4 =15.0/32.0;
    const float gauss5 = 5.0/32.0;
    const float gauss6 = 1.0/32.0;   
 
    vec4 gaussFilter[7];
    gaussFilter[0]  = vec4( -3.0*BW_pt.x, 0.0, 0.0, gauss0);
    gaussFilter[1]  = vec4( -2.0*BW_pt.x, 0.0, 0.0, gauss1);
    gaussFilter[2]  = vec4( -1.0*BW_pt.x, 0.0, 0.0, gauss2);
    gaussFilter[3]  = vec4(  0.0*BW_pt.x, 0.0, 0.0, gauss3);
    gaussFilter[4]  = vec4( +1.0*BW_pt.x, 0.0, 0.0, gauss4);
    gaussFilter[5]  = vec4( +2.0*BW_pt.x, 0.0, 0.0, gauss5);
    gaussFilter[6]  = vec4( +3.0*BW_pt.x, 0.0, 0.0, gauss6);
 
    int i;
    for (i=0;i<7;i++)
       color += texture(BW_raw, BW_pos + gaussFilter[i].xy) * gaussFilter[i].w;
 
    return color*0.5;
 }

//!HOOK SCALED
//!BIND BW
//!SAVE BW

vec4 hook() {
	vec4 color = vec4(0.0,0.0,0.0,0.0);
 
    const float gauss0 = 1.0/32.0;
    const float gauss1 = 5.0/32.0;
    const float gauss2 =15.0/32.0;
    const float gauss3 =22.0/32.0;
    const float gauss4 =15.0/32.0;
    const float gauss5 = 5.0/32.0;
    const float gauss6 = 1.0/32.0;   
 
    vec4 gaussFilter[7];
    gaussFilter[0]  = vec4( -3.0*BW_pt.y, 0.0, 0.0, gauss0).yxzw;
    gaussFilter[1]  = vec4( -2.0*BW_pt.y, 0.0, 0.0, gauss1).yxzw;
    gaussFilter[2]  = vec4( -1.0*BW_pt.y, 0.0, 0.0, gauss2).yxzw;
    gaussFilter[3]  = vec4(  0.0*BW_pt.y, 0.0, 0.0, gauss3).yxzw;
    gaussFilter[4]  = vec4( +1.0*BW_pt.y, 0.0, 0.0, gauss4).yxzw;
    gaussFilter[5]  = vec4( +2.0*BW_pt.y, 0.0, 0.0, gauss5).yxzw;
    gaussFilter[6]  = vec4( +3.0*BW_pt.y, 0.0, 0.0, gauss6).yxzw;
 
    for (int i=0;i<7;i++)
       color += texture(BW_raw, BW_pos + gaussFilter[i].xy) * gaussFilter[i].w;
 
    return color*0.5;
 }

//!HOOK SCALED
//!BIND HOOKED
//!BIND BW

#define Blend(base, blend, funcf) 	vec3(funcf(base.r, blend.r), funcf(base.g, blend.g), funcf(base.b, blend.b))

#define BlendLinearLightf(base, blend) 	mix(max(base + blend - 1.0, 0.0), min(base + blend, 1.0), step(0.5, blend))
#define BlendLinearLight(base, blend) 	Blend(base, blend, BlendLinearLightf)

#define BlendOverlayf(base, blend) 	mix(2.0 * base * blend, 1.0 - 2.0 * (1.0 - base) * (1.0 - blend), step(0.5, base))
#define BlendOverlay(base, blend) 	Blend(base, blend, BlendOverlayf)

#define BlendSoftLightf(base, blend) 	((blend < 0.5) ? (2.0 * base * blend + base * base * (1.0 - 2.0 * blend)) : (sqrt(base) * (2.0 * blend - 1.0) + 2.0 * base * (1.0 - blend)))
#define BlendSoftLight(base, blend) 	Blend(base, blend, BlendSoftLightf)

vec4 hook() {
	vec4 o = HOOKED_tex(HOOKED_pos);
	vec4 bw = BW_tex(BW_pos);
	vec3 obw = BlendOverlay(o.xyz, bw.xyz);
	o.xyz = mix(BlendSoftLight(obw, o.xyz), obw, 0.4);
	return o;
}