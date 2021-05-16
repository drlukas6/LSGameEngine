//
//  LSShader.metal
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {

    float3 position;
    float4 color;
};

struct RasterizerData {

    float4 position [[ position ]];
    float4 color;
};

vertex RasterizerData basic_vertex_shader(device VertexIn *vertices [[ buffer(0) ]],
                                  uint vertexID [[ vertex_id ]]) {

    return { .position = float4(vertices[vertexID].position, 1), .color = float4(vertices[vertexID].color) };
}

fragment half4 basic_fragment_shader(RasterizerData rd [[ stage_in ]]) {

    float4 color = rd.color;

    return half4(color.r, color.g, color.b, color.a);
}
