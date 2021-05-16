//
//  Object.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

class GameObject: Node,
                  Renderable {

    let mesh: Mesh

    init(mesh: MeshLibrary.MeshType) {

        self.mesh = MeshLibrary.shared.mesh(mesh)
    }

    func render(with encoder: MTLRenderCommandEncoder) {

        encoder.setRenderPipelineState(RenderPipelineStateLibrary.shared.renderPipelineState(.basic))

        encoder.setTriangleFillMode(.fill)

        encoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
        encoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: mesh.vertexCount)
    }
}
