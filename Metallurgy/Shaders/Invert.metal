#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

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
    
     new_color =  mix(
               original_color,
               half4(
                     1.0 - original_color.r,
                     1.0 - original_color.g,
                     1.0 - original_color.b,
                     original_color.a
                     ),
               strength + 1);
     
     return new_color;
}
