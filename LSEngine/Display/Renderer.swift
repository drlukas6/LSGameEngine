//
//  Renderer.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

class Renderer: NSObject {

    static var screenSize = SIMD2<Float>.zero

    init(on mtkView: MTKView) {

        super.init()

        updateScreenSize(view: mtkView)
    }

    private func updateScreenSize(view: MTKView) {
        Self.screenSize = .init(Float(view.bounds.width), Float(view.bounds.height))
    }
}

extension Renderer: MTKViewDelegate {

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        updateScreenSize(view: view)
    }

    func draw(in view: MTKView) {

        guard let drawable = view.currentDrawable, let renderPassDescriptor = view.currentRenderPassDescriptor else {
            return
        }

        let commandBuffer = Engine.shared.commandQueue.makeCommandBuffer()

        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)

        SceneManager.shared.tick(encoder: renderCommandEncoder!, deltaTime: 1 / Float(view.preferredFramesPerSecond))

        renderCommandEncoder?.endEncoding()

        commandBuffer?.present(drawable)

        commandBuffer?.commit()
    }
}
