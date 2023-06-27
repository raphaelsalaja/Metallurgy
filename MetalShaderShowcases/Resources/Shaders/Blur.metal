//
//  Chromatic Abberation.metal
//  MetalShaderShowcases
//
//  Created by Raphael S on 24/06/2023.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

[[ stitchable ]] half4 gaussian(float2 position, SwiftUI::Layer layer,
                                float time,
                                float radius,
                                float intensity,
                                float2 size,
                                float2 center,
                                float3 color) {
    float2 uv = position.xy / size;
    float2 uvCenter = center / size;
    float2 uvDelta = uv - uvCenter;
    float2 uvDirection = normalize(uvDelta);
    float uvDistance = length(uvDelta);
    float2 uvOffset = uvDirection * (uvDistance * radius);
    float2 uvFinal = uvCenter + uvOffset;
    half4 colorFinal = layer.sample(uvFinal);
    // colorFinal.rgb *= color;
    return colorFinal;
}
