import SwiftUI

struct UploadImageButton: View {
    @Binding var showingPhotos: Bool
    var body: some View {
        Button {
            showingPhotos.toggle()
        } label: {
            Label("Upload Image", systemImage: "photo.on.rectangle")
        }
    }
}

struct ResetButton: View {
    @Binding var parameters: [Float]
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 1)) {
                for i in parameters.indices {
                    parameters[i] = 1.0
                }
            }
        } label: {
            Label("Reset", systemImage: "repeat")
        }
    }
}

struct RandomizeButton: View {
    @Binding var parameters: [Float]
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 1)) {
                for i in parameters.indices {
                    parameters[i] = Float.random(in: 0.1 ... 10)
                }
            }
        } label: {
            Label("Randomize", systemImage: "shuffle")
        }
    }
}

struct MoreInformationButton: View {
    @Environment(\.openURL) var openURL

    var showcase: Showcase

    let urls: [Categories: String] =
        [.Layer: "https://developer.apple.com/documentation/swiftui/view/layereffect(_:maxsampleoffset:isenabled:]",
         .Color: "https://developer.apple.com/documentation/swiftui/visualeffect/coloreffect(_:isenabled:)",
         .Distortion: "https://developer.apple.com/documentation/swiftui/visualeffect/distortioneffect(_:maxsampleoffset:isenabled:)"]

    var body: some View {
        Button {
            switch showcase.category {
            case .Color:
                openURL(URL(string: urls[.Color]!)!)
            case .Distortion:
                openURL(URL(string: urls[.Distortion]!)!)
            case .Layer:
                openURL(URL(string: urls[.Layer]!)!)
            }
        } label: {
            Label("Open Documentation", systemImage: "book")
        }
    }
}

#Preview {
    MoreInformationButton(showcase: .init())
}
