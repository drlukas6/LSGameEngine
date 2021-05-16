//
//  Types.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import simd

protocol Sizeable {

    static func size(of count: Int) -> Int
    static func stride(of count: Int) -> Int
}

extension Sizeable {

    static func size(of count: Int = 1) -> Int {
        MemoryLayout<Self>.size * count
    }

    static func stride(of count: Int = 1) -> Int {
        MemoryLayout<Self>.stride * count
    }
}

extension SIMD3: Sizeable where ArrayLiteralElement == Float {}

struct Vertex: Sizeable {

    let position: SIMD3<Float>
    let color: SIMD4<Float>
}
