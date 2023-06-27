//
//  Vignette.metal
//  MetalShaderShowcases
//
//  Created by Raphael S on 23/06/2023.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

//shader_type canvas_item;
//
//uniform float vignette_intensity = 0.4;
//uniform float vignette_opacity : hint_range(0.0, 1.0) = 0.5;
//uniform vec4 vignette_rgb : hint_color = vec4(0.0, 0.0, 0.0, 1.0);
//
//float vignette(vec2 uv){
//    uv *= 1.0 - uv.xy;
//    float vignette = uv.x * uv.y * 15.0;
//    return pow(vignette, vignette_intensity * vignette_opacity);
//}
//
//void fragment(){
//    vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
//    vec4 text = texture(TEXTURE, UV);
//
//    text.rgba *= (vignette_rgb.rgba);
//    text.rgba *= (1.0 - vignette(UV));
//
//    COLOR = vec4((text.rgb)*color.rgb,text.a);
//}

[[ stitchable ]] half4 vignette(float2 position, SwiftUI::Layer layer, float intensity, float opacity) {
    
    half4 current_color = layer.sample(position);
    half4 new_color = current_color;
    
    float2 uv = position;
    
    uv *= 1.0 - uv.xy;
    
    float vignette = uv.x * uv.y * 15.0;
    float vignette_intensity = intensity * opacity;
    float vignette_value = pow(vignette, vignette_intensity);
    
    new_color.rgba *= (1.0 - vignette_value);
    
    
}


