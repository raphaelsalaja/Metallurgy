import Observation
import SwiftUI

struct ContentView: View {
    let insets = EdgeInsets(top: 8, leading: 0, bottom:
        8, trailing: 0)

    @State var shaders: [Showcase] = ShaderShowcases().shaders.sorted { $0.name < $1.name }

    @State private var search = ""

    var availableCategories: [Categories] {
        var categories: [Categories] = []

        for shader in shaders {
            if !categories.contains(shader.category) {
                categories.append(shader.category)
            }
        }

        return categories
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(availableCategories) { category in
                    Section {
                        ForEach(shaders.filter { $0.category == category }) { shader in
                            ShowcaseLink(showcase: shader)
                        }
                    } header: {
                        SectionHeader(category: category)
                            .listRowInsets(insets)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Metallurgy")
            .searchable(text: $search,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
