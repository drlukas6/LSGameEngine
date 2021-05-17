//
//  SceneManager.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

class SceneManager {

    enum SceneType {

        case sandbox
    }

    static let shared = SceneManager()

    private init() {}

    private var currentScene: Scene!

    func setup(with sceneType: SceneType) {

        currentScene = makeScene(ofType: sceneType)
    }

    private func makeScene(ofType type: SceneType) -> Scene {

        switch type {
        case .sandbox: return SandboxScene()
        }
    }

    func tick(encoder: MTLRenderCommandEncoder, deltaTime: Float) {

        currentScene.update(deltaTime: deltaTime)
        currentScene.render(encoder: encoder)
    }
}
