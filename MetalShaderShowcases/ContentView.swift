import Observation

import SwiftUI

func LibraryView() -> some View {
    @State var shaders = ShaderShowcases().shaders

    return NavigationView {
        List {
            Section {
                ForEach(shaders) { shader in
                    NavigationLink(destination: shader.showcase) {
                        Text(shader.name)
                    }
                }
            }
            ControlGroup {}
        }
        .navigationTitle("Library")
        .navigationBarTitleDisplayMode(.inline)
        .navigationSplitViewStyle(.balanced)
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
            }.searchable(text: .constant(""))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().colorScheme(.dark)
    }
}
