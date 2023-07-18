#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// POSTERIZE

// DESCRIPTION
// https://en.wikipedia.org/wiki/Posterization

// COLOR EFFECT
// https://developer.apple.com/documentation/swiftui/view/coloreffect(_:isenabled:)

half3 RGBToHSV( half3 RGB ){
    
    half4 k = half4(0.0, -1.0/3.0, 2.0/3.0, -1.0);
    half4 p = RGB.g < RGB.b ? half4(RGB.b, RGB.g, k.w, k.z) : half4(RGB.gb, k.xy);
    half4 q = RGB.r < p.x   ? half4(p.x, p.y, p.w, RGB.r) : half4(RGB.r, p.yzx);
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return half3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

half3 HSVToRGB( half3 HSV ){
    
    half4 k = half4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    half3 p = abs(fract(HSV.xxx + k.xyz) * 6.0 - k.www);
    return HSV.z * mix(k.xxx, clamp(p - k.xxx, 0.0, 1.0), HSV.y);
}

[[ stitchable ]] half4 posterize(float2 position, SwiftUI::Layer layer, float strength){
    
    float nColors =4.0;
    float vx_offset = 0.5;
    
    float2 uv = position;
    
    half3 tc = layer.sample(uv).rgb;
        
    float cutColor = 1./nColors;
    
    tc  = cutColor*floor(tc/cutColor);
    
    
    half4 x = half4(tc,layer.sample(uv).a);
    
    if(uv.x < (vx_offset-0.001))
    {
        tc = RGBToHSV(tc);
        
        half2 target_c = cutColor * floor(tc.gb/cutColor);
        
        tc = HSVToRGB(half3(tc.r,target_c));
    }
    
    if(tc.g > (tc.r + tc.b)*0.7)
    {
        tc.rgb = half3(0.2,0.2,0.2);
    }
    
    if (strength == 0.0)
    {
        return layer.sample(uv);
        
    }
    
    return mix(x,layer.sample(uv),strength * 10);
    
}
