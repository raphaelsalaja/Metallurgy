#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// BLOOM

// DESCRIPTION
// https://en.wikipedia.org/wiki/Bloom_(shader_effect)

// COLOR EFFECT
// https://developer.apple.com/documentation/swiftui/view/coloreffect(_:isenabled:)

[[ stitchable ]] half4 bloom(float2 position, half4 color, float strength) {
    
    // FIRST, WE STORE THE ORIGINAL COLOR.
    half4 original_color = color;
    
    // WE CREATE A NEW COLOR VARIABLE TO STORE THE MODIFIED COLOR.
    half4 new_color = original_color;
    
    // WE GET THE UV COORDINATES OF THE POSITION
    float2 uv = position;
    
    // THIS FOR LOOP ITERATES THROUGH THE UV COORDINATES AND INCREASES THE BRIGHTNESS OF THE IMAGE
    for (int i = 0; i < 10; i++) {

        // WE INCREASE THE UV COORDINATES BY 1.1 TO INTENSIFY THE BRIGHTNESS
        uv *= 1.1;
        
        // WE SAMPLE THE LAYER AT THE UPDATED UV COORDINATES AND ADD IT TO THE NEW COLOR
        new_color += color * 0.01 * i;

    }
    
    // WE RETURN THE MIXED COLOR, WHICH IS A BLEND OF THE ORIGINAL COLOR AND THE NEW COLOR BASED ON THE STRENGTH VALUE
    return mix(original_color, new_color, strength);
    
}
