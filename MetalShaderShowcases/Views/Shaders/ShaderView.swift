//
//  Waves.swift
//  SwiftUIByExample
//
//  Created by Raphael S on 20/06/2023.
//

import SwiftUI

struct ShaderView: View {
    @Binding var data: MetalShader
    @State var time = Date()

    func getFunction() -> ShaderFunction {
        return ShaderFunction(library: .default, name: data.name.lowercased())
    }

    func getArguments() -> [Shader.Argument] {
        let parameters = data.parameters
        @State var arguments = [Shader.Argument]()

        for (_, value) in parameters {
            if let floatValue = value.variableValue as? Float {
                arguments.append(.float(floatValue))
            }
        }

        return arguments
    }

    var body: some View {
        TimelineView(.animation) { _ in
            List {
                Section {
                    ShowcaseHeading(
                        name: $data.name,
                        category: $data.category,
                        author: $data.author
                    )

                    switch data.category {
                    case .Color:
                        ShowcaseImage()
                            .colorEffect(Shader(
                                function: getFunction(),
                                arguments: getArguments()
                            ))
                    case .Distortion:
                        ShowcaseImage()
                            .visualEffect { content, proxy in
                                content
                                    .distortionEffect(Shader(
                                        function: getFunction(),
                                        arguments: [
                                            .float(time.timeIntervalSinceNow),
                                            .float2(proxy.size),
                                        ] +
                                            getArguments()

                                    ),
                                    maxSampleOffset: .zero)
                            }
                    case .Layer:
                        ShowcaseImage()
                            .layerEffect(Shader(
                                function: getFunction(),
                                arguments: getArguments()
                            ),
                            maxSampleOffset: .zero)
                    }
                }

//                MetalShader(
//                    name: "Sepia",
//                    description: "Sepia makes photos appear hazy, warm, and a bit sentimental. Inverting it makes the photo appear cooler.",
//                    author: "Raphael Salaja",
//                    category: Categories.Color,
//                    complexity: Complexity.Low,
//                    parameters: ["Strength": (variableValue: 0.5, editable: true)]
//                )

//                ShowcaseParameter(
//                    value: .constant(0.5),
//                    name: .constant("Name"),
//                    description: .constant("Description"),
//                    editatble: .constant(true)
//                )

                ForEach(Array(data.parameters), id: \.key) { key, value in
                    ShowcaseParameter(
                        value: getArguments()[0],
                        name: .constant(key),
                        description: .constant(key.description),
                        editatble: .constant(value.editable)
                    )
                }
            }
        }
    }
}

#Preview {
    ShaderView(data: .constant(ShaderShowcases().shaders[0]))
}
