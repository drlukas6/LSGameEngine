//
//  Renderable.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

protocol Renderable {

    func render(with encoder: MTLRenderCommandEncoder)
}
