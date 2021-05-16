//
//  SandboxScene.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

class SandboxScene: Scene {

    let player = Player()

    override func buildScene() {

        add(child: player)
    }
}
