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
    var body: some View {
        Button {
            // Link to documentation
        } label: {
            Label("Documentation", systemImage: "book")
        }
    }
}

#Preview {
    MoreInformationButton()
}
