//
//  GameView.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import Cocoa
import MetalKit
import os.log

class GameView: MTKView {

    private let logger = Logger()

    required init(coder: NSCoder) {

        super.init(coder: coder)

        device = MTLCreateSystemDefaultDevice()

        Engine.shared.ignite(with: device!)

        clearColor = Preferences.shared.clearColor

        colorPixelFormat = Preferences.shared.mainPixelFormat

    }

    override func draw(_ dirtyRect: NSRect) {

        guard let drawable = currentDrawable, let renderPassDescriptor = currentRenderPassDescriptor else {
            return
        }

        let commandBuffer = Engine.shared.commandQueue.makeCommandBuffer()

        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)

        Triangle().render(with: renderCommandEncoder!)

        renderCommandEncoder?.endEncoding()

        commandBuffer?.present(drawable)

        commandBuffer?.commit()
    }
}
