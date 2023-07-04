#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

[[ stitchable ]] half4 exposure(float2 position, SwiftUI::Layer layer, float strength) {
    half4 original_color =  layer.sample(position);
    
    half3 new_color = half3(1.0) - exp(-original_color.rgb * strength);
    
    return half4(new_color, original_color.a);
}
