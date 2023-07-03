import Observation

import SwiftUI

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
                        Text("Library")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
