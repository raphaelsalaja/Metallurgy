#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// INFRARED

// DESCRIPTION
// https://en.wikipedia.org/wiki/Infrared_photography

// COLOR EFFECT
// https://developer.apple.com/documentation/swiftui/view/coloreffect(_:isenabled:)

float greyScale(half3 rgb) {
    
    // HERE WE ARE CONVERTING THE RGB COLOR TO A GREYSCALE COLOR
    return dot(rgb, half3(0.29, 0.60, 0.11));
    
}

half3 heatMap(float greyValue) {
    
    // DEFINE A HALF3 VARIABLE TO STORE THE HEAT COLOR
    half3 heat;
    
    // HERE WE ARE USING SMOOTHSTEP TO CREATE A SMOOTH TRANSITION BETWEEN COLORS
    // LEARN MORE: https://thebookofshaders.com/glossary/?search=smoothstep
    heat.r = smoothstep(0.5, 0.8, greyValue);
    
    // HERE WE ARE CHECKING IF THE GREYSCALE VALUE IS GREATER THAN 0.90
    if(greyValue >= 0.90) {
        
        // IF IT IS, WE SET THE RED VALUE TO 1.0
        heat.r *= (1.1 - greyValue) * 5.0;
        
    }
    
    // HERE WE ARE CHECKING IF THE GREYSCALE VALUE IS GREATER THAN 0.70
    if(greyValue > 0.7) {
        
        // IF IT IS, WE SET THE GREEN VALUE TO 1.0
        heat.g = smoothstep(1.0, 0.7, greyValue);
        
    }
    else {
        
        // IF IT IS NOT, WE SET THE GREEN VALUE TO 0.0
        heat.g = smoothstep(0.0, 0.7, greyValue);
        
    }
    
    // NOW WE SET THE BLUE VALUE
    heat.b = smoothstep(1.0, 0.0, greyValue);
    
    // HERE WE ARE CHECKING IF THE GREYSCALE VALUE IS LESS THAN 0.3
    if(greyValue <= 0.3) {
        
        // IF IT IS, WE SET THE BLUE VALUE TO 0.0
        heat.b *= greyValue / 0.3;
        
    }
    
    // RETURN THE HEAT COLOR
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
    
    // WE USE OUR FUNCITON TO CONVERT THE RGB COLOR TO GREYSCALE.
    float greyValueA = greyScale(color.rgb);
    
    // WE DEFINE A FLOAT VARIABLE TO STORE THE SCALE VALUE.
    float scale = clamp(abs(sin(multiplier)) + 0.2, 0.2, 1.00);
    
    // WE THEN USE OUR HEATMAP FUNCTION TO CONVERT THE GREYSCALE VALUE TO A HEAT COLOR.
    half3 x = heatMap(greyValueA * scale);
    
    // WE SET THE NEW COLOR TO THE HEAT COLOR.
    new_color = half4(x, original_color.a);

    // WE RETURN THE NEW COLOR WHICH IS SCALED BY THE STRENGTH VALUE.
    return half4(mix(original_color.rgb, new_color.rgb, strength), color.a);

}
