#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// --- CONTRAST

// --- DESCRIPTION
// https://en.wikipedia.org/wiki/Contrast_(vision)

// --- COLOR EFFECT:
// https://developer.apple.com/documentation/swiftui/view/coloreffect(_:isenabled:)

[[ stitchable ]] half4 contrast(float2 position, half4 color, float strength) {

    // FIRST, WE STORE THE ORIGINAL COLOR.
    half4 original_color = color;
    
    // WE CREATE A NEW COLOR VARIABLE TO STORE THE MODIFIED COLOR.
    half4 new_color = original_color;
    
    // WE CHECK IF THE STRENGTH VALUE IS LESS THAN 0.1.
    if (strength < 0.1 ) {
        
        // IF IT IS, WE SET THE STRENGTH TO 0.1 TO AVOID EXTREME CONTRAST ADJUSTMENTS.
        strength = 0.1;
        
    }
    
    // WE SUBTRACT 0.5 FROM EACH COLOR CHANNEL TO SHIFT THE RANGE TO [-0.5, 0.5].
    new_color -= 0.5;
    
    // THEN MULTIPLY EACH COLOR CHANNEL BY THE STRENGTH VALUE TO ADJUST THE CONTRAST.
    new_color *= strength;
    
    // AND FINALLY ADD 0.5 TO EACH COLOR CHANNEL TO SHIFT THE RANGE BACK TO [0, 1].
    new_color += 0.5;
    
    // FINALLY, WE RETURN THE MODIFIED COLOR.
    return new_color;
    
}

