#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

// Creator: leviathwaite
// Porter: Raphael Salaja
// Source: https://www.shadertoy.com/view/Wlt3zS
// Category: Layer
float sat( float t ) {
    return clamp( t, 0.0, 1.0 );
}

float2 sat( float2 t ) {
    return clamp( t, 0.0, 1.0 );
}

//remaps inteval [a;b] to [0;1]
float remap  ( float t, float a, float b ) {
    return sat( (t - a) / (b - a) );
}

//note: /\ t=[0;0.5;1], y=[0;1;0]
float linterp( float t ) {
    return sat( 1.0 - abs( 2.0*t - 1.0 ) );
}

half3 spectrum_offset( float t ) {
    half3 ret;
    float lo = step(t,0.5);
    float hi = 1.0-lo;
    float w = linterp( remap( t, 1.0/6.0, 5.0/6.0 ) );
    float neg_w = 1.0-w;
    ret = half3(lo,1.0,hi) * half3(neg_w, w, neg_w);
    return pow( ret, half3(1.0/2.2) );
}

//note: [0;1]
float rand( float2 n ) {
  return fract(sin(dot(n.xy, float2(12.9898, 78.233)))* 43758.5453);
}

//note: [-1;1]
float srand( float2 n ) {
    return rand(n) * 2.0 - 1.0;
}

float mytrunc( float x, float num_levels )
{
    return floor(x*num_levels) / num_levels;
}
float2 mytrunc( float2 x, float num_levels )
{
    return floor(x*num_levels) / num_levels;
}

[[ stitchable ]] half4 glitch(float2 position, SwiftUI::Layer layer, float time) {
    float2 uv = position;
    uv.y = uv.y;
    
    float x = 100 * time;
    float y = 32;
    
    time = modf(x, y) / 110.0; // + modelmat[0].x + modelmat[0].z;

    float GLITCH = 0.1 + position.x;
    
    float gnm = sat( GLITCH );
    float rnd0 = rand( mytrunc( float2(time, time), 6.0 ) );
    float r0 = sat((1.0-gnm)*0.7 + rnd0);
    float rnd1 = rand( float2(mytrunc( uv.x, 10.0*r0 ), time) ); //horz
    //float r1 = 1.0f - sat( (1.0f-gnm)*0.5f + rnd1 );
    float r1 = 0.5 - 0.5 * gnm + rnd1;
    r1 = 1.0 - max( 0.0, ((r1<1.0) ? r1 : 0.9999999) ); //note: weird ass bug on old drivers
    float rnd2 = rand( float2(mytrunc( uv.y, 40.0*r1 ), time) ); //vert
    float r2 = sat( rnd2 );

    float rnd3 = rand( float2(mytrunc( uv.y, 10.0*r0 ), time) );
    float r3 = (1.0-sat(rnd3+0.8)) - 0.1;

    float pxrnd = rand( uv + time );

    float ofs = 0.05 * r2 * GLITCH * ( rnd0 > 0.5 ? 1.0 : -1.0 );
    ofs += 0.5 * pxrnd * ofs;

    uv.y += 0.1 * r3 * GLITCH;

    const int NUM_SAMPLES = 20;
    const float RCP_NUM_SAMPLES_F = 1.0 / float(NUM_SAMPLES);
    
    half4 sum = half4(0.0);
    half3 wsum = half3(0.0);
 
    sum.rgb /= wsum;
    sum.a *= RCP_NUM_SAMPLES_F;

//    fragColor.a = sum.a;
//    fragColor.rgb = sum.rgb; // * outcol0.a;
    
    return mix( layer.sample(position), sum, 1 );

}
