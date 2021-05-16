//
//  Node.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

class Node {

    var position = SIMD3<Float>(repeating: 0)
    var scale = SIMD3<Float>(repeating: 1)
    var rotation = SIMD3<Float>(repeating: 0)

    var modelMatrix: matrix_float4x4 {

        var modelMatrix = matrix_identity_float4x4

        modelMatrix.translate(by: position)

        modelMatrix.scale(by: scale)

        modelMatrix.rotate(by: rotation.x, axis: .x)
        modelMatrix.rotate(by: rotation.y, axis: .y)
        modelMatrix.rotate(by: rotation.z, axis: .z)

        return modelMatrix
    }


    func render(encoder: MTLRenderCommandEncoder) {

        guard let renderable = self as? Renderable else {
            return
        }

        renderable.render(with: encoder)
    }
}
