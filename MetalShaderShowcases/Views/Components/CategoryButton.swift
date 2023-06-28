//
//  TypeBadge.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 25/06/2023.
//

import SwiftUI

struct CategoryButton: View {
    var category: Categories

    @State var showingSheet = false

    func getCategoryColor() -> Color {
        switch category {
        case .Color:
            return Color.red
        case .Distortion:
            return Color.green
        case .Layer:
            return Color.blue
        }
    }

    var body: some View {
        Button(String(describing: category)) {
            showingSheet.toggle()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(getCategoryColor().tertiary)
        .foregroundColor(getCategoryColor())
        .cornerRadius(20)
        .font(Font.caption.bold())
    }
}

#Preview {
    CategoryButton(
        category: Categories.Color
    )
}
