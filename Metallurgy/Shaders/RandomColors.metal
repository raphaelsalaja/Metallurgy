#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

float rand(float n){
    return fract(sin(n) * 43758.5453123);
}

float hash_channel(half4 color, int i, float amount)
{
    return rand(floor(color[i] * int(amount)) + float(i));
}

[[ stitchable ]] half4 random_colors(float2 position, SwiftUI::Layer layer, float amount, float strength)
{
    float2 uv = position;

    half4 col = layer.sample(uv);
    
    col.r = hash_channel(col, 0, amount);
    col.g = hash_channel(col, 1, amount);
    col.b = hash_channel(col, 2, amount);
    col.a = hash_channel(col, 3, amount);
    
    return half4(mix(layer.sample(uv), col , strength));
}



