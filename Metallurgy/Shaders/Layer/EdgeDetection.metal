#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// DITHERING

// DESCRIPTION
// https://en.wikipedia.org/wiki/Edge_detection

// LAYER EFFECT
// https://developer.apple.com/documentation/swiftui/view/layereffect(_:maxsampleoffset:isenabled:

// PORT
// https://www.shadertoy.com/view/Mdf3zr

float lookup(float2 p, float dx, float dy, SwiftUI::Layer layer, float time)
{
    float d = sin(time * 5.0)*0.5 + 1.5;

    float2 uv = (p.xy + float2(dx * d, dy * d));
    half4 c = layer.sample(uv.xy);
    
    return 0.2126*c.r + 0.7152*c.g + 0.0722*c.b;
}

[[ stitchable ]] half4 edge_detection(float2 position, SwiftUI::Layer layer, float time) {
    float2 p = position.xy;
    
    float gx = 0.0;
    gx += -1.0 * lookup(p, -1.0, -1.0, layer, time);
    gx += -2.0 * lookup(p, -1.0,  0.0, layer, time);
    gx += -1.0 * lookup(p, -1.0,  1.0, layer, time);
    gx +=  1.0 * lookup(p,  1.0, -1.0, layer, time);
    gx +=  2.0 * lookup(p,  1.0,  0.0, layer, time);
    gx +=  1.0 * lookup(p,  1.0,  1.0, layer, time);
    
    float gy = 0.0;
    gy += -1.0 * lookup(p, -1.0, -1.0, layer, time);
    gy += -2.0 * lookup(p,  0.0, -1.0, layer, time);
    gy += -1.0 * lookup(p,  1.0, -1.0, layer, time);
    gy +=  1.0 * lookup(p, -1.0,  1.0, layer, time);
    gy +=  2.0 * lookup(p,  0.0,  1.0, layer, time);
    gy +=  1.0 * lookup(p,  1.0,  1.0, layer, time);
    
    float g = gx*gx + gy*gy;
    float g2 = g * (sin(time) / 2.0 + 0.5);
    
    half4 col = layer.sample(position);
    col += half4(0.0, g, g2, 1.0);
    
    half4 final = half4(col.r, col.g, col.b, layer.sample(position).a);
    
    return final;
}
