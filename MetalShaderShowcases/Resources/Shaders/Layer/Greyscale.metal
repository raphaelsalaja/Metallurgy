#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// Creator: leviathwaite
// Porter: Raphael Salaja
// Source: https://www.shadertoy.com/view/Wlt3zS
// Category: Layer
[[ stitchable ]] half4 greyscale_average(float2 position, SwiftUI::Layer layer, float strength) {
    half4 old_color = layer.sample(position);
    half4 new_color = (old_color.r + old_color.g + old_color.b) / 3.0;
    
    return half4(mix(old_color, new_color, strength));

}

[[ stitchable ]] half4 greyscale_luminosity(float2 position, SwiftUI::Layer layer, float strength) {
    half4 old_color = layer.sample(position);
    half4 new_color = 0.21 * old_color.r + 0.72 * old_color.g + 0.07 * old_color.b;
    
    return half4(mix(old_color, new_color, strength));

}

[[ stitchable ]] half4 greyscale_desaturation(float2 position, SwiftUI::Layer layer, float strength) {
    half4 old_color = layer.sample(position);
    half4 new_color = (max(old_color.r, max(old_color.g, old_color.b)) + min(old_color.r, min(old_color.g, old_color.b))) / 2.0;
    
    return half4(mix(old_color, new_color, strength));

}

[[ stitchable ]] half4 greyscale_decomposition_max(float2 position, SwiftUI::Layer layer, float strength) {
    half4 old_color = layer.sample(position);
    half4 new_color = max(old_color.r, max(old_color.g, old_color.b));
    
    return half4(mix(old_color, new_color, strength));

}

[[ stitchable ]] half4 greyscale_decomposition_min(float2 position, SwiftUI::Layer layer, float strength) {
    half4 old_color = layer.sample(position);
    half4 new_color = min(old_color.r, min(old_color.g, old_color.b));
    
    return half4(mix(old_color, new_color, strength));

}

[[ stitchable ]] half4 greyscale_decomposition_mean(float2 position, SwiftUI::Layer layer, float strength) {
    half4 old_color = layer.sample(position);
    half4 new_color = (old_color.r + old_color.g + old_color.b) / 3.0;
    
    return half4(mix(old_color, new_color, strength));

}

[[ stitchable ]] half4 greyscale_decomposition_median(float2 position, SwiftUI::Layer layer, float strength) {
    half4 old_color = layer.sample(position);
    half4 new_color = (old_color.r + old_color.g + old_color.b) / 3.0;
    
    return half4(mix(old_color, new_color, strength));
}

 
