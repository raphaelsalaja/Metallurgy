//
//  Waves.swift
//  SwiftUIByExample
//
//  Created by Raphael S on 20/06/2023.
//

import SwiftUI

struct Sepia: View {
    @State var strength: Float = 0

    var body: some View {
        List {
            Section {
                HStack {
                    Text("Sepia")
                        .fontWeight(.medium)

                    Spacer()

                    HStack {
                        HStack {
                            Text("Color").font(Font.caption.bold())
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.blue.tertiary)
                    .cornerRadius(20)
                }
                .listRowSeparator(.hidden)

                ShowcaseImage()
                    .colorEffect(ShaderLibrary.sepia(.float(strength)))
                    .animation(.linear(duration: 1), value: strength)

                Text("Sepia makes photos appear hazy, warm, and a bit sentimental. Inverting it makes the photo appear cooler.")
                    .font(.callout)
                    .offset()
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
            }

            Section {
                HStack {
                    Text("Strength")
                        .fontWeight(.medium)

                    Spacer()

                    HStack {
                        HStack {
                            Text("Float").font(Font.caption.bold())
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.green.tertiary)
                    .cornerRadius(20)
                }

                Text("Efffects the overall strength of the effect.")
                    .font(.callout)
                    .foregroundStyle(.secondary)

                Slider(value: $strength, in: -10 ... 10, step: 0.5) {
                    Text("Strength")
                } minimumValueLabel: {
                    Text("-10")
                } maximumValueLabel: {
                    Text("10")
                }
            }
        }
    }
}

#Preview {
    Sepia()
}
