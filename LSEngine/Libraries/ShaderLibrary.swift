//
//  ShaderLibrary.swift
//  LSEngine
//
//  Created by Lukas Sestic on 16.05.2021..
//

import MetalKit

protocol Shader {

    var name: String { get }
    var functionName: String { get }

    func function(from library: MTLLibrary) -> MTLFunction
}

struct BasicVertexShader: Shader {

    let name = "Basic Vertex Shader"
    let functionName = "basic_vertex_shader"

    func function(from library: MTLLibrary) -> MTLFunction {

        let function = library.makeFunction(name: functionName)!

        function.label = name

        return function
    }
}

struct BasicFragmentShader: Shader {

    let name = "Basic Fragment Shader"
    let functionName = "basic_fragment_shader"

    func function(from library: MTLLibrary) -> MTLFunction {

        let function = library.makeFunction(name: functionName)!

        function.label = name

        return function
    }
}

class ShaderLibrary {

    enum VertexShader {
        case basic
    }

    enum FragmentShader {
        case basic
    }

    static let shared = ShaderLibrary()

    private(set) var library: MTLLibrary!

    private var vertexShaders = [VertexShader: Shader]()
    private var fragmentShaders = [FragmentShader: Shader]()

    private init()  {}

    func setup(with library: MTLLibrary) {

        self.library = library

        makeDefaultShaders()
    }

    private func makeDefaultShaders() {

        vertexShaders[.basic] = BasicVertexShader()
        fragmentShaders[.basic] = BasicFragmentShader()
    }

    func vertexFunction(_ type: VertexShader) -> MTLFunction {
        vertexShaders[type]!.function(from: library)
    }

    func fragmentFunction(_ type: FragmentShader) -> MTLFunction {
        fragmentShaders[type]!.function(from: library)
    }
}
