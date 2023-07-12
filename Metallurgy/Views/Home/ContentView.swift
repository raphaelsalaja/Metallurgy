import Observation
import SwiftUI

struct ContentView: View {
    @State var shaders: [Showcase] = ShaderShowcases().shaders

    @State private var search = ""

    var shadersToShow: [Showcase] {
        if search.isEmpty {
            return shaders.sorted(by: { $0.name < $1.name })
        } else {
            return shaders.filter { $0.name.contains(search) }
        }
    }

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
                    // Prior to adding the section you can check if categories for that key has any matches and if not return an EmptyView

                    if shadersToShow.filter({ $0.category == category }).isEmpty {
                        EmptyView()
                    }

                    Section {
                        ForEach(shadersToShow.filter { $0.category == category }) { shader in
                            ShowcaseLink(showcase: shader)
                        }
                    } header: {
                        Text(category.rawValue)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                }
            }
            .listStyle(.inset)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image("AppIcon")
                            .foregroundColor(.accentColor)
                        Text("Library")
                            .font(.headline)
                            .foregroundColor(.primary)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
