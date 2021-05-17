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

    private var renderer: Renderer!

    override var acceptsFirstResponder: Bool {
        true
    }

    required init(coder: NSCoder) {

        super.init(coder: coder)

        device = MTLCreateSystemDefaultDevice()

        Engine.shared.ignite(with: device!)

        clearColor = Preferences.shared.clearColor

        colorPixelFormat = Preferences.shared.mainPixelFormat

        renderer = Renderer(on: self)

        delegate = renderer
    }

    // MARK: - Keyboard

    override func keyDown(with event: NSEvent) {

        Keyboard.shared.didPress(key: event.keyCode, on: true)
    }

    override func keyUp(with event: NSEvent) {

        Keyboard.shared.didPress(key: event.keyCode, on: false)
    }

    // MARK: - Mouse

    override func mouseDown(with event: NSEvent) {
        Mouse.shared.didPress(.init(rawValue: event.buttonNumber)!, on: true)
    }

    override func mouseUp(with event: NSEvent) {
        Mouse.shared.didPress(.init(rawValue: event.buttonNumber)!, on: false)
    }

    override func rightMouseDown(with event: NSEvent) {
        Mouse.shared.didPress(.init(rawValue: event.buttonNumber)!, on: true)
    }

    override func rightMouseUp(with event: NSEvent) {
        Mouse.shared.didPress(.init(rawValue: event.buttonNumber)!, on: false)
    }

    override func otherMouseDown(with event: NSEvent) {
        Mouse.shared.didPress(.init(rawValue: event.buttonNumber)!, on: true)
    }

    override func otherMouseUp(with event: NSEvent) {
        Mouse.shared.didPress(.init(rawValue: event.buttonNumber)!, on: false)
    }

    override func mouseMoved(with event: NSEvent) {
        updateMousePosition(with: event)
    }

    override func scrollWheel(with event: NSEvent) {
        Mouse.shared.didScroll(by: Float(event.deltaY))
    }

    override func mouseDragged(with event: NSEvent) {
        updateMousePosition(with: event)
    }

    override func rightMouseDragged(with event: NSEvent) {
        updateMousePosition(with: event)
    }

    override func otherMouseDragged(with event: NSEvent) {
        updateMousePosition(with: event)
    }

    private func updateMousePosition(with event: NSEvent) {

        let location = SIMD2<Float>(Float(event.locationInWindow.x), Float(event.locationInWindow.y))
        let change = SIMD2<Float>(Float(event.deltaX), Float(event.deltaY))

        Mouse.shared.setMousePositionChange(overallPosition: location, delta: change)
    }

    override func updateTrackingAreas() {

        let area = NSTrackingArea(rect: bounds,
                                  options: [.activeAlways, .mouseMoved, .enabledDuringMouseDrag],
                                  owner: self,
                                  userInfo: nil)

        addTrackingArea(area)
    }
}
