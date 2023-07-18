#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// EXPOSURE

// DESCRIPTION
// https://en.wikipedia.org/wiki/Exposure_(photography)

// COLOR EFFECT
// https://developer.apple.com/documentation/swiftui/view/coloreffect(_:isenabled:)

[[ stitchable ]] half4 exposure(float2 position, half4 color, float strength) {
    
    // FIRST, WE STORE THE ORIGINAL COLOR
    half4 original_color = color;
    
    // WE CREATE A NEW COLOR VARIABLE TO STORE THE MODIFIED COLOR
    half4 new_color = original_color;
    
    // WE APPLY THE EXPOSURE FILTER FORMULA
    new_color = half4(1.0) - exp(-original_color * (strength * 10));
    
    // WE RETURN THE NEW COLOR
    return new_color;
    
}
