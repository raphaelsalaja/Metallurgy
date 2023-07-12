#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

float rand(float2 co)
{
    return fract(sin(dot(co.xy ,float2(12.9898,78.233))) * 43758.5453);
}

float verticalBar(float pos, float uvY, float offset)
{
    float range = 0.05;

    float edge0 = (pos - range);
    float edge1 = (pos + range);

    float x = smoothstep(edge0, pos, uvY) * offset;
    x -= smoothstep(pos, edge1, uvY) * offset;
    
    return x;
}

[[ stitchable ]] half4 vhs(float2 position, SwiftUI::Layer layer, float time, float noise_quality, float noise_intensity, float offset_intensity, float color_offset_intensity, float strength)
{
    float2 uv = position;
    
    for (float i = 0.0; i < 0.71; i += 0.1313)
    {
        float time_offset = time * i;
        float f  = 1.7;
        
        float d = modf(time_offset, f);
        float o = sin(1.0 - tan(time * 0.24 * i));
        
        o *= offset_intensity;
        uv.x += verticalBar(d, uv.y, o);
    }
    
    float uvY = uv.y;
    
    uvY *= noise_quality;
    uvY = float(int(uvY)) * (1.0 / noise_quality);
    float noise = rand(float2(time * 0.1, uvY));
    uv.x += noise * noise_intensity;
    
    float2 offsetR = float2(0.006 * sin(time), 0.0) * color_offset_intensity;
    float2 offsetG = float2(0.0073 * (cos(time * 0.97)), 0.0) * color_offset_intensity;
    
    float r = layer.sample( uv + offsetR ).r;
    float g = layer.sample( uv + offsetG ).g;
    float b = layer.sample( uv ).b;
    float a = layer.sample( uv ).a;
    
    half4 tex = half4(r, g, b,a);
    
    tex = half4(mix(layer.sample(uv), tex, strength));
    
    return tex;
}
