#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// Creator: leviathwaite
// Porter: Raphael Salaja
// Source: https://www.shadertoy.com/view/Wlt3zS
// Category: Layer
[[ stitchable ]] half4 deepfry(float2 position, SwiftUI::Layer layer, float strength){
    half4 color = layer.sample(position);
    
    color.r = (sin(color.r * strength) + 1.0) * 0.5;
    color.g = (sin(color.g * (strength * 2.0 )) + 1.0) * 0.5;
    color.b = (sin(color.b * (strength * 4.0)) + 1.0) * 0.5;
    
    return color;
}
