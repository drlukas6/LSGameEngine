//
//  Object.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

protocol GameObject {

    var vertices: [Vertex] { get }
    var vertexBuffer: MTLBuffer { get }
}

extension GameObject {

    func render(with renderCommandEncoder: MTLRenderCommandEncoder) {

        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.shared.renderPipelineState(.basic))

        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
    }
}

class Triangle: GameObject {

    let vertices: [Vertex] = [
        .init(position: SIMD3<Float>(0, 1, 0), color: SIMD4<Float>(1, 0, 0, 1)),
        .init(position: SIMD3<Float>(-1, -1, 0), color: SIMD4<Float>(0, 1, 0, 1)),
        .init(position: SIMD3<Float>(1, -1, 0), color: SIMD4<Float>(0, 0, 1, 1)),
    ]

    let vertexBuffer: MTLBuffer

    init() {

        vertexBuffer = Engine.shared.device.makeBuffer(bytes: vertices,
                                                       length: Vertex.stride(of: vertices.count),
                                                       options: [])!
    }
}
