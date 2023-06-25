//
//  Sepia.metal
//  MetalShaderShowcases
//
//  Created by Raphael S on 23/06/2023.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

[[ stitchable ]] half4 sepia(float2 position, half4 color, float strength) {
    half4 originalColor = color;
    half4 newColor = originalColor;
    
    newColor.r = (originalColor.r * (1.0 - (0.607 * strength))) + (originalColor.g * (0.769 * strength)) + (originalColor.b * (0.189 * strength));
    newColor.g = (originalColor.r * (0.349 * strength)) + (originalColor.g * (1.0 - (0.314 * strength))) + (originalColor.b * (0.168 * strength));
    newColor.b = (originalColor.r * (0.272 * strength)) + (originalColor.g * (0.534 * strength)) + (originalColor.b * (1.0 - (0.869 * strength)));
    
    return half4(newColor);
}

