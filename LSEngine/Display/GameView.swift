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

    private let renderer = Renderer()

    required init(coder: NSCoder) {

        super.init(coder: coder)

        device = MTLCreateSystemDefaultDevice()

        Engine.shared.ignite(with: device!)

        clearColor = Preferences.shared.clearColor

        colorPixelFormat = Preferences.shared.mainPixelFormat

        delegate = renderer
    }
}
