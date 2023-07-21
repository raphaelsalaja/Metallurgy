import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Color {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #elseif canImport(AppKit)
        typealias NativeColor = NSColor
        #endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0

        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            // You can handle the failure here as you want
            return (0, 0, 0, 0)
        }

        return (r, g, b, o)
    }

    var hex: String {
        String(
            format: "#%02x%02x%02x%02x",
            Int(components.red * 255),
            Int(components.green * 255),
            Int(components.blue * 255),
            Int(components.opacity * 255)
        )
    }
}

struct ShaderPlayground: View {
    @Environment(\.self) var environment
    @State private var color: Color = .red
    @State private var resolvedColor: Color.Resolved?
    @State private var orientation = UIDeviceOrientation.unknown

    @State var strength: Float = 2.0
    @State var red: Float = 4.0
    @State var green: Float = 3.0
    @State var blue: Float = 5.0
    @State var amount: Float = 8.0
    @State var pixel_size: Float = 3.0
    @State var noise_quality: Float = 100.0
    @State var noise_intensity: Float = 2.0
    @State var offset_intensity: Float = 34.0
    @State var color_offset_intensity: Float = 12.0

    @State var time = Date()

    private var OverlayImage: some View {
        Image(.woman)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }

    func getColor() {
        resolvedColor = color.resolve(in: environment)
    }

