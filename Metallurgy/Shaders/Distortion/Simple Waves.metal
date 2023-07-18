#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// SIMPLE WAVE

// DISTORTION EFFECT
// https://developer.apple.com/documentation/swiftui/view/distortioneffect(_:maxsampleoffset:isenabled:)

// PORT:
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-metal-shaders-to-swiftui-views-using-layer-effects

[[ stitchable ]] float2 simple_wave(float2 position, float time) {
    
    // RETURN A POSITION OFFSET BY A WAVE
    return position + float2 (sin(time + position.y / 20), sin(time + position.x / 20)) * 5;
}

