//
//  TypeBadge.swift
//  ShowcaseShowcases
//
//  Created by Raphael S on 25/06/2023.
//

import SwiftUI

struct ParameterButtton: View {
    var parameter: Parameters

    @State var showingSheet = false

    func getParameterColor() -> Color {
        switch parameter {
        case .Float:
            return Color.purple
        case .Integer:
            return Color.yellow
        case .Bool:
            return Color.orange
        }
    }

    var body: some View {
        Button(String(describing: parameter)) {
            showingSheet.toggle()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(getParameterColor().tertiary)
        .foregroundColor(getParameterColor())
        .cornerRadius(20)
        .font(Font.caption.bold())
    }
}

#Preview {
    ParameterButtton(
        parameter: Parameters.Float
    )
}
