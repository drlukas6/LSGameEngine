//
//  SandboxScene.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

class SandboxScene: Scene {

    override func buildScene() {

        for y in -5 ..< 5 {
            for x in -5 ..< 5 {

                let player = Player()

                player.position = .init((Float(x) + 0.5) / 5, (Float(y) + 0.5) / 5, 0)
                player.scale = .init(repeating: 0.1)

                add(child: player)
            }
        }
    }

    override func update(deltaTime: Float) {

        var xPosition = Float(0)

        if (Keyboard.shared.isKeyPressed(key: .rightArrow)) {
            xPosition += deltaTime
        }

        if (Keyboard.shared.isKeyPressed(key: .leftArrow)) {
            xPosition -= deltaTime
        }

        for child in children {
            child.rotation.z += 0.02
            child.position.x += xPosition
        }

        super.update(deltaTime: deltaTime)
    }
}
