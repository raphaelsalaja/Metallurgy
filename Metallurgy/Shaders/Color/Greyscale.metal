#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// GREYSCALE

// DESCRIPTION
// https://en.wikipedia.org/wiki/Grayscale

// COLOR EFFECT
// https://developer.apple.com/documentation/swiftui/view/coloreffect(_:isenabled:)

[[ stitchable ]] half4 greyscale(float2 position, half4 color, float strength) {
    
    // FIRST, WE STORE THE ORIGINAL COLOR.
    half4 original_color = color;
    
    // WE CREATE A NEW COLOR VARIABLE TO STORE THE MODIFIED COLOR.
    half4 new_color = original_color;
    
    // WE CHECK IF THE STRENGTH VALUE IS LESS THAN 0.1.
    if (strength < 1.0) {
        
        // IF IT IS, WE SET THE STRENGTH TO 0.1 TO AVOID EXTREME BLACKLIGHT ADJUSTMENTS.
        strength = 1;
        
    }
    
    if (strength > 3.0) {
        
        // IF IT IS, WE SET THE STRENGTH TO 0.1 TO AVOID EXTREME BLACKLIGHT ADJUSTMENTS.
        
        strength = 3;
        
    }
    
    // WE CALCULATE THE NEW COLOR BY AVERAGING THE RED, GREEN, AND BLUE CHANNELS.
    new_color = (original_color.r + original_color.g + original_color.b) / (strength * 10);
    
    // WE RETURN THE NEW COLOR.
    return half4(new_color.r, new_color.g, new_color.b, original_color.a);

}
