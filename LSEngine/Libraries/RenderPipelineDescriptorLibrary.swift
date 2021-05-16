//
//  RenderPipelineDescriptorLibrary.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

protocol RenderPipelineDescriptor {

    var name: String { get }
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor { get }
}

struct BasicRenderPipelineDescriptor: RenderPipelineDescriptor {

    let name = "Basic Render Pipeline Descriptor"

    let renderPipelineDescriptor: MTLRenderPipelineDescriptor = {

        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()

        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.shared.mainPixelFormat
        renderPipelineDescriptor.vertexFunction = ShaderLibrary.shared.vertexFunction(.basic)
        renderPipelineDescriptor.fragmentFunction = ShaderLibrary.shared.fragmentFunction(.basic)
        renderPipelineDescriptor.vertexDescriptor = VertexDescriptorLibrary.shared.vertexDescriptor(.basic)

        return renderPipelineDescriptor
    }()
}

class RenderPipelineDescriptorLibrary {

    enum RenderPipelineDescriptorType {
        case basic
    }

    static let shared = RenderPipelineDescriptorLibrary()

    private var renderPipelineDescriptors = [RenderPipelineDescriptorType: RenderPipelineDescriptor]()

    private init() {}

    func setup() {
        makeDefaultDescriptors()
    }

    private func makeDefaultDescriptors() {
        renderPipelineDescriptors[.basic] = BasicRenderPipelineDescriptor()
    }

    func renderPipelineDescriptor(_ type: RenderPipelineDescriptorType) -> MTLRenderPipelineDescriptor {
        renderPipelineDescriptors[type]!.renderPipelineDescriptor
    }
}
