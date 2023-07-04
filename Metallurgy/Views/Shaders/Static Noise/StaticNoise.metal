#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;



float random (float2 noise)
{
    //--- Noise: Low Static (X axis) ---
    //return fract(sin(dot(noise.yx,float2(0.000128,0.233)))*804818480.159265359);
    
    //--- Noise: Low Static (Y axis) ---
    //return fract(sin(dot(noise.xy,float2(0.000128,0.233)))*804818480.159265359);
    
      //--- Noise: Low Static Scanlines (X axis) ---
    //return fract(sin(dot(noise.xy,float2(98.233,0.0001)))*925895933.14159265359);
    
       //--- Noise: Low Static Scanlines (Y axis) ---
    //return fract(sin(dot(noise.xy,float2(0.0001,98.233)))*925895933.14159265359);
    
    //--- Noise: High Static Scanlines (X axis) ---
    //return fract(sin(dot(noise.xy,float2(0.0001,98.233)))*12073103.285);
    
    //--- Noise: High Static Scanlines (Y axis) ---
    //return fract(sin(dot(noise.xy,float2(98.233,0.0001)))*12073103.285);
    
    //--- Noise: Full Static ---
    return fract(sin(dot(noise.xy,float2(10.998,98.233)))*12433.14159265359);
}


float random_colour (float noise)
{
    return fract(sin(noise));
}


[[ stitchable ]] half4 tape(float2 position, SwiftUI::Layer layer, float time, float strength){
    float maxStrength = 0.5 * 2;
    float minStrength = 0.4 * 2;

    float speed = 10.00;
    
    float2 uv = position;
    float2 uv2 = fract(position * fract(sin(time * speed)));
    
    //--- Strength animate ---
    maxStrength = clamp(sin(time/2.0),minStrength,maxStrength);
    //-----------------------
    
    //--- Black and white ---
    half3 colour = half3(random(uv2.xy))*maxStrength;
    //-----------------------
        
    /*
    //--- Colour ---
    colour.r *= random_colour(sin(time * speed));
    colour.g *= random_colour(cos(time * speed));
    colour.b *= random_colour(tan(time * speed));
    //--------------
    */
    
    //--- Background ---
    half3 background = layer.sample(uv).rgb;
    //--------------
    
    return half4(
                 background-colour,
                 layer.sample(uv).a
                 );
}
