#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// INTENSITY

// DESCRIPTION
// ADJUSTS THE INTENSITY OF THE COLORS IN THE VIEW.

// COLOR EFFECT
// https://developer.apple.com/documentation/swiftui/view/coloreffect(_:isenabled:)

[[ stitchable ]] half4 intensity(float2 position, half4 color, float strength) {
    
    // FIRST, WE STORE THE ORIGINAL COLOR.
    half4 original_color = color;
    
    // WE CREATE A NEW COLOR VARIABLE TO STORE THE MODIFIED COLOR.
    half4 new_color = original_color;
    
    // WE CHECK IF THE STRENGTH VALUE IS LESS THAN 0.1.
    if (strength < 0.1) {
        
        // IF IT IS, WE SET THE STRENGTH TO 0.1 TO AVOID EXTREME BLACKLIGHT ADJUSTMENTS.
        return original_color;
        
    }
    
    // MULTIPLY THE STRENGTH BY 10 TO GET A MORE REALISTIC INTENSITY.
    strength *= 2;
    
    // RETURN THE NEW COLOR WITH THE ADJUSTED INTENSITY.
    return new_color * strength;
    
}
