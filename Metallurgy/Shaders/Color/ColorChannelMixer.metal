#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// COLOR CHANNEL MIXER ---

// DESCRIPTION
// ALLOWS TO MIX THE COLOR CHANNELS OF AN IMAGE BY SAMPLE POSITION.

// LAYER EFFECT
// https://developer.apple.com/documentation/swiftui/view/layereffect(_:maxsampleoffset:isenabled:

[[ stitchable ]] half4 color_channel_mixer(float2 position, half4 color, float red, float green, float blue) {
    
    // FIRST, WE STORE THE ORIGINAL COLOR.
    half4 original_color = color;
    
    // WE CREATE A NEW COLOR VARIABLE TO STORE THE MODIFIED COLOR.
    half4 new_color = original_color;
    
    // WE MULTIPLY THE ORIGINAL COLOR BY THE CHANNEL MIXER VALUES.
    //  RED CHANNEL
    new_color.r = original_color.r * red;
    
    //  GREEN CHANNEL
    new_color.g = original_color.g * green;
    
    //  BLUE CHANNEL
    new_color.b = original_color.b * blue;
    
    return new_color;
}
