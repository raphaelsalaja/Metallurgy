#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

[[ stitchable ]] half4 intensity(float2 position, SwiftUI::Layer layer, float strength) {
    half4 old_color =  layer.sample(position);
    
    if(strength == 0.0) {
        return old_color;
    }
    
    return old_color * strength;
}
