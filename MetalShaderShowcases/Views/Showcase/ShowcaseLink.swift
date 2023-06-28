////
////  ShowcaseLink.swift
////  MetalShaderShowcases
////
////  Created by Raphael S on 27/06/2023.
////
//
// import SwiftUI
//
// struct ShowcaseLink: View {
//    @Binding var shader: MetalShader
//
//    var body: some View {
//        ZStack {
//            NavigationLink(destination: shader.showcase) { EmptyView() }.opacity(0.0)
//            CardView() // This will be the view that you want to display to the user
//        }
//    }
// }
//
// #Preview {
//    ShowcaseLink(
//        shader: .constant(
//            MetalShader(
//                name: "Sepia",
//                showcase: AnyView(Sepia(
//                    name: .constant("Sepia"),
//                    description: .constant("Sepia makes photos appear hazy, warm, and a bit sentimental. Inverting it makes the photo appear cooler."),
//                    author: .constant("Raphael Salaja"),
//                    category: .constant(Categories.Color)
//                ))
//            )
//        )
//    )
// }
//
// struct CardView: View {
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text("Sepia")
//                    .font(.system(size: 16))
//                    .foregroundColor(Color.primary)
//                Text("Raphael Salaja")
//                    // .font(.body)
//                    .font(.system(size: 16))
//                    .foregroundColor(Color.secondary)
//            }
//
//            Spacer()
//
//            VStack(alignment: .trailing) {
//                Text("Distortion")
//                    .font(.system(size: 16))
//                    .foregroundColor(Color.primary)
//                Text("Simple")
//                    .font(.system(size: 16))
//                    .foregroundColor(Color.primary)
//            }
//        }
//    }
// }
