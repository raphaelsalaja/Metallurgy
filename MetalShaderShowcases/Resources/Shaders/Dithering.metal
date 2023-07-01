#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// Creator: kbjwes77
// Porter: Raphael Salaja
// Source: https://www.shadertoy.com/view/WstXR8
// Category: Layer
[[ stitchable ]] half4 dithering(float2 position, SwiftUI::Layer layer, float strength) {
    half4x4 bayerIndex;
    
    bayerIndex[0] = half4(00.0/16.0, 12.0/16.0, 03.0/16.0, 15.0/16.0);
    bayerIndex[1] = half4(08.0/16.0, 04.0/16.0, 11.0/16.0, 07.0/16.0);
    bayerIndex[2] = half4(02.0/16.0, 14.0/16.0, 01.0/16.0, 13.0/16.0);
    bayerIndex[3] = half4(10.0/16.0, 06.0/16.0, 09.0/16.0, 05.0/16.0);
    
    // sample the texture
    float2 uv = position;
    half4 col = layer.sample(uv);
    
    // gamma correction
    col = half4(pow(col.rgb,half3(2.2)) - 0.004,col.a);
    
    // find bayer matrix entry based on fragment position
    float bayerValue = bayerIndex[int(position.x) % 4][int(position.y) % 4];
    
    float r = col.r;
    float g = col.g;
    float b = col.b;
    
    half4 effect = half4(step(bayerValue,r), step(bayerValue,g),  step(bayerValue,b), col.a);
    
    return mix(col, effect, strength);
}
