#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// BLACKLIGHT

// DESCRIPTION
// https://en.wikipedia.org/wiki/Blacklight

// COLOR EFFECT
// https://developer.apple.com/documentation/swiftui/view/coloreffect(_:isenabled:)

[[ stitchable ]] half4 blacklight(float2 position, half4 color, float strength) {

    // FIRST, WE STORE THE ORIGINAL COLOR.
    half4 original_color = color;
    
    // WE CREATE A NEW COLOR VARIABLE TO STORE THE MODIFIED COLOR.
    half4 new_color = original_color;
    
    // WE CHECK IF THE STRENGTH VALUE IS LESS THAN 0.1.
    if (strength < 0.1 ) {
        
        // IF IT IS, WE SET THE STRENGTH TO 0.1 TO AVOID EXTREME BLACKLIGHT ADJUSTMENTS.
        strength = 0.1;
        
    }
 
    // SCALE THE RED, GREEN, AND BLUE COMPONENTS OF THE ORIGINAL COLOR
    float red = new_color.r * 222.0;
    float green = new_color.g * 707.0;
    float blue = new_color.b * 71.0;
    
    // CALCULATE THE LUMINANCE BY SUMMING THE SCALED COLOR COMPONENTS AND DIVIDING BY 1000
    half luminance = (red + green + blue) / 1000.0;
    
    // CALCULATE THE NEW COLOR BY SUBTRACTING THE LUMINANCE FROM THE ORIGINAL COLOR AND MULTIPLYING BY THE STRENGTH
    new_color = abs(new_color - luminance) * strength;
    
    // CLAMP THE NEW COLOR TO ENSURE IT REMAINS WITHIN THE VALID COLOR RANGE
    new_color = clamp(new_color, 0.0, 1.0);
    
    // RETURN THE NEW COLOR
    return new_color;
    
}
