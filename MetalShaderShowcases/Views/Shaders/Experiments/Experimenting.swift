import SwiftUI

enum ViewStates: String, CaseIterable, Identifiable {
    var id: String { UUID().uuidString }

    case Color
    case Layer
    case Distortion
}

struct Experimenting: View {
    @Binding var name: String
    @Binding var description: String
    @Binding var author: String
    @Binding var category: Categories
    
    @State var size: Float = 0
    @State var speed: Float = 0
    @State var strength: Float = 0
    @State var frequency: Float = 0
    
    @State var state: ViewStates = .Color
    
    @State var time = Date()
    
    var body: some View {
        TimelineView(.animation) { _ in
            List {
                Section {
                    ShowcaseHeading(
                        name: .constant(name),
                        category: .constant(category),
                        author: .constant(author)
                    )
                    
                    switch state {
                    case .Color:
                        ShowcaseImage()
                            .distortionEffect(ShaderLibrary.simpleWave(
                                .float(time.timeIntervalSinceNow)
                            ), maxSampleOffset: .zero)
                        
                    case .Layer:
                        ShowcaseImage()
                            .distortionEffect(ShaderLibrary.simpleWave(
                                .float(time.timeIntervalSinceNow)
                            ), maxSampleOffset: .zero)
                        
                    case .Distortion:
                        ShowcaseImage()
                            .visualEffect { content, proxy in
                                content
                                    .distortionEffect(ShaderLibrary.complexWave(
                                        .float(time.timeIntervalSinceNow),
                                        .float2(proxy.size),
                                        .float(0.5),
                                        .float(8),
                                        .float(10)
                                    ), maxSampleOffset: .zero)
                            }
                    }
                    
                    Picker("Visual Effect", selection: $state) {
                        ForEach(WavesStates.allCases) { waves in
                            Text(waves.rawValue.capitalized).tag(waves)
                        }
                    }.pickerStyle(.menu)
                }
                
                switch state {
                case .Color:
                    ShowcaseParameter(
                        value: Binding.constant(0.5),
                        name: Binding.constant("Time"),
                        parameter: Binding.constant(Parameters.Float),
                        description: Binding.constant("Effects the blue channel."),
                        editatble: Binding.constant(false)
                    )
                case .Layer:
                    ShowcaseParameter(
                        value: Binding.constant(0.5),
                        name: Binding.constant("Time"),
                        parameter: Binding.constant(Parameters.Float),
                        description: Binding.constant("Effects the blue channel."),
                        editatble: Binding.constant(false)
                    )
                case .Distortion:
                    ShowcaseParameter(
                        value: Binding.constant(0.5),
                        name: Binding.constant("Time"),
                        parameter: Binding.constant(Parameters.Float),
                        description: Binding.constant("Effects the blue channel."),
                        editatble: Binding.constant(false)
                    )
                }
            }
        }
    }
}

#Preview {
    Waves(
        name: .constant("Waves"),
        description: .constant("A chromatic abberation effect."),
        author: .constant("Paul Hudson, Raphael Salaja"),
        category: .constant(Categories.Distortion)
    ).preferredColorScheme(.dark)
}
