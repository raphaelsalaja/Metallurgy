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

struct ShowcaseModelView: View {
    @State var metalshader: MetalShader

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

    // update shader should take in the arguments and update the shader

    func UpdateShader(arguments: [Shader.Argument]) {
        for
    }

    var body: some View {
        TimelineView(.animation) { _ in
            List {
                Section {
                    ZStack(alignment: .topTrailing) {
                        if let photosPickerImage {
                            photosPickerImage
                                .ShowcaseImageSetup()
                                .layerEffect(
                                    self.shader,
                                    maxSampleOffset: .zero
                                )
                        }

                        if photosPickerImage == nil {
                            Image(.car)
                                .ShowcaseImageSetup()
                                .layerEffect(
                                    self.shader,
                                    maxSampleOffset: .zero
                                )
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
                    ForEach(self.metalshader.arguments) { argument in
                        ShowcaseParameter(
                            value: argument.value,
                            name: Binding.constant(argument.name),
                            editatble: Binding.constant(argument.editable),
                            range: Binding.constant(argument.range)
                        )
                        .onChange(of: argument.value) {}

                    }.listRowSeparator(.hidden)
                }
                .navigationTitle("Random Colors")
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
