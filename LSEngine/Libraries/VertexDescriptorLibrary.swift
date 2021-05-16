//
//  VertexDescriptorLibrary.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

protocol VertexDescriptor {

    var name: String { get }
    var vertexDescriptor: MTLVertexDescriptor { get }
}

struct BasicVertexDescriptor: VertexDescriptor {

    let name = "Basic Vertex Descriptor"

    let vertexDescriptor: MTLVertexDescriptor = {

        let vertexDescriptor = MTLVertexDescriptor()

        // Position
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0

        // Color
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = SIMD3<Float>.size

        vertexDescriptor.layouts[0].stride = Vertex.stride

        return vertexDescriptor
    }()
}

class VertexDescriptorLibrary {

    enum VertexDescriptorType {
        case basic
    }

    static let shared = VertexDescriptorLibrary()

    private var vertexDescriptors = [VertexDescriptorType: VertexDescriptor]()

    private init() {}

    func setup() {
        makeDefaultDescriptors()
    }

    private func makeDefaultDescriptors() {
        vertexDescriptors[.basic] = BasicVertexDescriptor()
    }

    func vertexDescriptor(_ type: VertexDescriptorType) -> MTLVertexDescriptor {
        vertexDescriptors[type]!.vertexDescriptor
    }
}
