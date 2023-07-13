#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// Creator: leviathwaite
// Porter: Raphael Salaja
// Source: https://www.shadertoy.com/view/Wlt3zS
// Category: Layer
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
    
    strength = strength * 100;
    
    new_color.r = (sin(original_color.r * strength) + 1.0) * 0.5;
    new_color.g = (sin(original_color.g * (strength * 2.0 )) + 1.0) * 0.5;
    new_color.b = (sin(original_color.b * (strength * 4.0)) + 1.0) * 0.5;
    
    return new_color;
}
