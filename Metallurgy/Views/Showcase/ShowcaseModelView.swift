import PhotosUI
import SlidingRuler
import SwiftUI

extension Image {
    func ShowcaseImageSetup() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
    }
}

struct ColorEffectModifier: ViewModifier {
    var shader: Shader

    func body(content: Content) -> some View {
        content
            .colorEffect(
                self.shader
            )
    }
}

struct LayerEffectModifier: ViewModifier {
    var shader: Shader

    func body(content: Content) -> some View {
        content
            .layerEffect(
                self.shader,
                maxSampleOffset: .zero
            )
    }
}

struct DistortionEffectModifier: ViewModifier {
    @State var shader: MetalShader
    @State var time = Date()

    func CreateArguments(time: Shader.Argument, size: Shader.Argument) -> [Shader.Argument] {
        var args: [Shader.Argument] = []

        args.append(time)
        args.append(size)

        for argument in self.shader.arguments {
            args.append(Shader.Argument.float(argument.value))
        }

        return args
    }

    func body(content: Content) -> some View {
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

struct ShowcaseModelView: View {
    @StateObject var metalshader = MetalShader()

    @State var arguments: [Shader.Argument] = []
    @State var shader: Shader = .init(function: .init(library: .default, name: ""), arguments: [])
    @State var function: ShaderFunction = .init(library: .default, name: "")

    @State var photosPickerImage: Image?
    @State var showingPhotosPicker = false
    @State var selectedItem: PhotosPickerItem?
    @State var photosPickerItem: PhotosPickerItem?

    func SetShader() {
        self.function = ShaderFunction(
            library: .default,
            name: self.metalshader.function
        )

        for argument in self.metalshader.arguments {
            self.arguments.append(
                Shader.Argument.float(argument.value)
            )
        }

        self.shader = Shader(function: self.function, arguments: self.arguments)
    }

    func UpdateShader() {
        self.arguments = []
        for argument in self.metalshader.arguments {
            self.arguments.append(
                Shader.Argument.float(argument.value)
            )
        }

        self.shader = Shader(function: self.function, arguments: self.arguments)
    }

    var body: some View {
        TimelineView(.animation) { _ in
            List {
                Section {
                    ZStack(alignment: .topTrailing) {
                        if let photosPickerImage {
                            switch self.metalshader.category {
                            case .Color:
                                photosPickerImage
                                    .ShowcaseImageSetup()
                                    .modifier(ColorEffectModifier(shader: self.shader))
                            case .Layer:
                                photosPickerImage
                                    .ShowcaseImageSetup()
                                    .modifier(LayerEffectModifier(shader: self.shader))
                            case .Distortion:
                                photosPickerImage
                                    .ShowcaseImageSetup()
                                    .modifier(DistortionEffectModifier(shader: self.metalshader))
                            }
                        }

                        if photosPickerImage == nil {
                            switch self.metalshader.category {
                            case .Color:
                                Image(.car)
                                    .ShowcaseImageSetup()
                                    .modifier(ColorEffectModifier(shader: self.shader))
                            case .Layer:
                                Image(.car)
                                    .ShowcaseImageSetup()
                                    .modifier(LayerEffectModifier(shader: self.shader))
                            case .Distortion:
                                Image(.car)
                                    .ShowcaseImageSetup()
                                    .modifier(DistortionEffectModifier(shader: self.metalshader))
                            }
                        }
                        VStack {
                            CategoryButton(category: self.metalshader.category)
                        }.padding()
                    }
                    .listRowInsets(EdgeInsets())
                    .frame(alignment: .topTrailing)
                    .onAppear {
                        self.SetShader()
                    }
                }
                .contextMenu {
                    Section {
                        AnyView(UploadImageButton(showingPhotos: self.$showingPhotosPicker))
                    }
                    Section {
                        MoreInformationButton()
                    }
                }
                .photosPicker(isPresented: self.$showingPhotosPicker,
                              selection: self.$photosPickerItem,
                              matching: .any(of: [.images, .screenshots]))
                .onChange(of: self.photosPickerItem) {
                    Task {
                        if let data = try? await photosPickerItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                self.photosPickerImage = Image(uiImage: uiImage)
                                return
                            }
                        }
                    }
                }
                ControlGroup {
                    ForEach(Array(self.metalshader.arguments.enumerated()), id: \.1.id) { id, argument in
                        VStack {
                            HStack {
                                Text(argument.name)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.secondary)

                                Spacer()

                                Text("\(argument.value, format: .number.precision(.fractionLength(2)))")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.primary)
                                    .animation(.default, value: argument.value)
                            }

                            Slider(
                                value: self.$metalshader.arguments[id].value,
                                in: argument.range,
                                step: 0.01
                            )
                            .animation(.linear(duration: 3), value: argument.value)
                            .onChange(of: argument.value) {
                                self.UpdateShader()
                            }
                        }
                    }
                }
                .navigationTitle(self.metalshader.name)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    ShowcaseModelView(
        metalshader: MetalShader(
            name: "Blacklight",
            author: "Raphael Salaja",
            function: "blacklight",
            category: .Layer,
            arguments: [Argument(
                name: "Strength",
                range: 0 ... 10
            )]
        )
    )
}
