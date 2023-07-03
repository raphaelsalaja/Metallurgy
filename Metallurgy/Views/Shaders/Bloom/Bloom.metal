#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

[[ stitchable ]] half4 bloom(float2 position, SwiftUI::Layer layer, float strength) {
    half4 current_color = layer.sample(position);
    half4 new_color = current_color;
    
    float2 size = position.xy;
    
    for (int i = 0; i < 10; i++) {
        size *= 1.1;
        new_color += layer.sample(position) * 0.01;
        new_color += layer.sample(position) * 0.01;
    }
    
    return mix(current_color, new_color, strength);
}
