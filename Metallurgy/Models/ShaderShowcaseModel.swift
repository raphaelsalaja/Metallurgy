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
        self.value = (range.lowerBound + range.upperBound) / 2
        self.range = range
        self.editable = true
    }
}

class Showcase: Identifiable, ObservableObject {
    var id = UUID()
    let name: String
    let author: String
    let time: Bool
    let function: String
    let category: Categories
    @Published var arguments: [Argument]

    internal init(id: UUID = UUID(), name: String, author: String, time: Bool, function: String, category: Categories, arguments: [Argument]) {
        self.id = id
        self.name = name
        self.author = author
        self.time = time
        self.function = function
        self.category = category
        self.arguments = arguments
    }

    init(name: String, function: String, category: Categories, time: Bool, arguments: [Argument]) {
        self.name = name
        self.author = "Raphael Salaja"
        self.time = true
        self.function = function
        self.category = category
        self.arguments = arguments
    }

    init(name: String, function: String, category: Categories, arguments: [Argument]) {
        self.name = name
        self.author = "Raphael Salaja"
        self.time = false
        self.function = function
        self.category = category
        self.arguments = arguments
    }

    init(name: String, function: String, arguments: [Argument]) {
        self.name = name
        self.author = "Raphael Salaja"
        self.time = false
        self.function = function
        self.category = .Layer
        self.arguments = arguments
    }

    init() {
        self.name = ""
        self.author = ""
        self.time = false
        self.function = ""
        self.category = .Color
        self.arguments = []
    }
}
