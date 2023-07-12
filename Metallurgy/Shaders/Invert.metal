#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;
 
[[ stitchable ]] half4 invert(float2 position, SwiftUI::Layer layer, float strength) {
    half4 color = layer.sample(position);
    
    return mix(
               color,
               half4(
                     1.0 - color.r,
                     1.0 - color.g,
                     1.0 - color.b,
                     color.a
                     ),
               strength);
}
