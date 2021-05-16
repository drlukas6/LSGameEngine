//
//  GameView.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import Cocoa
import MetalKit
import os.log
import simd

class GameView: MTKView {

    private let logger = Logger()

    private let vertices: [Vertex] = [
        .init(position: SIMD3<Float>(0, 1, 0), color: SIMD4<Float>(1, 0, 0, 1)),
        .init(position: SIMD3<Float>(-1, -1, 0), color: SIMD4<Float>(0, 1, 0, 1)),
        .init(position: SIMD3<Float>(1, -1, 0), color: SIMD4<Float>(0, 0, 1, 1)),
    ]

    private var vertexBuffer: MTLBuffer!

    required init(coder: NSCoder) {

        super.init(coder: coder)

        device = MTLCreateSystemDefaultDevice()

        Engine.shared.ignite(with: device!)

        clearColor = Preferences.shared.clearColor

        colorPixelFormat = Preferences.shared.mainPixelFormat

        makeBuffers()
    }

    private func makeBuffers() {

        vertexBuffer = Engine.shared.device.makeBuffer(bytes: vertices,
                                          length: Vertex.stride(of: vertices.count),
                                          options: [])
    }

    override func draw(_ dirtyRect: NSRect) {

        guard let drawable = currentDrawable, let renderPassDescriptor = currentRenderPassDescriptor else {
            return
        }

        let commandBuffer = Engine.shared.commandQueue.makeCommandBuffer()

        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)

        renderCommandEncoder?.setRenderPipelineState(RenderPipelineStateLibrary.shared.renderPipelineState(.basic))

        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)

        renderCommandEncoder?.endEncoding()

        commandBuffer?.present(drawable)

        commandBuffer?.commit()
    }
}
