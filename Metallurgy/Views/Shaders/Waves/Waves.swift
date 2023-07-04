import SwiftUI

enum WavesStates: String, CaseIterable, Identifiable {
    var id: String { UUID().uuidString }

    case Simple
    case Complex
}

struct Waves: View {
    @Binding var name: String
    
    @Binding var author: String
    @Binding var category: Categories
    
    @State var size: Float = 0
    @State var speed: Float = 0
    @State var strength: Float = 0
    @State var frequency: Float = 0
    
    @State var state: WavesStates = .Simple
    
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
                    case .Simple:
                        ShowcaseImage()
                            .distortionEffect(ShaderLibrary.simpleWave(
                                .float(time.timeIntervalSinceNow)
                            ), maxSampleOffset: .zero)
                        
                    case .Complex:
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
                    
                    Picker("Version", selection: $state) {
                        ForEach(WavesStates.allCases) { waves in
                            Text(waves.rawValue.capitalized).tag(waves)
                        }
                    }.pickerStyle(.menu)
                }
                
                switch state {
                case .Simple:
                    ShowcaseParameter(
                        value: Binding.constant(0.5),
                        name: Binding.constant("Time"),
                        
                        editatble: Binding.constant(false),
                        range: Binding.constant(0 ... 10)
                    )
                case .Complex:
                    ShowcaseParameter(
                        value: Binding.constant(0.5),
                        name: Binding.constant("Time"),
                        
                        editatble: Binding.constant(false),
                        range: Binding.constant(0 ... 10)
                    )
                    ShowcaseParameter(
                        value: $size,
                        name: Binding.constant("Size"),
                        
                        editatble: Binding.constant(true),
                        range: Binding.constant(0 ... 10)
                    )
                    ShowcaseParameter(
                        value: $speed,
                        name: Binding.constant("Speed"),
                        
                        editatble: Binding.constant(true),
                        range: Binding.constant(0 ... 10)
                    )
                    ShowcaseParameter(
                        value: $strength,
                        name: Binding.constant("Strength"),
                        
                        editatble: Binding.constant(true),
                        range: Binding.constant(0 ... 10)
                    )
                    ShowcaseParameter(
                        value: $frequency,
                        name: Binding.constant("Frequency"),
                        editatble: Binding.constant(true),
                        range: Binding.constant(0 ... 10)
                    )
                }
            }
        }
    }
}

#Preview {
    Waves(
        name: .constant("Waves"),
        author: .constant("Paul Hudson, Raphael Salaja"),
        category: .constant(Categories.Distortion)
    ).preferredColorScheme(.dark)
}
