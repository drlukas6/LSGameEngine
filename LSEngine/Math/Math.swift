//
//  Math.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

extension matrix_float4x4 {

    mutating func translate(by translation: SIMD3<Float>) {

        var translationMatrix = matrix_float4x4([
            .init(1, 0, 0, 0),
            .init(0, 1, 0, 0),
            .init(0, 0, 1, 0),
            .init(translation.x, translation.y, translation.z, 1),
        ])

        self = matrix_multiply(self, translationMatrix)
    }
}
