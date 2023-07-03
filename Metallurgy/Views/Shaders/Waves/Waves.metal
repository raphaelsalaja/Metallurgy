#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// Creator: Paul Hudson
// Twitter: https://twitter.com/rafunderscore/
// Category: Distortion
[[ stitchable ]] float2 simpleWave(float2 position, float time) {
    return position + float2 (sin(time + position.y / 20), sin(time + position.x / 20)) * 5;
}

// Creator: Paul Hudson
// Twitter: https://twitter.com/rafunderscore/
// Category: Distortion
[[ stitchable ]] float2 complexWave(float2 position, float time, float2 size, float speed, float strength, float frequency) {
    float2 normalizedPosition = position / size;
    float moveAmount = time * speed;

    position.x += sin((normalizedPosition.x + moveAmount) * frequency) * strength;
    position.y += cos((normalizedPosition.y + moveAmount) * frequency) * strength;

    return position;
}
