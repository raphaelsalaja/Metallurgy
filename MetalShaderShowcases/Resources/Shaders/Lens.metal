//
//  Lens.metal
//  MetalShaderShowcases
//
//  Created by Raphael S on 30/06/2023.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;



#define DARK_EDGES

[[ stitchable ]] half4 lens(float2 position, SwiftUI::Layer layer, float time)
{
    // normalized pixel coordinates (from 0 to 1)
    float2 uv = position.xy;
    float aspect = position.x/position.y;
       float2 disorsion = uv-.5;
    
    disorsion.x*=aspect; // aspect correction
    
    // take distance from center
       float len = length(disorsion);
    
    // these are the lens parameters
    float k1 = 1.8;
    float k2 = 1.0;
    float k3 = -3.2;
    
    disorsion
        = disorsion*k1
        + disorsion*len*k2
        + disorsion*len*len*k3;
        // higher powers may be added if necessary
    
    
    disorsion.x/=aspect; // aspect correction
    
    half4 col = layer.sample( disorsion+.5);
  
        float edge = 0.7;
        float dispersion = 0.03;
        col *= half4(
            pow(max(edge-len, 0.0), 0.2),
            pow(max(edge-dispersion-len, 0.0), 0.2),
            pow(max(edge-dispersion*2.0-len, 0.0), 0.2),
        1)*1.2;
   
    return col;
}
