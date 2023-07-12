import PhotosUI
import SlidingRuler
import SwiftUI

struct RandomColors: View {
    @Binding var name: String
    @Binding var author: String
    @Binding var category: Categories
    
    @State var amount: Float = 10.0
    @State var strength: Float = 1.0
    
    @State private var showingPhotosPicker = false
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var photosPickerImage: Image?
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        TimelineView(.animation) { _ in
            List {
                Section {
                    ZStack(alignment: .topTrailing) {
                        if let photosPickerImage {
                            photosPickerImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .layerEffect(
                                    ShaderLibrary.random(
                                        .float(amount),
                                        .float(strength)
                                    ),
                                    maxSampleOffset: .zero
                                )
                                .animation(.linear(duration: 1), value: amount)
                                .animation(.linear(duration: 1), value: strength)
                        }
                            
                        if photosPickerImage == nil {
                            Image(.car)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .layerEffect(
                                    ShaderLibrary.random(
                                        .float(amount),
                                        .float(strength)
                                    ),
                                    maxSampleOffset: .zero
                                )
                                .animation(.linear(duration: 1), value: amount)
                                .animation(.linear(duration: 1), value: strength)
                        }
                       
                        VStack {
                            CategoryButton(category: category)
                        }.padding()
                    }
                    .listRowInsets(EdgeInsets())
                    .frame(alignment: .topTrailing)
                }
                .contextMenu {
                    Section {
                        AnyView(UploadImageButton(showingPhotos: $showingPhotosPicker))
                    }
                    Section {
                        MoreInformationButton()
                    }
                    Section {
                        ResetButton(
                            parameters: Binding.constant([amount, strength])
                        )
                        RandomizeButton(
                            parameters: Binding.constant([amount, strength])
                        )
                    }
                }
                .photosPicker(isPresented: $showingPhotosPicker,
                              selection: $photosPickerItem,
                              matching: .any(of: [.images, .screenshots]))
                .onChange(of: photosPickerItem) {
                    Task {
                        if let data = try? await photosPickerItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                photosPickerImage = Image(uiImage: uiImage)
                                return
                            }
                        }
                    }
                }
                    
                ControlGroup {
                    ShowcaseParameter(
                        value: amount,
                        name: Binding.constant("Colors Amount"),
                        editatble: Binding.constant(true),
                        range: Binding.constant(0 ... 100)
                    )
                    ShowcaseParameter(
                        value: strength,
                        name: Binding.constant("Strength"),
                        editatble: Binding.constant(true),
                        range: Binding.constant(0 ... 1)
                    )
                }.listRowSeparator(.hidden)
            }
            .navigationTitle("Random Colors")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RandomColors(
        name: .constant("Random Colors"),
        author: .constant("Raphael Salaja"),
        category: .constant(Categories.Layer)
    )
}
