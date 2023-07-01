#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

float greyScale(half3 rgb) {
       return dot(rgb, half3(0.29, 0.60, 0.11));
}

half3 heatMap(float greyValue) {
    half3 heat;
    heat.r = smoothstep(0.5, 0.8, greyValue);
    if(greyValue >= 0.90) {
        heat.r *= (1.1 - greyValue) * 5.0;
    }
    if(greyValue > 0.7) {
        heat.g = smoothstep(1.0, 0.7, greyValue);
    } else {
        heat.g = smoothstep(0.0, 0.7, greyValue);
    }
    heat.b = smoothstep(1.0, 0.0, greyValue);
    if(greyValue <= 0.3) {
        heat.b *= greyValue / 0.3;
    }
    return heat;
}

[[ stitchable ]] half4 infrared(float2 position, SwiftUI::Layer layer, float time, float strength) {
    half4 color = layer.sample(position);
    
    float greyValueA = greyScale(color.rgb);
    
    float multiplier = clamp(abs(sin(time * 0.5)) + 0.2, 0.2, 1.00);
    
    half3 x = heatMap(greyValueA * multiplier);
    
    half4 final = half4(x, color.a);

    return half4(mix(color.rgb, final.rgb, strength), color.a);

}
