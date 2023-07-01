#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// Creator: leviathwaite
// Porter: Raphael Salaja
// Source: https://www.shadertoy.com/view/Wlt3zS
// Category: Layer
[[ stitchable ]] half4 invert(float2 position, SwiftUI::Layer layer, float strength) {    
    half4 old_color =  layer.sample(position);
    half4 new_color = 1.0 - old_color;
    
    return mix(old_color, new_color, strength);
}


[[ stitchable ]] half4 invert_keep_color(float2 position, SwiftUI::Layer layer, float strength) {
    half4 old_color =  layer.sample(position);
    half4 new_color = 1.0 - old_color;
    
    return mix(old_color, new_color, strength);
}
