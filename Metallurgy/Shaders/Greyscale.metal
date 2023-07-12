#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

[[ stitchable ]] half4 greyscale(float2 position, SwiftUI::Layer layer, float strength) {
    half4 color = layer.sample(position);
    float average = (color.r + color.g + color.b) / strength;
    
    if(strength <= 1){
        return color;
    }
    
    return half4(average, average, average, color.a);

}
