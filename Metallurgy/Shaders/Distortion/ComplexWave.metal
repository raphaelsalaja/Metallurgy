#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// COMPLEX WAVE

// DISTORTION EFFECT
// https://developer.apple.com/documentation/swiftui/view/distortioneffect(_:maxsampleoffset:isenabled:)

// PORT:
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-metal-shaders-to-swiftui-views-using-layer-effects

[[ stitchable ]] float2 complex_wave(float2 position, float time, float2 size, float speed, float strength, float frequency) {
    
    // DETERMINE THE NORMALIZED POSITION OF THE VERTEX
    float2 normalized_position = position / size;
    
    // MOVE THE VERTEX ALONG THE WAVE
    float move_amount = time * speed;

    // APPLY THE WAVE TO THE VERTEX
    position.x += sin((normalized_position.x + move_amount) * frequency) * strength;
    position.y += cos((normalized_position.y + move_amount) * frequency) * strength;

    // RETURN THE POSITION
    return position;
    
}

