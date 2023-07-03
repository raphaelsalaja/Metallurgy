//
//  MagnificationLoupe.metal
//  MagnificationLoupe
//
//  Created by Janum Trivedi on 6/15/23.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

float mapRange(float value, float inMin, float inMax, float outMin, float outMax) {
    return ((value - inMin) * (outMax - outMin) / (inMax - inMin) + outMin);
}

float easeInQuart(float x) {
    return x * x * x * x;
}

[[ stitchable ]] half4 loupe(float2 position, SwiftUI::Layer layer, float4 bounds, float2 loupeCenter, float loupeSize) {
    // The overall size/resolution of the shader view's bounds
    float2 size = float2(bounds[2], bounds[3]);

    // Normalize `position` into unit coordinates (i.e. [0, 1])
    float2 p = position / size;
    float px = p[0];
    float py = p[1];

    // Sample the original color of the pixel
    half4 color = layer.sample(position);

    // Calculate how far the current pixel is from the loupe's center.
    float d = distance(loupeCenter, p);

    float r = loupeSize;
    float shadowRadius = 0.08;

    // Draw the magnified contents within the loupe:
    if (d <= r) {
        // How "zoomed-in" the magnification effect is.
        float offset = 0.10;

        // Kinda hacky, but keep the magnification radius constant even as the loupe's bounds change.
        r = 0.18;

        // Calculate the bounds of the loupe given its center and radius:
        float loupeMinX = loupeCenter[0] - r;
        float loupeMaxX = loupeCenter[0] + r;
        float loupeMinY = loupeCenter[1] - r;
        float loupeMaxY = loupeCenter[1] + r;

        // The pixels within the loupe need to sample across a smaller range from the underlying texture.
        // This is what gives that "magnification" effect.
        float zoomRangeMinX = loupeMinX + offset;
        float zoomRangeMaxX = loupeMaxX - offset;

        float zoomRangeMinY = loupeMinY + offset;
        float zoomRangeMaxY = loupeMaxY - offset;

        // Calculate the new coordinates to sample.
        // For example, when `px` == `loupeMinX`, it'll be converted to `zoomRangeMinX`.
        float zoomPosX = mapRange(px, loupeMinX, loupeMaxX, zoomRangeMinX, zoomRangeMaxX);
        float zoomPosY = mapRange(py, loupeMinY, loupeMaxY, zoomRangeMinY, zoomRangeMaxY);

        // un-normalize position back to user-space
        // We've been working with normalized unit values, but we need convert those values back to "user-space".
        // These values are considered "denormalized", and we can use them to sample the SwiftUI::Layer texture.
        float2 normalizedSamplePosition = float2(zoomPosX, zoomPosY);
        float2 denormalizedSamplePosition = float2(
                                                   normalizedSamplePosition[0] * size[0],
                                                   normalizedSamplePosition[1] * size[1]
                                                   );

        // Finally, sample the layer with the new, "magnified" coordinate.
        color = layer.sample(denormalizedSamplePosition);
    }
    // This block draws the shadow around the loupe:
    else if (d > r && d <= r + shadowRadius) {
        float distanceFromEdge = d - r;

        // Progress is normalized within the [0, 1] range.
        float progress = mapRange(distanceFromEdge, 0, shadowRadius, 1, 0);

        // Decay progress really quickly to create a more realistic shadow.
        progress = easeInQuart(progress);

        // Finally, do some alpha compositing to blend the black shadow color with the original pixel's color:
        float shadowOpacity = mapRange(progress, 1, 0, 0.2, 0);
        color = mix(color, half4(half3(0), 1), half4(shadowOpacity));
    }

    return color;
}
