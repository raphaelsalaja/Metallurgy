#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// TV STATIC

// DESCRIPTION
// https://en.wikipedia.org/wiki/Noise_(video)

// LAYER EFFECT
// https://developer.apple.com/documentation/swiftui/view/layereffect(_:maxsampleoffset:isenabled:

// PORT
// https://www.shadertoy.com/view/tsX3RN

float random(float2 noise)
{

    return fract(sin(dot(noise.xy,float2(10.998,98.233))) * 12433.14159265359);
}


float random_colour(float noise)
{
    return fract(sin(noise));
}


[[ stitchable ]] half4 tv_static(float2 position, SwiftUI::Layer layer, float time, float strength){
    
    // DEFINE VARIABLES TO HANDLE MAX AND MIN STRENGTH
    float max_strength = 0.5 * 2;
    float min_strength = 0.4 * 2;

    // HOLD A VARIABLE FOR SPEED
    float speed = 10.00;
    
    // HOLD THE ORIGINAL UV AND THE UV FRACT
    float2 uv_1 = position;
    float2 uv_2 = fract(position * fract(sin(time * speed)));
    
    // ANIMATE THE STRENGTH RELATIVE TO TIME
    max_strength = clamp(sin(time/2.0),min_strength,max_strength);

    // GREYSCALE THE IMAGE
    half3 new_color = half3(random(uv_2.xy))*max_strength;

    
    // RANDOM COLOR ~ COMMENT OUT TO REMOVE COLOR
    new_color.r *= random_colour(sin(time * speed));
    new_color.g *= random_colour(cos(time * speed));
    new_color.b *= random_colour(tan(time * speed));
    
    half3 background = layer.sample(uv_1).rgb;
    
    return half4(background - new_color, layer.sample(uv_1).a);
}
