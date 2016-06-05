// vim: set ft=glsl:

/*
    LumaSharpenHook 0.3

    original hlsl by Christian Cann Schuldt Jensen ~ CeeJay.dk
    port to glsl by Anon

    It blurs the original pixel with the surrounding pixels and then subtracts this blur to sharpen the image.
    It does this in luma to avoid color artifacts and allows limiting the maximum sharpning to avoid or lessen halo artifacts.

    This is similar to using Unsharp Mask in Photoshop.
*/

// -- Hooks --
//!HOOK LUMA
//!BIND HOOKED


// -- Sharpening --
#define sharp_strength 0.30   //[0.10 to 3.00] Strength of the sharpening

#define sharp_clamp    0.035  //[0.000 to 1.000] Limits maximum amount of sharpening a pixel recieves - Default is 0.035

// -- Advanced sharpening settings --
#define pattern 2        //[1|2|3|4] Choose a sample pattern. 1 = Fast, 2 = Normal, 3 = Wider, 4 = Pyramid shaped.
                         //[8|9] Experimental slower patterns. 8 = 9 tap 9 fetch gaussian, 9 = 9 tap 9 fetch high pass.
                         
#define offset_bias 1.0  //[0.0 to 6.0] Offset bias adjusts the radius of the sampling pattern.

