#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

[[ stitchable ]] half4 chromatic_abberation(float2 position, SwiftUI::Layer layer, float red, float green, float blue) {
    half4 original_color = layer.sample(position);
    half4 new_color = original_color;
    
    new_color.r = layer.sample(position - float2(red, -red)).r;
    new_color.g = layer.sample(position - float2(green, -green)).g;
    new_color.b = layer.sample(position - float2(blue, -blue)).b;
    new_color.a = layer.sample(position).a;

    return new_color;
}


[[ stitchable ]] half4 chromatic_abberation_shift(float2 position, SwiftUI::Layer layer, float time) {
    half4 original_color = layer.sample(position);
    half4 new_color = original_color;
    
    float amount = 0.0;
    
    amount = (1.0 + sin(time*6.0)) * 0.5;
    amount *= 1.0 + sin(time*16.0) * 0.5;
    amount *= 1.0 + sin(time*19.0) * 0.5;
    amount *= 1.0 + sin(time*27.0) * 0.5;
    amount = pow(amount, 3.0);
    amount *= 0.75;
    
    new_color.r = layer.sample(position + float2(amount/2.2, -amount/2)).r;
    new_color.g = layer.sample(position - float2(amount/2, -amount/2.4)).g;
    new_color.b = layer.sample(position - float2(amount/2, -amount/2.1)).b;
    new_color.a = layer.sample(position).a;
    
    return new_color;
}
