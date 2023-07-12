//
//  TypeBadge.swift
//  ShowcaseShowcases
//
//  Created by Raphael S on 25/06/2023.
//

import SwiftUI

struct CategoryButton: View {
    var category: Categories

    @State var showingSheet = false

    var body: some View {
        Button(String(describing: category)) {
            showingSheet.toggle()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(.regularMaterial)
        .foregroundColor(.primary)
        .cornerRadius(20)
        .font(Font.caption.bold())
    }
}

#Preview {
    CategoryButton(
        category: Categories.Color
    )
}
