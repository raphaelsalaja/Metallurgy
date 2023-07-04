#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

// --- BLACKLIGHT ---
// --- THIS FUNCTION TAKES IN A POSITION AND A LAYER ALONG WITH A STRENGTH VALUE AND RETURNS A HALF4,
// --- WHICH IS A FOUR-COMPONENT VECTOR OF HALF-PRECISION FLOATING POINT NUMBERS.

// --- EFFCT ---
// --- LAYER: (https://developer.apple.com/documentation/swiftui/view/layereffect(_:maxsampleoffset:isenabled:)
[[ stitchable ]] half4 blacklight(float2 position, SwiftUI::Layer layer, float strength) {
    // --- BACKGROUND INFORMATION
    // --- BLACKLIGHT IS A TYPE OF LIGHT THAT IS INVISIBLE TO THE HUMAN EYE.
    // --- HOWEVER, IT CAN BE SEEN BY CERTAIN ANIMALS, SUCH AS CATS.
    // --- IT IS ALSO KNOWN AS ULTRAVIOLET LIGHT.
    
    // --- MISSION
    // --- FOR US TO ACHIVE THIS EFFECT,
    // --- WE SIMPLY NEED TO INVERT THE COLOR OF THE LAYER BY A CERTAIN LUIMINANCE VALUE

    // --- IF THE STRENGTH IS LESS THAN OR EQUAL TO 1.0,
    // --- WE DON’T WANT TO DO ANYTHING, SO WE JUST RETURN THE LAYER SAMPLE.
    if (strength <= 1.0) {
        return layer.sample(position);
    }
    
    // --- IF THE STRENGTH IS GREATER THAN 1.0,
    // --- WE WANT TO APPLY THE BLACKLIGHT EFFECT.
    // --- FIRST, WE SAMPLE THE LAYER AT THE POSITION TO GET THE ORIGINAL COLOR.
    half4 original_color =  layer.sample(position);
    
    // --- THEN, WE CALCULATE THE LUMINANCE OF THE OLD COLOR.
    // --- WE DO THIS BY MULTIPLYING:
    // --- THE RED CHANNEL BY   0.222
    float red = original_color.r * 222.0;
    // --- THE GREEN CHANNEL BY 0.707
    float green = original_color.g * 707.0;
    // --- THE BLUE CHANNEL BY  0.071
    float blue = original_color.b * 71.0;
    
    // --- THEN, WE ADD THE THREE CHANNELS TOGETHER AND DIVIDE BY 1000.
    half luminance = (red + green + blue) / 1000.0;
    
    // --- NEXT, WE SUBTRACT THE LUMINANCE FROM THE ORIGINAL COLOR.
    // --- THIS GIVES US A COLOR THAT IS THE INVERSE OF THE ORIGINAL COLOR.
    // --- WE THEN MULTIPLY THIS INVERSE COLOR BY THE STRENGTH TO GET THE NEW COLOR.
    // --- THE STRENGTH IS A FLOATING POINT NUMBER THAT DETERMINES HOW MUCH OF THE INVERSE COLOR WE WANT TO ADD TO THE ORIGINAL COLOR.
    half4 new_color = abs(original_color - luminance) * strength;
    
    // --- FINALLY, WE CLAMP THE COLOR TO THE RANGE OF 0 TO 1 AND RETURN IT.
    // --- WE DO THIS BECAUSE THE COLOR MAY BE OUTSIDE OF THE RANGE OF 0 TO 1.
    new_color = clamp(new_color, 0.0, 1.0);
    
    // --- RETURN THE NEW COLOR
    return new_color;
}
