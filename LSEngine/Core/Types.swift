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

    static var size: Int {
        Self.size(of: 1)
    }

    static var stride: Int {
        Self.stride(of: 1)
    }

    static func size(of count: Int = 1) -> Int {
        MemoryLayout<Self>.size * count
    }

    static func stride(of count: Int = 1) -> Int {
        MemoryLayout<Self>.stride * count
    }
}

extension SIMD3: Sizeable {}
extension Float: Sizeable{}

struct Vertex: Sizeable {

    let position: SIMD3<Float>
    let color: SIMD4<Float>
}
