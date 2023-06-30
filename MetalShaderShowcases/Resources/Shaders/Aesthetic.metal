#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;


float2 crt_coords(float2 uv, float bend)
{
    uv -= 0.5;
    uv *= 2.;
    uv.x *= 1. + pow(abs(uv.y)/bend, 2.);
    uv.y *= 1. + pow(abs(uv.x)/bend, 2.);
    
    uv /= 2.5;
    return uv + .5;
}

float vignette(float2 uv, float size, float smoothness, float edgeRounding)
{
    uv -= .5;
    uv *= size;
    float amount = sqrt(pow(abs(uv.x), edgeRounding) + pow(abs(uv.y), edgeRounding));
    amount = 1. - amount;
    return smoothstep(0.1, smoothness, amount);
}

float scanline(float2 uv, float lines, float speed, float time)
{
    return sin(uv.y * lines + time * speed);
}

float random(float2 uv, float time)
{
     return fract(sin(dot(uv, float2(15.5151, 42.2561))) * 12341.14122 * sin(time * 0.03));
}

float noise(float2 uv, float time)
{
    float2 i = floor(uv);
    float2 f = fract(uv);
    
    float a = random(i, time);
    float b = random(i + float2(1.,0.), time);
    float c = random(i + float2(0., 1.), time);
    float d = random(i + float2(1.), time);
    
    float2 u = smoothstep(0., 1., f);
    
    return mix(a,b, u.x) + (c - a) * u.y * (1. - u.x) + (d - b) * u.x * u.y;
}

[[ stitchable ]] half4 vhs(float2 position, SwiftUI::Layer layer, float time){
    float2 uv = position;
    float2 crt_uv = crt_coords(uv, 20.);
    
    float s1 = scanline(uv, 200, -10., time);
    float s2 = scanline(uv, 20, -5., time);
    
    half4 col;
    
    //  col.r = texture(iChannel0, crt_uv + float2(0., 0.01)).r;
    //  col.g = texture(iChannel0, crt_uv).r;
    //  col.b = texture(iChannel0, crt_uv + float2(0., -0.01)).b;
    //  col.a = texture(iChannel0, crt_uv).a;
    
    col.r = layer.sample(crt_uv + float2(0., 0.01)).r;
    col.g = layer.sample(crt_uv).g;
    col.b = layer.sample(crt_uv + float2(0., -0.01)).b;
    col.a = layer.sample(crt_uv).a;
    
    col = mix(col, half4(s1 + s2), 0.5);
    
    half4 effect = mix(col, half4(noise(uv * 75. , time)), 0.05);
    effect *= vignette(uv, 1.2, 0.1, 2.);
    
    half4 final = mix(layer.sample(position), effect, col.a);
    
    return final;

}

 
