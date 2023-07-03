//
//  Toon.metal
//  MetalShaderShowcases
//
//  Created by Raphael S on 27/06/2023.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;
float lum(half4 c) {
    
    return dot(c.rgb, half3(0.3, 0.59, 0.11));
}

[[ stitchable ]] half4 toon(float2 position, SwiftUI::Layer layer){
    float2 p = position;
    
    p.y= 1.0 - p.y;
    
    float2 imageIncrement = float2(1.0, 1.0);
    
    float t00 = lum(half4( p + imageIncrement * float2(-1.0, -1.0)));
    float t10 = lum(half4( p + imageIncrement * float2( 0.0, -1.0)));
    float t20 = lum(half4( p + imageIncrement * float2( 1.0, -1.0)));
    float t01 = lum(half4( p + imageIncrement * float2(-1.0,  0.0)));
    float t21 = lum(half4( p + imageIncrement * float2( 1.0,  0.0)));
    float t02 = lum(half4( p + imageIncrement * float2(-1.0,  1.0)));
    float t12 = lum(half4( p + imageIncrement * float2( 0.0,  1.0)));
    float t22 = lum(half4( p + imageIncrement * float2( 1.0,  1.0)));
    
    float2 grad;
    grad.x = t00 + 2.0 * t01 + t02 - t20 - 2.0 * t21 - t22;
    grad.y = t00 + 2.0 * t10 + t20 - t02 - 2.0 * t12 - t22;
    
    float len = length(grad);
    
    return half4( len, len, len, len);
}
