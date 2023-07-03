#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

[[ stitchable ]] half4 blacklight(float2 position, SwiftUI::Layer layer, float strength) {
    if (strength == 0.0) {
        return layer.sample(position);
    }
    
    half4 old_color =  layer.sample(position);
    
    half lum = (222.0 * old_color.r + 707.0 * old_color.g + 71.0 * old_color.b) / 1000.0;
    
    half4 new_color = abs(old_color - lum) * strength;
    
    new_color = clamp(new_color, 0.0, 1.0);
    
    return new_color;
}
