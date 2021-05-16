//
//  RenderPipelineStateLibrary.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

protocol RenderPipelineState {

    var name: String { get }
    var renderPipelineState: MTLRenderPipelineState { get }
}

struct BasicRenderPipelineState: RenderPipelineState {

    let name = "Basic Render Pipeline sState"

    let renderPipelineState: MTLRenderPipelineState = {

        do {

            let descriptor = RenderPipelineDescriptorLibrary.shared.renderPipelineDescriptor(.basic)

            return try Engine.shared.device.makeRenderPipelineState(descriptor: descriptor)
        } catch {
            fatalError("Error creating render pipeline state: \(error)")
        }
    }()
}

class RenderPipelineStateLibrary {

    enum RenderPipelineStateType {
        case basic
    }

    static let shared = RenderPipelineStateLibrary()

    private var renderPipelineStates = [RenderPipelineStateType: RenderPipelineState]()

    private init() {}

    func setup() {
        makeDefaultPipelines()
    }

    private func makeDefaultPipelines() {
        renderPipelineStates[.basic] = BasicRenderPipelineState()
    }

    func renderPipelineState(_ type: RenderPipelineStateType) -> MTLRenderPipelineState {
        renderPipelineStates[type]!.renderPipelineState
    }
}
