#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// SEPIA

// DESCRIPTION
// https://en.wikipedia.org/wiki/Sepia_(color)

// COLOR EFFECT
// https://developer.apple.com/documentation/swiftui/view/coloreffect(_:isenabled:)

[[ stitchable ]] half4 sepia(float2 position, half4 color, float strength) {
    
    // FIRST, WE STORE THE ORIGINAL COLOR.
    half4 original_color = color;
    
    // WE CREATE A NEW COLOR VARIABLE TO STORE THE MODIFIED COLOR.
    half4 new_color = original_color;
    
    // WE CHECK IF THE STRENGTH VALUE IS LESS THAN 0.1.
    if (strength < 0.1 ) {
        
        // IF IT IS, WE SET THE STRENGTH TO 0.1 TO AVOID EXTREME BLACKLIGHT ADJUSTMENTS.
        strength = 0.1;
        
    }
    
    // WE APPLY THE SEPIA FILTER.
    new_color.r = (original_color.r * (1.0 - (0.607 * strength))) + (original_color.g * (0.769 * strength)) + (original_color.b * (0.189 * strength));
    new_color.g = (original_color.r * (0.349 * strength)) + (original_color.g * (1.0 - (0.314 * strength))) + (original_color.b * (0.168 * strength));
    new_color.b = (original_color.r * (0.272 * strength)) + (original_color.g * (0.534 * strength)) + (original_color.b * (1.0 - (0.869 * strength)));
    
    // WE RETURN THE NEW COLOR.
    return new_color;
    
}

