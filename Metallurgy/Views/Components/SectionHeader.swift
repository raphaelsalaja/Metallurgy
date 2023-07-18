
import SwiftUI

struct SectionHeader: View {
    @State var category: Categories

    func GetIcon(category: Categories) -> Image {
        switch category {
        case .Distortion:
            return Image(systemName: "scale.3d")
        case .Layer:
            return Image(systemName: "square.fill.on.square.fill")
        case .Color:
            return Image(systemName: "swatchpalette.fill")
        }
    }

    func color(category: Categories) -> Color {
        switch category {
        case .Distortion:
            return Color.blue
        case .Layer:
            return Color.green
        case .Color:
            return Color.purple
        }
    }

    var body: some View {
        HStack {
            GetIcon(category: category)
                .font(.footnote)
                .foregroundColor(color(category: category))

            Text(category.rawValue)
                .textCase(nil)
                .font(.headline)
                .foregroundColor(color(category: category))
        }
    }
}

#Preview {
    SectionHeader(category: .Color)
}
