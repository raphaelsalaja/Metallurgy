#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// Creator: leviathwaite
// Porter: Raphael Salaja
// Source: https://www.shadertoy.com/view/Wlt3zS
// Category: Layer
[[ stitchable ]] half4 intensity(float2 position, SwiftUI::Layer layer, float strength) {
    half4 old_color =  layer.sample(position);
    return old_color * strength;
}
