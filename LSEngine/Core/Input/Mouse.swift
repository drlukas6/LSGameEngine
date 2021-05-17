//
//  Mouse.swift
//  LSEngine
//
//  Created by Lukas Sestic on 17.05.2021..
//

enum MouseButton: Int {

    case left = 0
    case right = 1
    case center = 2
}

private extension Int {

    static let buttonCount = 12
}

class Mouse {

    static let shared = Mouse()

    private init() {}

    private var mouseButtons = [Bool](repeating: false, count: .buttonCount)

    var mousePosition = SIMD2<Float>(repeating: 0)
    private var mousePositionDelta = SIMD2<Float>(repeating: 0)

    private var scrollWheelPosition = Float(0)
    private var lastWheelPosition = Float(0)

    private var scrollWheelDelta = Float(0)

    func didPress(_ button: MouseButton, on: Bool) {
        mouseButtons[button.rawValue] = on
    }

    func isPressed(_ button: MouseButton) -> Bool {
        mouseButtons[button.rawValue]
    }


    /// Sets the delta distance the mouse had moved
     func setMousePositionChange(overallPosition: SIMD2<Float>, delta: SIMD2<Float>){

        mousePosition = overallPosition
        mousePositionDelta += delta
    }

     func didScroll(by deltaY: Float){

        scrollWheelPosition += deltaY
        scrollWheelDelta += deltaY
    }

    ///Returns the movement of the wheel since last time getDWheel() was called
     func getDWheel() -> Float{

        let position = scrollWheelDelta

        scrollWheelDelta = 0

        return position
    }

    ///Movement on the y axis since last time getDY() was called.
    func getDY()-> Float {

        let result = mousePositionDelta.y

        mousePositionDelta.y = 0

        return result
    }

    ///Movement on the x axis since last time getDX() was called.
    func getDX()-> Float {

        let result = mousePositionDelta.x

        mousePositionDelta.x = 0

        return result
    }

    //Returns the mouse position in screen-view coordinates [-1, 1]
    var mouseViewportPosition: SIMD2<Float> {

        let x = (mousePosition.x - Renderer.screenSize.x * 0.5) / (Renderer.screenSize.x * 0.5)

        let y = (mousePosition.y - Renderer.screenSize.y * 0.5) / (Renderer.screenSize.y * 0.5)

        return SIMD2<Float>(x, y)

    }
}
