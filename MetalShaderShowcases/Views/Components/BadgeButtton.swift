//
//  TypeBadge.swift
//  MetalShaderShowcases
//
//  Created by Raphael S on 25/06/2023.
//

import SwiftUI

struct BadgeButtton: View {
    @Binding var type: BadgeType

    @State var showingSheet = false

    func getColor() -> Color {
        switch type {
        case .Color:
            return Color.red
        case .Distortion:
            return Color.green
        case .Layer:
            return Color.blue
        case .Float:
            return Color.purple
        case .Bool:
            return Color.orange
        }
    }

    var body: some View {
        Button(String(describing: type)) {
            showingSheet.toggle()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(getColor().tertiary)
        .foregroundColor(getColor())
        .cornerRadius(20)
        .font(Font.caption.bold())
        .sheet(isPresented: $showingSheet) {
            BadgeInformation()
        }
    }
}

#Preview {
    BadgeButtton(
        type: .constant(BadgeType.Float)
    )
}
