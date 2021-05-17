//
//  Preferences.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

enum ClearColors {

    static let white    = MTLClearColor(red: 1, green: 1, blue: 1, alpha: 1)
    static let green    = MTLClearColor(red: 0.22, green: 0.55, blue: 0.34, alpha: 1)
    static let gray     = MTLClearColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    static let black    = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 1)
}

class Preferences {

    static let shared = Preferences()

    private init() {}

    let clearColor = ClearColors.green
    let mainPixelFormat = MTLPixelFormat.bgra8Unorm

    let startingSceneType = SceneManager.SceneType.sandbox
}
