import Foundation

class Showcase: Identifiable, ObservableObject {
    var id = UUID()
    let name: String
    let time: Bool
    let size: Bool
    let bounding: Bool
    let function: String
    let category: Categories
    @Published var arguments: [Argument]

    init(id: UUID = UUID(), name: String, function: String, category: Categories, arguments: [Argument]) {
        self.id = id
        self.name = name
        self.time = false
        self.size = false
        self.bounding = false
        self.function = function
        self.category = category
        self.arguments = arguments
    }

    init(id: UUID = UUID(), name: String, time: Bool, function: String, category: Categories, arguments: [Argument]) {
        self.id = id
        self.name = name
        self.time = time
        self.size = false
        self.bounding = false
        self.function = function
        self.category = category
        self.arguments = arguments
    }

    init(id: UUID = UUID(), name: String, time: Bool, size: Bool, function: String, category: Categories, arguments: [Argument]) {
        self.id = id
        self.name = name
        self.time = time
        self.size = size
        self.bounding = false
        self.function = function
        self.category = category
        self.arguments = arguments
    }

    init(id: UUID = UUID(), name: String, time: Bool, size: Bool, function: String, category: Categories) {
        self.id = id
        self.name = name
        self.time = time
        self.size = size
        self.bounding = false
        self.function = function
        self.category = category
        self.arguments = []
    }

    init(id: UUID = UUID(), name: String, bounding: Bool, function: String, category: Categories, arguments: [Argument]) {
        self.id = id
        self.name = name
        self.time = false
        self.size = false
        self.bounding = bounding
        self.function = function
        self.category = category
        self.arguments = arguments
    }

    init(id: UUID = UUID(), name: String, time: Bool, function: String, category: Categories) {
        self.id = id
        self.name = name
        self.time = time
        self.size = false
        self.bounding = false
        self.function = function
        self.category = category
        self.arguments = []
    }

    init(id: UUID = UUID(), name: String, function: String, category: Categories) {
        self.id = id
        self.name = name
        self.time = false
        self.size = false
        self.bounding = false
        self.function = function
        self.category = category
        self.arguments = [Argument(name: "Strength", range: 0 ... 1)]
    }

    init() {
        self.id = UUID()
        self.name = ""
        self.time = false
        self.size = false
        self.bounding = false
        self.function = ""
        self.category = .Color
        self.arguments = []
    }
}
