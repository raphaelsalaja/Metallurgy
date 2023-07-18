#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// INVERT

// DESCRIPTION
// https://en.wikipedia.org/wiki/Negative_(photography)

// COLOR EFFECT
// https://developer.apple.com/documentation/swiftui/view/coloreffect(_:isenabled:)

[[ stitchable ]] half4 invert(float2 position, half4 color, float strength) {
    
    // FIRST, WE STORE THE ORIGINAL COLOR.
    half4 original_color = color;
    
    // WE CREATE A NEW COLOR VARIABLE TO STORE THE MODIFIED COLOR.
    half4 new_color = original_color;
    
    // WE CHECK IF THE STRENGTH VALUE IS LESS THAN 0.1.
    if (strength < 1) {
        
        // IF IT IS, WE SET THE STRENGTH TO 0.1 TO AVOID EXTREME BLACKLIGHT ADJUSTMENTS.
        strength = 0.1;
        
    }
    
    // WE INVERT THE COLOR BY SUBTRACTING THE ORIGINAL COLOR FROM 1.0.
    half4 inverted_colors = half4(1.0 - original_color.r, 1.0 - original_color.g, 1.0 - original_color.b, original_color.a);
    
    // WE MIX THE ORIGINAL COLOR WITH THE INVERTED COLOR BASED ON THE STRENGTH VALUE.
    new_color =  mix(original_color, inverted_colors, strength + 1);
    
    // WE RETURN THE NEW COLOR.
    return new_color;
    
}
