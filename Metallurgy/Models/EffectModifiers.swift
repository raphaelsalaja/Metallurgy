//
//  EffectModifiers.swift
//  Metallurgy
//
//  Created by Raphael S on 13/07/2023.
//

import SwiftUI

public struct ColorEffectModifier: ViewModifier {
    @State var shader: Showcase
    @State var time = Date()

    func CreateArguments(time: Shader.Argument) -> [Shader.Argument] {
        var args: [Shader.Argument] = []

        if self.shader.time {
            args.append(time)
        }

        for argument in self.shader.arguments {
            args.append(Shader.Argument.float(argument.value))
        }

        return args
    }

    public func body(content: Content) -> some View {
        content
            .colorEffect(
                Shader(
                    function: ShaderFunction(library: .default, name: self.shader.function),
                    arguments: self.CreateArguments(time: Shader.Argument.float(self.time.timeIntervalSinceNow))
                )
            )
    }
}

public struct LayerEffectModifier: ViewModifier {
    @State var shader: Showcase
    @State var time = Date()

    func CreateArguments(time: Shader.Argument) -> [Shader.Argument] {
        var args: [Shader.Argument] = []

        if self.shader.time {
            args.append(time)
        }

        for argument in self.shader.arguments {
            args.append(Shader.Argument.float(argument.value))
        }

        return args
    }

    public func body(content: Content) -> some View {
        content
            .layerEffect(
                Shader(
                    function: ShaderFunction(library: .default, name: self.shader.function),
                    arguments: self.CreateArguments(time: Shader.Argument.float(self.time.timeIntervalSinceNow))
                ),
                maxSampleOffset: .zero
            )
    }
}

public struct DistortionEffectModifier: ViewModifier {
    @State var shader: Showcase
    @State var time = Date()

    func CreateArguments(time: Shader.Argument, size: Shader.Argument) -> [Shader.Argument] {
        var args: [Shader.Argument] = []

        if self.shader.time {
            args.append(time)
        }

        if self.shader.size {
            args.append(size)
        }

        for argument in self.shader.arguments {
            args.append(Shader.Argument.float(argument.value))
        }

        return args
    }

    public func body(content: Content) -> some View {
        content
            .visualEffect { content, proxy in
                content
                    .distortionEffect(
                        Shader(
                            function: ShaderFunction(library: .default, name: self.shader.function),
                            arguments: self.CreateArguments(
                                time: Shader.Argument.float(self.time.timeIntervalSinceNow),
                                size: Shader.Argument.float2(proxy.size)
                            )

                        ),
                        maxSampleOffset: .zero
                    )
            }
    }
}
