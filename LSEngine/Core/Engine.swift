//
//  Engine.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

class Engine {

    static let shared = Engine()

    private init() {}

    private(set) var device: MTLDevice!
    private(set) var commandQueue: MTLCommandQueue!

    func ignite(with device: MTLDevice) {

        self.device = device

        self.commandQueue = self.device.makeCommandQueue()

        ShaderLibrary.shared.setup(with: self.device.makeDefaultLibrary()!)

        VertexDescriptorLibrary.shared.setup()
        RenderPipelineDescriptorLibrary.shared.setup()

        RenderPipelineStateLibrary.shared.setup()
    }
}
