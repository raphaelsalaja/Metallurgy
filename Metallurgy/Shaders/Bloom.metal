#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// --- BLOOM ---
// --- THIS FUNCTION TAKES IN A POSITION AND A LAYER ALONG WITH A STRENGTH VALUE AND RETURNS A HALF4,
// --- WHICH IS A FOUR-COMPONENT VECTOR OF HALF-PRECISION FLOATING POINT NUMBERS.

// --- EFFCT ---
// --- LAYER: (https://developer.apple.com/documentation/swiftui/view/layereffect(_:maxsampleoffset:isenabled:)
[[ stitchable ]] half4 bloom(float2 position, SwiftUI::Layer layer, float strength) {
    // --- BACKGROUND INFORMATION ---
    // --- BLOOM IS AN EFFECT THAT MAKES THE IMAGE LOOK BRIGHTER AND MORE RADIANT.
    // --- IT IS OFTEN USED TO CREATE A GLOWING EFFECT AROUND LIGHT SOURCES.
    // --- USUALLY SEEN IN VIDEO GAMES, IT IS USED TO CREATE A MORE REALISTIC LIGHTING EFFECT.
    
    // --- MISSION ---
    // --- FOR US TO ACHIVE THIS EFFECT, WE WILL BE USING A FOR LOOP AND A MIX FUNCTION
    // --- TO BLEND THE ORIGINAL COLOR WITH THE NEW COLOR.

    // --- IMPLEMENTATION ---
    // --- FIRST WE GET THE ORIGINAL COLOR OF THE LAYER AT THE POSITION
    half4 original_color = layer.sample(position);
    
    // --- THEN WE CREATE A NEW COLOR VARIABLE THAT
    // --- WILL BE USED TO STORE THE NEW COLOR
    half4 new_color = original_color;
    
    // --- WE GET THE UV COORDINATES OF THE POSITION
    float2 uv = position.xy;
    
    // --- THIS FOR LOOP WILL BE USED TO ITERATE THROUGH THE UV COORDINATES
    // --- AND INCREASE THE BRIGHTNESS OF THE IMAGE
    for (int i = 0; i < 10; i++) {
        // --- WE INCREASE THE UV COORDINATES BY 1.1
        // --- WE DO THIS TO INCREASE THE BRIGHTNESS OF THE IMAGE
        uv *= 1.1;
        
        // --- WE SAMPLE THE LAYER AT THE UV COORDINATES
        // --- AND ADD IT TO THE NEW COLOR
        // --- LAYER.SAMPLE() READS THE COLOR OF THE LAYER AT THE GIVEN POSITION
        new_color += layer.sample(position) * 0.01 * i;
    }
    
    // --- WE RETURN THE MIX OF THE ORIGINAL COLOR AND THE NEW COLOR
    // --- MIX() IS A FUNCTION THAT TAKES IN TWO COLORS AND A STRENGTH VALUE
    // --- IT LERPS BETWEEN THE TWO COLORS BASED ON THE STRENGTH VALUE
    return mix(original_color, new_color, strength);
}
