import Observation

import SwiftUI

func LibraryView() -> some View {
    let shaders = ShaderShowcases().shaders
    let categories = ShaderShowcases().categories

    return NavigationView {
        List {
            ForEach(shaders) { shader in
                NavigationLink(destination: shader.showcase) {
                    Text(shader.name)
                }
            }
        }.toolbar {
            ToolbarItem(placement: .principal) {
                Picker("Categories", selection: .constant(0)) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
    }
}

func AboutView() -> some View {
    NavigationView {
        List {
            Text("Created by: ")
            Text("Ethan Lipnik")
        }
    }
}

func SettingsView() -> some View {
    NavigationView {
        List {
            Text("Settings")
        }
    }
}

struct ContentView: View {
    var shaders = ShaderShowcases().shaders

    var body: some View {
        NavigationView {
            TabView {
                LibraryView()
                    .tabItem {
                        Image(systemName: "square.grid.2x2")
                        Text("Gallery")
                    }
                AboutView()
                    .tabItem {
                        Image(systemName: "info.circle")
                        Text("About")
                    }
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().colorScheme(.dark)
    }
}
