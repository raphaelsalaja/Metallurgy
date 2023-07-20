#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// DEEPFRY

// DESCRIPTION
// https://en.wikipedia.org/wiki/Deep_frying

// COLOR EFFECT
// https://developer.apple.com/documentation/swiftui/view/coloreffect(_:isenabled:)

[[ stitchable ]] half4 deepfry(float2 position, half4 color, float strength){
    
    // FIRST, WE STORE THE ORIGINAL COLOR.
    half4 original_color = color;
    
    // WE CREATE A NEW COLOR VARIABLE TO STORE THE MODIFIED COLOR.
    half4 new_color = original_color;
    
    // WE CHECK IF THE STRENGTH VALUE IS LESS THAN 0.1.
    if (strength < 0.1 ) {
        
        // IF IT IS, WE RETURN THE ORIGINAL COLOR TO AVOID EXTREME BLACKLIGHT ADJUSTMENTS.
        return original_color;
        
    }
    
    // WE MULTIPLY THE STRENGTH VALUE BY 100 TO MAKE IT EASIER TO USE
    strength = strength * 100;
    
    // WE THEN GET THE SIN OF THE ORIGINAL COLOR AND ADD 1 TO IT
    new_color.r = (sin(original_color.r * strength) + 1.0) * 0.5;
    
    // WE MULTIPLY THE SIN VALUE BY 2 AND ADD 1 TO IT
    new_color.g = (sin(original_color.g * (strength * 2.0 )) + 1.0) * 0.5;
    
    // WE MULTIPLY THE SIN VALUE BY 4 AND ADD 1 TO IT
    new_color.b = (sin(original_color.b * (strength * 4.0)) + 1.0) * 0.5;
    
    
    
    // WE RETURN THE NEW COLOR
    return new_color;
    
}
