//
//  MeshLibrary.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

protocol Mesh {

    var vertexBuffer: MTLBuffer! { get }
    var vertexCount: Int! { get }
}

class CustomMesh: Mesh {

    var vertexBuffer: MTLBuffer!
    var vertexCount: Int!

    var vertices: [Vertex]!

    init() {

        createVertices()

        vertexBuffer = Engine.shared.device.makeBuffer(bytes: vertices,
                                                       length: Vertex.stride(of: vertices.count),
                                                       options: [])!
        vertexCount = vertices.count
    }

    func createVertices() { fatalError("\(#function) Implement me") }
}

class Triangle: CustomMesh {

    override func createVertices() {

        vertices = [
            .init(position: SIMD3<Float>(0, 1, 0), color: SIMD4<Float>(1, 0, 0, 1)),
            .init(position: SIMD3<Float>(-1, -1, 0), color: SIMD4<Float>(0, 1, 0, 1)),
            .init(position: SIMD3<Float>(1, -1, 0), color: SIMD4<Float>(0, 0, 1, 1)),
        ]
    }
}

class Quad: CustomMesh {

    override func createVertices() {

        vertices = [
            .init(position: SIMD3<Float>(0.5, 0.5, 0), color: SIMD4<Float>(1, 0, 0, 1)),
            .init(position: SIMD3<Float>(-0.5, 0.5, 0), color: SIMD4<Float>(0, 1, 0, 1)),
            .init(position: SIMD3<Float>(-0.5, -0.5, 0), color: SIMD4<Float>(0, 0, 1, 1)),

            .init(position: SIMD3<Float>(0.5, 0.5, 0), color: SIMD4<Float>(1, 0, 0, 1)),
            .init(position: SIMD3<Float>(-0.5, -0.5, 0), color: SIMD4<Float>(0, 0, 1, 1)),
            .init(position: SIMD3<Float>(0.5, -0.5, 0), color: SIMD4<Float>(0, 1, 0, 1)),
        ]
    }
}

class MeshLibrary {

    enum MeshType {

        case triangle
        case quad
    }

    static let shared = MeshLibrary()

    private init() {}

    private var meshes = [MeshType: Mesh]()

    func setup() {
        createDefaultMeshes()
    }

    private func createDefaultMeshes() {
        meshes[.triangle] = Triangle()
        meshes[.quad] = Quad()
    }

    func mesh(_ type: MeshType) -> Mesh {
        meshes[type]!
    }
}
