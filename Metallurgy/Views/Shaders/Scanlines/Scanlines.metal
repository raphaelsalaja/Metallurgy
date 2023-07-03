#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

float rand(float2 p, float time)
{
    float t = floor(time * 20.) / 10.;
    return fract(sin(dot(p, float2(t * 12.9898, t * 78.233))) * 43758.5453);
}

float noise(float2 uv, float blockiness, float time)
{
    float2 lv = fract(uv);
    float2 id = floor(uv);
    
    float n1 = rand(id, time);
    float n2 = rand(id+float2(1,0), time);
    float n3 = rand(id+float2(0,1), time);
    float n4 = rand(id+float2(1,1), time);
    
    float2 u = smoothstep(0.0, 1.0 + blockiness, lv);

    return mix(mix(n1, n2, u.x), mix(n3, n4, u.x), u.y);
}

float fbm(float2 uv, int count, float blockiness, float complexity, float time)
{
    float val = 0.0;
    float amp = 0.5;
    
    while(count != 0)
    {
        val += amp * noise(uv, blockiness, time);
        amp *= 0.5;
        uv *= complexity;
        count--;
    }
    
    return val;
}



[[ stitchable ]] half4 vhs(float2 position, SwiftUI::Layer layer, float time){
    const float glitchAmplitude = 0.2; // increase this
    const float glitchNarrowness = 4.0;
    const float glitchBlockiness = 2.0;
    const float glitchMinimizer = 5.0; // decrease this
    
    // Normalized pixel coordinates (from 0 to 1)
    float2 uv = position.xy;
    float2 a = float2(uv.x * (position.x/position.y), uv.y);
    float2 uv2 = float2(a.x / position.x, exp(a.y));
    float2 id = floor(uv * 8.0);
    //id.x /= floor(texture(iChannel0, float2(id / 8.0)).r * 8.0);
    
    // Generate shift amplitude
    float shift = glitchAmplitude * pow(fbm(uv2, int(rand(id, time) * 6.), glitchBlockiness, glitchNarrowness, time), glitchMinimizer);
    
    // Create a scanline effect
    float scanline = abs(cos(uv.y * 400.));
    scanline = smoothstep(0.0, 2.0, scanline);
    shift = smoothstep(0.00001, 0.2, shift);
    
    // Apply glitch and RGB shift
    //    float colR = texture(iChannel0, float2(uv.x + shift, uv.y)).r * (1. - shift) ;
    //    float colG = texture(iChannel0, float2(uv.x - shift, uv.y)).g * (1. - shift) + rand(id) * shift;
    //    float colB = texture(iChannel0, float2(uv.x - shift, uv.y)).b * (1. - shift);
    
    float colR = layer.sample(position + float2(shift, 0.0)).r * (1. - shift);
    float colG = layer.sample(position + float2(-shift, 0.0)).g * (1. - shift) + rand(id, time) * shift;
    float colB = layer.sample(position + float2(-shift, 0.0)).b * (1. - shift);
    
    
    // Mix with the scanline effect
    half3 f = half3(colR, colG, colB) - (0.1 * scanline);
    
    // Output to screen
    return half4(f,1.0) * layer.sample(position).a;
}
