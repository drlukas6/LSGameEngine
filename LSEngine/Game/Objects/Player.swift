//
//  Player.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

class Player: GameObject {

    init() {
        super.init(mesh: .triangle)
    }

    override func update(deltaTime: Float) {

        let mouseViewport = Mouse.shared.mouseViewportPosition

        rotation.z = -atan2f(mouseViewport.x - position.x, mouseViewport.y - position.y)

        super.update(deltaTime: deltaTime)
    }
}
