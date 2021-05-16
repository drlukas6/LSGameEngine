//
//  Object.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

class GameObject: Node, Renderable {

    var modelConstants = ModelConstants()

    let mesh: Mesh

    init(mesh: MeshLibrary.MeshType) {

        self.mesh = MeshLibrary.shared.mesh(mesh)
    }

    var time = Float(0)
    func update(withDelta deltaTime: Float) {

        time += deltaTime

        position.x = cos(time)

        updateModelConstants()
    }

    private func updateModelConstants() {

        modelConstants.modelMatrix = modelMatrix
    }

    func render(with encoder: MTLRenderCommandEncoder) {

        encoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 1)

        encoder.setRenderPipelineState(RenderPipelineStateLibrary.shared.renderPipelineState(.basic))

        encoder.setTriangleFillMode(.fill)

        encoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
        encoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: mesh.vertexCount)
    }
}
