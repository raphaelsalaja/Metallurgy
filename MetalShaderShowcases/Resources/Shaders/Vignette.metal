//
//  Vignette.metal
//  MetalShaderShowcases
//
//  Created by Raphael S on 23/06/2023.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;


[[ stitchable ]] half4 vignette(float2 position, SwiftUI::Layer layer, float radius, float softness) {
    half4 originalColor = layer.sample(position);
    float2 center = float2(0.5, 0.5);
    float dist = distance(position, center);
    float vignette = smoothstep(radius, radius - softness, dist);
    return half4(originalColor.rgb * vignette, originalColor.a);
}
