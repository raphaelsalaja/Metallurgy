//
//  ShowcaseView.swift
//  SwiftUIByExample
//
//  Created by Raphael S on 20/06/2023.
//

import SwiftUI

struct ShowcaseView: View {
    var body: some View {
        VStack {
            Image(.image00001)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
                .frame(height: 200)
            
            // code block
            
        }
    }
}

#Preview {
    ShowcaseView()
}
