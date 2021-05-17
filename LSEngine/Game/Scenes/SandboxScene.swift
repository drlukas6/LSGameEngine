//
//  SandboxScene.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

class SandboxScene: Scene {

    override func buildScene() {

        let count = 5
        for y in -count ..< count {
            for x in -count ..< count {

                let player = Player()

                player.position = .init((Float(x) + 0.5) / Float(count), (Float(y) + 0.5) / Float(count), 0)
                player.scale = .init(repeating: 0.1)

                add(child: player)
            }
        }
    }

    override func update(deltaTime: Float) {

        for child in children {

            child.update(deltaTime: deltaTime)
        }

        super.update(deltaTime: deltaTime)
    }
}
