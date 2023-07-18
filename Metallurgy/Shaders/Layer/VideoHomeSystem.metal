#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// VIDEO HOME SYSTEM

// DESCRIPTION
// https://en.wikipedia.org/wiki/VHS

// LAYER EFFECT
// https://developer.apple.com/documentation/swiftui/view/layereffect(_:maxsampleoffset:isenabled:

// PORT
// https://www.shadertoy.com/view/Ms3XWH

float rand(float2 co)
{
    // DETERMINE A RANDOM NUMBER BASED ON THE COORDINATES USING THE SIN FUNCTION
    return fract(sin(dot(co.xy ,float2(12.9898,78.233))) * 43758.5453);
}

float vertical_bars(float pos, float uvY, float offset)
{
    // WE CREATE A RANGE VARIABLE TO STORE THE RANGE OF THE BARS
    float range = 0.05;

    // WE CREATE AN EDGE_A AND EDGE_B VARIABLE TO STORE THE EDGES OF THE BARS
    float edge_a = (pos - range);
    float edge_b = (pos + range);

    // WE CREATE AN X VARIABLE TO STORE THE X POSITION OF THE BARS
    float x = smoothstep(edge_a, pos, uvY) * offset;
    
    // WE ADD THE SMOOTHSTEP OF THE BARS TO THE X POSITION
    x -= smoothstep(pos, edge_b, uvY) * offset;
    
    // WE RETURN THE X POSITION
    return x;
}

[[ stitchable ]] half4 vhs(float2 position,
                           SwiftUI::Layer layer,
                           float time,
                           float noise_quality,
                           float noise_intensity,
                           float offset_intensity,
                           float color_offset_intensity,
                           float strength)
{
    
    // FIRST, WE STORE THE ORIGINAL COLOR
    half4 original_color = layer.sample(position);
    
    // WE CREATE A NEW COLOR VARIABLE TO STORE THE MODIFIED COLOR
    half4 new_color = original_color;
    
    // WE CREATE A UV VARIABLE TO STORE THE POSITION OF THE PIXEL
    float2 uv = position;
    
    // WE CREATE A LOOP TO CREATE THE VERTICAL BARS
    for (float i = 0.0; i < 0.71; i += 0.1313)
    {
        // WE CREATE A TIME OFFSET VARIABLE TO ANIMATE THE BARS
        float time_offset = time * i;
        
        // MUST DEFINE INTVAL OUTSIDE OF MODF
        float intval  = 1.7;
        
        // WE CREATE A POSITION VARIABLE TO STORE THE POSTION AT THAT TIME
        float position = modf(time_offset, intval);
        
        // WE CREATE AN OFFSET VARIABLE TO STORE THE OFFSET OF THE BARS
        float offset = sin(1.0 - tan(time * 0.24 * i));
        
        // MULTIPLY THE OFFSET BY THE OFFSET INTENSITY
        offset *= offset_intensity;
        
        // ADD THE VERTICAL BARS TO THE UV.
        uv.x += vertical_bars(position, uv.y, offset);
    }
    
    // WE CREATE A UV.Y VARIABLE TO STORE THE Y POSITION OF THE PIXEL
    float uv_y = uv.y;
    
    // WE MULTIPLY THE UV.Y BY THE NOISE QUALITY
    uv_y *= noise_quality;
    
    // WE FLOOR THE UV.Y.
    uv_y = float(int(uv_y)) * (1.0 / noise_quality);
    
    // WE CREATE A NOISE VARIABLE TO STORE THE NOISE OF THE PIXEL
    float noise = rand(float2(time * 0.1, uv_y));
    
    // WE ADD THE NOISE TO THE UV.X.
    uv.x += noise * noise_intensity;
    
    // WE CREATE AN OFFSET VARIABLE TO STORE THE OFFSET OF THE BARS
    float2 offset_r = float2(0.006 * sin(time), 0.0) * color_offset_intensity;
    float2 offset_g = float2(0.0073 * (cos(time * 0.97)), 0.0) * color_offset_intensity;
    
    // WE SAMPLE THE LAYER WITH THE OFFSETS
    new_color.r = layer.sample(uv + offset_r).r;
    new_color.g = layer.sample(uv + offset_g).g;
    new_color.b = layer.sample(uv).b;
    
    // WE RETURN THE MIX OF THE ORIGINAL COLOR AND THE NEW COLOR
    return half4(mix(original_color, new_color, strength));
}
