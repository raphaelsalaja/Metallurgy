import SwiftUI

struct LibraryView: View {
    @State var shaders: [MetalShader] = ShaderShowcases().shaders

    @State private var search = ""

    var shadersToShow: [MetalShader] {
        if search.isEmpty {
            return shaders.sorted(by: { $0.name < $1.name })
        } else {
            return shaders.filter { $0.name.contains(search) }
        }
    }

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(shadersToShow) { shader in
                        NavigationLink {
                            ShowcaseModelView(metalshader: shader)
                        } label: {
                            Text(shader.name)
                        }
                    }
                }
            }
            .navigationTitle("Library")
            .navigationBarTitleDisplayMode(.inline)

            .searchable(text: $search,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search")
        }
    }
}

#Preview {
    LibraryView()
}
