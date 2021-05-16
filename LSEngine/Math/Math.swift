//
//  Math.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

enum Axis {

    case x, y, z

    fileprivate var vector: SIMD3<Float> {

        switch self {
        case .x: return .init(1, 0, 0)
        case .y: return .init(0, 1, 0)
        case .z: return .init(0, 0, 1)
        }
    }
}

extension matrix_float4x4 {

    mutating func translate(by translation: SIMD3<Float>) {

        let translationMatrix = matrix_float4x4([
            .init(1, 0, 0, 0),
            .init(0, 1, 0, 0),
            .init(0, 0, 1, 0),
            .init(translation.x, translation.y, translation.z, 1),
        ])

        self = matrix_multiply(self, translationMatrix)
    }

    mutating func scale(by scale: SIMD3<Float>) {

        let scaleMatrix = matrix_float4x4([
            .init(scale.x, 0, 0, 0),
            .init(0, scale.y, 0, 0),
            .init(0, 0, scale.z, 0),
            .init(0, 0, 0, 1),
        ])

        self = matrix_multiply(self, scaleMatrix)
    }

    mutating func rotate(by angle: Float, axis: Axis){

        let axis = axis.vector

        let x = axis.x
        let y = axis.y
        let z = axis.z

        let c = cos(angle)
        let s = sin(angle)

        let mc = (1 - c)

        let r1c1 = x * x * mc + c
        let r2c1 = x * y * mc + z * s
        let r3c1 = x * z * mc - y * s
        let r4c1 = Float(0.0)

        let r1c2 = y * x * mc - z * s
        let r2c2 = y * y * mc + c
        let r3c2 = y * z * mc + x * s
        let r4c2 = Float(0.0)

        let r1c3 = z * x * mc + y * s
        let r2c3 = z * y * mc - x * s
        let r3c3 = z * z * mc + c
        let r4c3 = Float(0.0)

        let r1c4 = Float(0.0)
        let r2c4 = Float(0.0)
        let r3c4 = Float(0.0)
        let r4c4 = Float(1.0)

        let result = matrix_float4x4([
            .init(r1c1, r2c1, r3c1, r4c1),
            .init(r1c2, r2c2, r3c2, r4c2),
            .init(r1c3, r2c3, r3c3, r4c3),
            .init(r1c4, r2c4, r3c4, r4c4)
        ])

        self = matrix_multiply(self, result)
    }
}
