import PhotosUI
import SlidingRuler
import SwiftUI

extension Image {
    func ShowcaseImageSetup() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(6)
    }
}

struct ShowcaseModelView: View {
    @StateObject var showcase = Showcase()
    
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
            name: self.showcase.function
        )
        
        for argument in self.showcase.arguments {
            self.arguments.append(
                Shader.Argument.float(argument.value)
            )
        }
        
        self.shader = Shader(function: self.function, arguments: self.arguments)
    }
    
    func UpdateShader() {
        self.arguments = []
        for argument in self.showcase.arguments {
            self.arguments.append(
                Shader.Argument.float(argument.value)
            )
        }
        
        self.shader = Shader(function: self.function, arguments: self.arguments)
    }
    
    var body: some View {
        GeometryReader { _ in
            TimelineView(.animation) { _ in
                List {
                    Section {
                        ZStack(alignment: .topTrailing) {
                            if let photosPickerImage {
                                switch self.showcase.category {
                                case .Color:
                                    photosPickerImage
                                        .ShowcaseImageSetup()
                                        .modifier(ColorEffectModifier(shader: self.showcase))
                                case .Layer:
                                    photosPickerImage
                                        .ShowcaseImageSetup()
                                        .modifier(LayerEffectModifier(shader: self.showcase))
                                case .Distortion:
                                    photosPickerImage
                                        .ShowcaseImageSetup()
                                        .modifier(DistortionEffectModifier(shader: self.showcase))
                                }
                            }
                            
                            if photosPickerImage == nil {
                                switch self.showcase.category {
                                case .Color:
                                    Image(.car)
                                        .ShowcaseImageSetup()
                                        .modifier(ColorEffectModifier(shader: self.showcase))
                                case .Layer:
                                    Image(.car)
                                        .ShowcaseImageSetup()
                                        .modifier(LayerEffectModifier(shader: self.showcase))
                                case .Distortion:
                                    Image(.car)
                                        .ShowcaseImageSetup()
                                        .modifier(DistortionEffectModifier(shader: self.showcase))
                                }
                            }
                            VStack {
                                CategoryButton(category: self.showcase.category)
                            }.padding()
                        }
                        .listRowBackground(Color.clear)
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
                        if self.showcase.time {
                            VStack {
                                HStack {
                                    Text("Time")
                                        .fontWeight(.regular)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        
                        ForEach(Array(self.showcase.arguments.enumerated()), id: \.1.id) { id, argument in
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
                                    value: self.$showcase.arguments[id].value,
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
                }
                .navigationTitle(self.showcase.name)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    ShowcaseModelView(showcase: ShaderShowcases().shaders[0])
}
