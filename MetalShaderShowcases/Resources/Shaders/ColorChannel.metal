#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// Creator: Raphael Salaja
// Twitter: https://twitter.com/rafunderscore/
// Category: Layer
[[ stitchable ]] half4 multiply_color_channel(float2 position, SwiftUI::Layer layer, float red, float green, float blue) {
    half4 current_color = layer.sample(position);
    half4 new_color = current_color;
    
    new_color.r = current_color.r * red;
    new_color.g = current_color.g * green;
    new_color.b = current_color.b * blue;
    

    return new_color;
}
