#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

[[ stitchable ]] half4 contrast_layer(float2 position, SwiftUI::Layer layer, float strength) {
    half3 color = layer.sample(position).rgb;
    
    if (strength == 0) {
        return half4(color, layer.sample(position).a);
    }
    
    color -= 0.5;
    color *= strength;
    color += 0.5;
    
    return half4(color, layer.sample(position).a);
}
