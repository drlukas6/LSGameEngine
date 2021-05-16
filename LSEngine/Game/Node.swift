//
//  Node.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

class Node {

    func render(encoder: MTLRenderCommandEncoder) {

        guard let renderable = self as? Renderable else {
            return
        }

        renderable.render(with: encoder)
    }
}
