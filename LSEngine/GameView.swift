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

struct Vertex {

    let position: SIMD3<Float>
    let color: SIMD4<Float>
}

class GameView: MTKView {

    private let logger = Logger()

    var commandQueue: MTLCommandQueue!

    var renderPipelineState: MTLRenderPipelineState!

    private let vertices: [Vertex] = [
        .init(position: SIMD3<Float>(0, 1, 0), color: SIMD4<Float>(1, 0, 0, 1)),
        .init(position: SIMD3<Float>(-1, -1, 0), color: SIMD4<Float>(0, 1, 0, 1)),
        .init(position: SIMD3<Float>(1, -1, 0), color: SIMD4<Float>(0, 0, 1, 1)),
    ]

    private var vertexBuffer: MTLBuffer!

    required init(coder: NSCoder) {

        super.init(coder: coder)

        device = MTLCreateSystemDefaultDevice()

        clearColor = MTLClearColor(red: 0.43, green: 0.73, blue: 0.35, alpha: 1)

        colorPixelFormat = .bgra8Unorm

        commandQueue = device?.makeCommandQueue()

        makeRenderPipelineState()

        makeBuffers()
    }

    private func makeBuffers() {

        vertexBuffer = device?.makeBuffer(bytes: vertices,
                                          length: MemoryLayout<Vertex>.stride * vertices.count,
                                          options: [])
    }

    private func makeRenderPipelineState() {

        let library = device?.makeDefaultLibrary()

        let vertexFunction = library?.makeFunction(name: "basic_vertex_shader")
        let fragmentFunction = library?.makeFunction(name: "basic_fragment_shader")

        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()

        renderPipelineDescriptor.colorAttachments[0].pixelFormat = colorPixelFormat
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction

        do {
            try renderPipelineState = device?.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            logger.error("Error creating render pipeline state: \(error.localizedDescription)")
        }
    }

    override func draw(_ dirtyRect: NSRect) {

        guard let drawable = currentDrawable, let renderPassDescriptor = currentRenderPassDescriptor else {
            return
        }

        let commandBuffer = commandQueue.makeCommandBuffer()

        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)

        renderCommandEncoder?.setRenderPipelineState(renderPipelineState)

        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)

        renderCommandEncoder?.endEncoding()

        commandBuffer?.present(drawable)

        commandBuffer?.commit()
    }
}
