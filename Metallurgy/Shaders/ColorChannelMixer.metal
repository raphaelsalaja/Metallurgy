#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

[[ stitchable ]] half4 color_channel_mixer(float2 position, SwiftUI::Layer layer, float red, float green, float blue) {
    half4 original_color = layer.sample(position);
    half4 new_color = original_color;
    
    new_color.r = original_color.r * red;
    
    new_color.g = original_color.g * green;
    
    new_color.b = original_color.b * blue;
    
    return new_color;
}
