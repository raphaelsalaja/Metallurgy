#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// CHROMATIC ABERRATION (SHIFT)

// DESCRIPTION
// https://en.wikipedia.org/wiki/Chromatic_aberration

// LAYER EFFECT
// https://developer.apple.com/documentation/swiftui/view/layereffect(_:maxsampleoffset:isenabled:

[[ stitchable ]] half4 chromatic_abberation_static(float2 position, SwiftUI::Layer layer, float red, float blue) {

    // FIRST, WE STORE THE ORIGINAL COLOR.
    half4 original_color = layer.sample(position);
    
    // WE CREATE A NEW COLOR VARIABLE TO STORE THE MODIFIED COLOR.
    half4 new_color = original_color;
    
    // WE MODIFY THE COLOR BY SHIFTING THE RED AND BLUE CHANNELS.
    new_color.r = layer.sample(position - float2(red, -red)).r;
    
    // GREEN IS OPTIONAL, BUT WE CAN USE IT TO CREATE A MORE REALISTIC EFFECT.
    new_color.g = layer.sample(position).g;
    
    new_color.b = layer.sample(position - float2(blue, -blue)).b;

    // WE RETURN THE NEW COLOR.
    return new_color;
    
}
