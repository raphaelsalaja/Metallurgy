#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// Creator: leviathwaite
// Porter: Raphael Salaja
// Source: https://www.shadertoy.com/view/Wlt3zS
// Category: Layer
[[ stitchable ]] half4 contrast(float2 position, SwiftUI::Layer layer, float strength) {
    half3 color = layer.sample(position).rgb;
    
    color -= 0.5;
    color *= strength;
    color += 0.5;
    
    return half4(color, 1.0);
}
