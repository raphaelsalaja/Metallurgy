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

[[ stitchable ]] half4 infrared(float2 position, half4 color, float multiplier, float strength) {
    
    // FIRST, WE STORE THE ORIGINAL COLOR.
    half4 original_color = color;
    
    // WE CREATE A NEW COLOR VARIABLE TO STORE THE MODIFIED COLOR.
    half4 new_color = original_color;
    
    // WE CHECK IF THE STRENGTH VALUE IS LESS THAN 0.1.
    if (strength < 0.1 ) {
        
        // IF IT IS, WE SET THE STRENGTH TO 0.1 TO AVOID EXTREME BLACKLIGHT ADJUSTMENTS.
        strength = 0.1;
        
    }
    
    float greyValueA = greyScale(color.rgb);
    
    float scale = clamp(abs(sin(multiplier)) + 0.2, 0.2, 1.00);
    
    half3 x = heatMap(greyValueA * scale);
    
    new_color = half4(x, original_color.a);

    return half4(mix(original_color.rgb, new_color.rgb, strength), color.a);

}
