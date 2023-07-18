#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// DITHERING

// DESCRIPTION
// https://en.wikipedia.org/wiki/Dither

// LAYER EFFECT
// https://developer.apple.com/documentation/swiftui/view/layereffect(_:maxsampleoffset:isenabled:

[[ stitchable ]] half4 dithering(float2 position, SwiftUI::Layer layer, float strength, float pixel_size) {
    
    // WE CREATE THE DITHER EFFECT BY USING A BAYER MATRIX
    // https://en.wikipedia.org/wiki/Ordered_dithering
    // https://en.wikipedia.org/wiki/Bayer_filter
    half4x4 bayerIndex;
    
    bayerIndex[0] = half4(00.0/16.0, 12.0/16.0, 03.0/16.0, 15.0/16.0);
    bayerIndex[1] = half4(08.0/16.0, 04.0/16.0, 11.0/16.0, 07.0/16.0);
    bayerIndex[2] = half4(02.0/16.0, 14.0/16.0, 01.0/16.0, 13.0/16.0);
    bayerIndex[3] = half4(10.0/16.0, 06.0/16.0, 09.0/16.0, 05.0/16.0);
    
    // WE STORE THE ORIGINAL COLOR.
    half4 original_color = layer.sample(position);
    
    // WE APPLY THE GAMMA CORRECTION
    original_color = half4(pow(original_color.rgb, half3(2.2)) - 0.004, original_color.a);
    
    // CONVER THE PIXEL TO AN INTEGER
    int size = int(pixel_size);
    
    // FIND BAYER MATRIX ENTRY BASED ON FRAGMENT POSITION
    float bayerValue = bayerIndex[int(position.x) % size][int(position.y) % size];
    
    float r = original_color.r;
    float g = original_color.g;
    float b = original_color.b;
    
    
    // WE APPLY THE DITHERING EFFECT
    half4 effect = half4(step(bayerValue,r),
                         step(bayerValue,g),
                         step(bayerValue,b), original_color.a);
    
    // RETURN THE MIX BETWEEN THE ORIGINAL COLOR AND THE EFFECT
    return mix(original_color, effect, strength);
}