    var body: some View {
        TimelineView(.animation) { _ in
            HStack {
                List {
                    Section {
                        ShaderPlaygroundParameter(
                            value: self.$strength,
                            name: .constant("Strength"),
                            editatble: .constant(true),
                            range: .constant(0 ... 5)
                        )
                    } footer: {
                        Text("Used accros most of the shader parameters. Determines how much of the effect is applied.")
                            .fontWeight(.regular)
                            .foregroundStyle(.secondary)
                    }
                    Section {
                        ColorPicker("Color Channel Mixer",
                                    selection: $color,
                                    supportsOpacity: false)
                            .fontWeight(.regular)
                            .foregroundStyle(.secondary)
                            .padding(.vertical, 2)
                    } footer: {
                        Text("The color that will be used to mix the channels in the color mixer shader.")
                            .fontWeight(.regular)
                            .foregroundStyle(.secondary)
                    }

                    Section {
                        ShaderPlaygroundParameter(
                            value: self.$amount,
                            name: .constant("Colors Amount"),
                            editatble: .constant(true),
                            range: .constant(0 ... 10)
                        )
                    } footer: {
                        Text("The amount of the colors that will be used when generating the random colors shader")
                            .fontWeight(.regular)
                            .foregroundStyle(.secondary)
                    }

                    Section {
                        ShaderPlaygroundParameter(
                            value: self.$pixel_size,
                            name: .constant("Pixel Size"),
                            editatble: .constant(true),
                            range: .constant(0 ... 10)
                        )

                    } footer: {
                        Text("The size of the pixels in the dithering shader.")
                            .fontWeight(.regular)
                            .foregroundStyle(.secondary)
                    }

                    Section {
                        ShaderPlaygroundParameter(
                            value: self.$noise_quality,
                            name: .constant("Noise Quality"),
                            editatble: .constant(true),
                            range: .constant(0 ... 1000)
                        )

                        ShaderPlaygroundParameter(
                            value: self.$noise_intensity,
                            name: .constant("Noise Intensity"),
                            editatble: .constant(true),
                            range: .constant(0 ... 20)
                        )

                        ShaderPlaygroundParameter(
                            value: self.$offset_intensity,
                            name: .constant("Offset Intensity"),
                            editatble: .constant(true),
                            range: .constant(0 ... 100)
                        )

                        ShaderPlaygroundParameter(
                            value: self.$color_offset_intensity,
                            name: .constant("Color Offset Intensity"),
                            editatble: .constant(true),
                            range: .constant(0 ... 100)
                        )
                    } footer: {
                        Text("The quality of the noise, the intensity of the noise, the intensity of the offset and the intensity of the color offset which are used in the VHS shader")
                            .fontWeight(.regular)
                            .foregroundStyle(.secondary)
                    }
                }
                .onChange(of: color, initial: true, getColor)
                .padding(.top, -32)
                .listSectionSpacing(16)
                .frame(
                    maxWidth: 300,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
                .navigationTitle("Shader Playground")
                VStack {
                    Grid(alignment: .topLeading, horizontalSpacing: 56, verticalSpacing: 24) {
                        GridRow {
                            ShaderPlaygroundShowcase()
                                .colorEffect(ShaderLibrary.blacklight(.float(self.strength)))
                                .animation(.linear(duration: 1), value: self.strength)
                            ShaderPlaygroundShowcase()
                                .colorEffect(ShaderLibrary.bloom(.float(self.strength)))
                                .animation(.linear(duration: 1), value: self.strength)
                            ShaderPlaygroundShowcase()
                                .colorEffect(ShaderLibrary.color_channel_mixer(
                                    .float(color.components.red),
                                    .float(color.components.green),
                                    .float(color.components.blue)
                                ))
                                .animation(.linear(duration: 1), value: self.red)
                                .animation(.linear(duration: 1), value: self.green)
                                .animation(.linear(duration: 1), value: self.blue)
                            ShaderPlaygroundShowcase()
                                .colorEffect(ShaderLibrary.contrast(.float(self.strength)))
                                .animation(.linear(duration: 1), value: self.strength)
                        }

                        GridRow {
                            ShaderPlaygroundShowcase()
                                .colorEffect(ShaderLibrary.greyscale(.float(self.strength)))
                                .animation(.linear(duration: 1), value: self.strength)
                            ShaderPlaygroundShowcase()
                                .colorEffect(ShaderLibrary.infrared(.float(self.strength)))
                                .animation(.linear(duration: 1), value: self.strength)
                            ShaderPlaygroundShowcase()
                                .colorEffect(ShaderLibrary.intensity(.float(self.strength)))
                                .animation(.linear(duration: 1), value: self.strength)
                            ShaderPlaygroundShowcase()
                                .colorEffect(ShaderLibrary.sepia(.float(self.strength)))
                                .animation(.linear(duration: 1), value: self.strength)
                        }

                        GridRow {
                            ShaderPlaygroundShowcase()
                                .layerEffect(ShaderLibrary.chromatic_abberation_time(
                                    .float(self.time.timeIntervalSinceNow),
                                    .float(self.strength)
                                ), maxSampleOffset: .zero)
                                .animation(.linear(duration: 1), value: self.time)
                                .animation(.linear(duration: 1), value: self.strength)
                            ShaderPlaygroundShowcase()
                                .layerEffect(ShaderLibrary.dithering(
                                    .float(self.strength),
                                    .float(self.pixel_size)
                                ), maxSampleOffset: .zero)
                                .animation(.linear(duration: 1), value: self.strength)
                                .animation(.linear(duration: 1), value: self.pixel_size)
                            ShaderPlaygroundShowcase()
                                .layerEffect(ShaderLibrary.edge_detection(
                                    .float(self.time.timeIntervalSinceNow)
                                ), maxSampleOffset: .zero)
                                .animation(.linear(duration: 1), value: self.time)
                            ShaderPlaygroundShowcase()
                                .layerEffect(ShaderLibrary.posterize(
                                    .float(self.strength)
                                ), maxSampleOffset: .zero)
                                .animation(.linear(duration: 1), value: self.strength)
                        }

                        GridRow {
                            ShaderPlaygroundShowcase()
                                .layerEffect(ShaderLibrary.tv_static(
                                    .float(self.amount),
                                    .float(self.strength)
                                ), maxSampleOffset: .zero)
                                .animation(.linear(duration: 1), value: self.amount)
                                .animation(.linear(duration: 1), value: self.strength)
                            ShaderPlaygroundShowcase()
                                .layerEffect(ShaderLibrary.vhs(
                                    .float(self.time.timeIntervalSinceNow),
                                    .float(self.noise_quality),
                                    .float(self.noise_intensity),
                                    .float(self.offset_intensity),
                                    .float(self.color_offset_intensity),
                                    .float(self.strength)
                                ), maxSampleOffset: .zero)
                                .animation(.linear(duration: 1), value: self.amount)
                                .animation(.linear(duration: 1), value: self.strength)
                            ShaderPlaygroundShowcase()
                                .layerEffect(ShaderLibrary.chromatic_abberation_static(
                                    .float(self.red),
                                    .float(self.blue)
                                ), maxSampleOffset: .zero)
                                .animation(.linear(duration: 1), value: self.red)
                                .animation(.linear(duration: 1), value: self.blue)
                            ShaderPlaygroundShowcase()
                        }
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
        }
        .padding()
    }
}

struct ShaderPlayground_Previews: PreviewProvider {
    static var previews: some View {
        ShaderPlayground()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch)"))
            .previewDisplayName("iPad Pro")
    }
}
