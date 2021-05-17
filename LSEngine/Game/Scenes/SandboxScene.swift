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

        for child in children {
            child.rotation.z += 0.02
        }

        super.update(deltaTime: deltaTime)
    }
}