vec4 hook(){
    vec4 colorInput = LUMA_tex(LUMA_pos);
    
    
    //We are on luma plane: xyzw = [luma_val, 0.0, 0.0, 1.0]
    float ori = colorInput.x;
    
    // -- Combining the strength and luma multipliers --
    float sharp_strength_luma = sharp_strength; //I'll be combining even more multipliers with it later on
    
    float px = 1.0;
    float py = 1.0;
    
    //                       Sampling patterns                     
  
    //   [ NW,   , NE ] Each texture lookup (except ori)
    //   [   ,ori,    ] samples 4 pixels
    //   [ SW,   , SE ]

    // -- Pattern 1 -- A (fast) 7 tap gaussian using only 2+1 texture fetches.
    #if pattern == 1

        // -- Gaussian filter --
        //   [ 1/9, 2/9,    ]     [ 1 , 2 ,   ]
        //   [ 2/9, 8/9, 2/9]  =  [ 2 , 8 , 2 ]
        //   [    , 2/9, 1/9]     [   , 2 , 1 ]
        
        px = (px / 3.0) * offset_bias;
        py = (py / 3.0) * offset_bias;
        
        float blur_ori = LUMA_texOff(vec2(px,py)).x;  // North West
        blur_ori += LUMA_texOff(vec2(-px,-py)).x; // South East
        
        //blur_ori += LUMA_texOff(vec2(px,py)).x; // North East
        //blur_ori += LUMA_texOff(vec2(-px,-py)).x; // South West
        
        blur_ori *= 0.5;  //Divide by the number of texture fetches

        sharp_strength_luma *= 1.5; // Adjust strength to aproximate the strength of pattern 2
    #endif
  
    // -- Pattern 2 -- A 9 tap gaussian using 4+1 texture fetches.
    #if pattern == 2
        // -- Gaussian filter --
        //   [ .25, .50, .25]     [ 1 , 2 , 1 ]
        //   [ .50,   1, .50]  =  [ 2 , 4 , 2 ]
        //   [ .25, .50, .25]     [ 1 , 2 , 1 ]
        
        px = px * 0.5 * offset_bias;
        py = py * 0.5 * offset_bias;
        
        float blur_ori = LUMA_texOff(vec2(px,-py)).x; // South East
        blur_ori += LUMA_texOff(vec2(-px,-py)).x;  // South West
        blur_ori += LUMA_texOff(vec2(px,py)).x; // North East
        blur_ori += LUMA_texOff(vec2(-px,py)).x; // North West
        
        blur_ori *= 0.25;  // ( /= 4) Divide by the number of texture fetches
    #endif
     
    // -- Pattern 3 -- An experimental 17 tap gaussian using 4+1 texture fetches.
    #if pattern == 3

        // -- Gaussian filter --
        //   [   , 4 , 6 ,   ,   ]
        //   [   ,16 ,24 ,16 , 4 ]
        //   [ 6 ,24 ,   ,24 , 6 ]
        //   [ 4 ,16 ,24 ,16 ,   ]
        //   [   ,   , 6 , 4 ,   ]
        
        px = px * offset_bias;
        py = py * offset_bias;

        float blur_ori = LUMA_texOff(vec2(0.4*px,-1.2*py)).x;  // South South East
        blur_ori += LUMA_texOff(vec2(-1.2*px,-0.4*py)).x; // West South West
        blur_ori += LUMA_texOff(vec2(1.2*px,0.4*py)).x; // East North East
        blur_ori += LUMA_texOff(vec2(-0.4*px,1.2*py)).x; // North North West
         
        blur_ori *= 0.25;  // ( /= 4) Divide by the number of texture fetches
        
        sharp_strength_luma *= 0.51;
  #endif
  
    // -- Pattern 4 -- A 9 tap high pass (pyramid filter) using 4+1 texture fetches.
    #if pattern == 4
        // -- Gaussian filter --
        //   [ .50, .50, .50]     [ 1 , 1 , 1 ]
        //   [ .50,    , .50]  =  [ 1 ,   , 1 ]
        //   [ .50, .50, .50]     [ 1 , 1 , 1 ]
        
        float blur_ori = LUMA_texOff(vec2(0.5 * px,-py * offset_bias)).x;  // South South East
        blur_ori += LUMA_texOff(vec2(offset_bias * -px,0.5 * -py)).x; // West South West
        blur_ori += LUMA_texOff(vec2(offset_bias * px,0.5 * py)).x; // East North East
        blur_ori += LUMA_texOff(vec2(0.5 * -px,py * offset_bias)).x; // North North West
        
        //blur_ori += (2.0 * ori); // Probably not needed. Only serves to lessen the effect.
        
        blur_ori *= 0.25;  //Divide by the number of texture fetches

        sharp_strength_luma *= 0.666; // Adjust strength to aproximate the strength of pattern 2
    #endif
    
    // -- Pattern 8 -- A (slower) 9 tap gaussian using 9 texture fetches.
    #if pattern == 8
        
        // -- Gaussian filter --
        //   [ 1 , 2 , 1 ]
        //   [ 2 , 4 , 2 ]
        //   [ 1 , 2 , 1 ]
        
        px = px * offset_bias;
        py = py * offset_bias;
        
        float blur_ori = LUMA_texOff(vec2(-px,py)).x; // North West
        blur_ori += LUMA_texOff(vec2(px,-py)).x;     // South East
        blur_ori += LUMA_texOff(vec2(-px,-py)).x;  // South West
        blur_ori += LUMA_texOff(vec2(px,py)).x;    // North East
        
        float blur_ori2 = LUMA_texOff(vec2(0.0,py)).x; // North
        blur_ori2 += LUMA_texOff(vec2(0.0,-py)).x;    // South
        blur_ori2 += LUMA_texOff(vec2(-px,0.0)).x;   // West
        blur_ori2 += LUMA_texOff(vec2(px,0.0)).x;   // East
        blur_ori2 *= 2.0;
        
        blur_ori += blur_ori2;
        blur_ori += (ori * 4.0); // Probably not needed. Only serves to lessen the effect.
        
        // dot()s with gaussian strengths here?
        
        blur_ori /= 16.0;  //Divide by the number of texture fetches
        
        sharp_strength_luma *= 0.75; // Adjust strength to aproximate the strength of pattern 2
    #endif
    
    // -- Pattern 9 -- A (slower) 9 tap high pass using 9 texture fetches.
    #if pattern == 9
        
        // -- Gaussian filter --
        //   [ 1 , 1 , 1 ]
        //   [ 1 , 1 , 1 ]
        //   [ 1 , 1 , 1 ]
        
        px = px * offset_bias;
        py = py * offset_bias;
        
        float blur_ori = LUMA_texOff(vec2(-px,py)).x; // North West
        blur_ori += LUMA_texOff(vec2(px,-py)).x;     // South East
        blur_ori += LUMA_texOff(vec2(-px,-py)).x;  // South West
        blur_ori += LUMA_texOff(vec2(px,py)).x;    // North East
        
        blur_ori += ori; // Probably not needed. Only serves to lessen the effect.
        
        blur_ori += LUMA_texOff(vec2(0.0,py)).x;    // North
        blur_ori += LUMA_texOff(vec2(0.0,-py)).x;  // South
        blur_ori += LUMA_texOff(vec2(-px,0.0)).x; // West
        blur_ori += LUMA_texOff(vec2(px,0.0)).x; // East
        
        blur_ori /= 9.0;  //Divide by the number of texture fetches
        
        sharp_strength_luma *= (8.0/9.0); // Adjust strength to aproximate the strength of pattern 2
    #endif
    
    // -- Calculate the sharpening --
    float sharp = ori - blur_ori;  //Subtracting the blurred image from the original image
    
    // -- Adjust strength of the sharpening and clamp it--
    float sharp_strength_luma_clamp = sharp_strength_luma / (2.0 * sharp_clamp); //Roll part of the clamp into the dot
    
    float sharp_luma = clamp((sharp * sharp_strength_luma_clamp + 0.5), 0.0,1.0 ); //Calculate the luma, adjust the strength, scale up and clamp
    sharp_luma = (sharp_clamp * 2.0) * sharp_luma - sharp_clamp; //scale down


    // -- Combining the values to get the final sharpened pixel --

    colorInput.x = colorInput.x + sharp_luma;    // Add the sharpening to the input color.
    return clamp(colorInput, 0.0,1.0);
}
