#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// MARK: - Swirl
[[ stitchable ]] float2 swirl(float2 position, float time, float2 center, float radius, float angle) {
    float2 offset = position - center;
    
    float distance = length(offset);
    float percent = smoothstep(0.0, radius, distance) / distance;
    
    float2 direction = offset * percent;
    float2 rotated = float2(cos(angle) * direction.x - sin(angle) * direction.y, sin(angle) * direction.x + cos(angle) * direction.y);
    
    return center + rotated;
}


[[ stitchable ]] float2 pinch(float2 position, float time, float2 center, float radius, float scale) {
    float2 offset = position - center;
    float distance = length(offset);
    float percent = smoothstep(0.0, radius, distance) / distance;
    float2 direction = offset * percent;
    float2 scaled = direction * scale;
    return center + scaled;
}

[[ stitchable ]] float2 twirl(float2 position, float time, float2 center, float radius, float angle) {
    float2 offset = position - center;
    float distance = length(offset);
    float percent = smoothstep(0.0, radius, distance) / distance;
    float2 direction = offset * percent;
    float2 rotated = float2(cos(angle * distance) * direction.x - sin(angle * distance) * direction.y, sin(angle * distance) * direction.x + cos(angle * distance) * direction.y);
    return center + rotated;
}

[[ stitchable ]] float2 vortex(float2 position, float time, float2 center, float radius, float angle) {
    float2 offset = position - center;
    float distance = length(offset);
    float percent = smoothstep(0.0, radius, distance) / distance;
    float2 direction = offset * percent;
    float2 rotated = float2(cos(angle / distance) * direction.x - sin(angle / distance) * direction.y, sin(angle / distance) * direction.x + cos(angle / distance) * direction.y);
    return center + rotated;
}

[[ stitchable ]] float2 bulge(float2 position, float time, float2 center, float radius, float scale) {
    float2 offset = position - center;
    float distance = length(offset);
    float percent = smoothstep(0.0, radius, distance) / distance;
    float2 direction = offset * percent;
    float2 scaled = direction * scale;
    return center + scaled;

}

[[ stitchable ]] float2 vhs(float2 position, float time, float2 size, float speed, float strength, float frequency) {
    float2 normalizedPosition = position / size;
    float moveAmount = time * speed;

    position.x += sin((normalizedPosition.x + moveAmount) * frequency) * strength;
    position.y += cos((normalizedPosition.y + moveAmount) * frequency) * strength;

    return position;
}

[[ stitchable ]] half4 colorize(float2 position, SwiftUI::Layer layer, float strength, float3 color) {
    half4 originalColor = layer.sample(position);
    half4 newColor = originalColor;

    newColor.r = (originalColor.r * (1.0 - strength)) + color.r * strength;
    newColor.g = (originalColor.g * (1.0 - strength)) + color.g * strength;
    newColor.b = (originalColor.b * (1.0 - strength)) + color.b * strength;

    return half4(newColor);
}

[[ stitchable ]] half4 invert(float2 position, SwiftUI::Layer layer) {
    half4 originalColor = layer.sample(position);
    return half4(1.0 - originalColor.r, 1.0 - originalColor.g, 1.0 - originalColor.b, originalColor.a);
}

[[ stitchable ]] half4 contrast(float2 position, SwiftUI::Layer layer, float amount) {
    half4 originalColor = layer.sample(position);
    return half4((originalColor.rgb - 0.5) * amount + 0.5, originalColor.a);
}

[[ stitchable ]] half4 brightness(float2 position, SwiftUI::Layer layer, float amount) {
    half4 originalColor = layer.sample(position);
    return half4(originalColor.rgb * amount, originalColor.a);
}

[[ stitchable ]] half4 gamma(float2 position, SwiftUI::Layer layer, float amount) {
    half4 originalColor = layer.sample(position);
    return half4(pow(originalColor.rgb, 1.0 / amount), originalColor.a);
}

[[ stitchable ]] half4 crt(float2 position, SwiftUI::Layer layer) {
    half4 originalColor = layer.sample(position);
    float r = originalColor.r * 0.393 + originalColor.g * 0.769 + originalColor.b * 0.189;
    float g = originalColor.r * 0.349 + originalColor.g * 0.686 + originalColor.b * 0.168;
    float b = originalColor.r * 0.272 + originalColor.g * 0.534 + originalColor.b * 0.131;
    return half4(r, g, b, originalColor.a);
}


// MARK: - Kavsoft

[[ stitchable ]] float2 pixellate(float2 position, float size) {
    float2 pixellatedPosition = round (position / size) * size;
    return pixellatedPosition;
}

[[ stitchable ]] float2 waves (float2 position, float time, float speed, float frequency, float amplitude){
    float positionY = position.y + sin((time * speed) + (position.x / frequency)) * amplitude;
    return float2(position.x, positionY);
}

[[ stitchable ]] half4 grayscale(float2 position, SwiftUI:: Layer layer) {
    half4 originalColor = layer.sample(position);
    float grayscaleValue = (originalColor.r + originalColor.g + originalColor.b) / 3.0;
    return half4(grayscaleValue, grayscaleValue, grayscaleValue, originalColor.a);
}



[[ stitchable ]] half4 checkerboard(float2 position, half4 currentColor, float size, half4 newColor) {
    uint2 posInChecks = uint2(position.x / size, position.y / size);
    bool isColor = (posInChecks.x ^ posInChecks.y) & 1;
    return isColor ? newColor * currentColor.a : half4(0.0, 0.0, 0.0, 0.0);
}

[[ stitchable ]] half4 noise(float2 position, half4 currentColor, float time) {
    float value = fract(sin(dot(position + time, float2(12.9898, 78.233))) * 43758.5453);
    return half4(value, value, value, 1) * currentColor.a;
}

[[ stitchable ]] half4 emboss(float2 position, SwiftUI::Layer layer, float strength) {
    half4 current_color = layer.sample(position);
    half4 new_color = current_color;

    new_color += layer.sample(position + 1) * strength;
    new_color -= layer.sample(position - 1) * strength;

    return half4(new_color);
}
