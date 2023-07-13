import Foundation
import Observation
import SwiftUI

enum Parameters: String, CaseIterable, Identifiable {
    var id: Self { return self }

    case Float
    case Integer
    case Bool

    var title: String {
        switch self {
        case .Float:
            return "Float"
        case .Integer:
            return "Integer"
        case .Bool:
            return "Bool"
        }
    }
}

enum Complexity: String, CaseIterable, Identifiable {
    var id: Self { return self }

    case Low
    case Medium
    case High

    var title: String {
        switch self {
        case .Low:
            return "Low"
        case .Medium:
            return "Medium"
        case .High:
            return "High"
        }
    }
}

enum Categories: String, CaseIterable, Identifiable {
    var id: Self { return self }

    case Color
    case Distortion
    case Layer

    var title: String {
        switch self {
        case .Color:
            return "Color"
        case .Distortion:
            return "Distortion"
        case .Layer:
            return "Layer"
        }
    }
}

enum SortingOptions: String, CaseIterable, Identifiable {
    var id: Self { return self }

    case Name
    case Author
    case Category
    case Complexity

    var title: String {
        switch self {
        case .Name:
            return "Name"
        case .Author:
            return "Author"
        case .Category:
            return "Category"
        case .Complexity:
            return "Complexity"
        }
    }
}

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

class Showcase: Identifiable, ObservableObject {
    var id = UUID()
    let name: String
    let time: Bool
    let size: Bool
    let function: String
    let category: Categories
    @Published var arguments: [Argument]

    init(id: UUID = UUID(), name: String, function: String, category: Categories, arguments: [Argument]) {
        self.id = id
        self.name = name
        self.time = false
        self.size = false
        self.function = function
        self.category = category
        self.arguments = arguments
    }

    init(id: UUID = UUID(), name: String, time: Bool, function: String, category: Categories, arguments: [Argument]) {
        self.id = id
        self.name = name
        self.time = time
        self.size = false
        self.function = function
        self.category = category
        self.arguments = arguments
    }

    init(id: UUID = UUID(), name: String, time: Bool, size: Bool, function: String, category: Categories, arguments: [Argument]) {
        self.id = id
        self.name = name
        self.time = time
        self.size = size
        self.function = function
        self.category = category
        self.arguments = arguments
    }

    init(id: UUID = UUID(), name: String, time: Bool, size: Bool, function: String, category: Categories) {
        self.id = id
        self.name = name
        self.time = time
        self.size = size
        self.function = function
        self.category = category
        self.arguments = []
    }

    init(id: UUID = UUID(), name: String, time: Bool, function: String, category: Categories) {
        self.id = id
        self.name = name
        self.time = time
        self.size = false
        self.function = function
        self.category = category
        self.arguments = []
    }

    init(id: UUID = UUID(), name: String, function: String, category: Categories) {
        self.id = id
        self.name = name
        self.time = false
        self.size = false
        self.function = function
        self.category = category
        self.arguments = [Argument(name: "Strength", range: 0 ... 1)]
    }

    init() {
        self.id = UUID()
        self.name = ""
        self.time = false
        self.size = false
        self.function = ""
        self.category = .Color
        self.arguments = []
    }
}
