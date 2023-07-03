#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// Creator: leviathwaite
// Porter: Raphael Salaja
// Source: https://www.shadertoy.com/view/Wlt3zS
// Category: Layer
float sind(float a)
{
    float PI = 3.1415926535897932384626433832795;
    float PI180 = float(PI / 180.0);
    
    return sin(a * PI180);
}

float cosd(float a)
{
    float PI = 3.1415926535897932384626433832795;
    float PI180 = float(PI / 180.0);
    
    return cos(a * PI180);
}

float added(float2 sh, float sa, float ca, float2 c, float d)
{
    return 0.5 + 0.25 * cos((sh.x * sa + sh.y * ca + c.x) * d) + 0.25 * cos((sh.x * ca - sh.y * sa + c.y) * d);
}

[[ stitchable ]] half4 halftone(float2 position, SwiftUI::Layer layer, float time, float strength) {
    // Halftone dot matrix shader
    // @author Tomek Augustyn 2010
    
    // Ported from my old PixelBender experiment
    // https://github.com/og2t/HiSlope/blob/master/src/hislope/pbk/fx/halftone/Halftone.pbk
    
    
    float PI = 3.1415926535897932384626433832795;

    float threshold = 0.75;

    
    float coordX = position.x;
    float coordY = position.y;
    float2 dstCoord = float2(coordX, coordY);
    float2 srcCoord = float2(coordX, coordY);
    float2 rotationCenter = float2(0.5, 0.5);
    float2 shift = dstCoord - rotationCenter;

    float dotSize = 4.0;
    float angle = 30.0;
    
    half3 rasterPattern = half3(
        added(shift, sind(angle + 00.0), cosd(angle), rotationCenter, PI / dotSize * 680.0),
        added(shift, sind(angle + 30.0), cosd(angle), rotationCenter, PI / dotSize * 680.0),
        added(shift, sind(angle + 60.0), cosd(angle), rotationCenter, PI / dotSize * 680.0)
    );
    
    half4 srcPixel = layer.sample(srcCoord);
       
    half4 x = half4(
        (rasterPattern.r * threshold + srcPixel.r - threshold) / (1.0 - threshold),
        (rasterPattern.g * threshold + srcPixel.g - threshold) / (1.0 - threshold),
        (rasterPattern.b * threshold + srcPixel.b - threshold) / (1.0 - threshold),
        layer.sample(position).a
       );
    
    return mix(layer.sample(position), x, strength);

}
    
