import Foundation

class Argument: Identifiable, ObservableObject {
    var id = UUID()
    let name: String
    @Published var value: Float
    let range: ClosedRange<Float>
    let editable: Bool

    init() {
        self.name = ""
        self.value = 0
        self.range = 0 ... 0
        self.editable = false
    }

    init(name: String, range: ClosedRange<Float>) {
        self.name = name
        self.value = Float.random(in: range)
        self.range = range
        self.editable = true
    }
}
