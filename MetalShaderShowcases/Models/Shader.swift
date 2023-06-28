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

@Observable
struct MetalShader: Identifiable {
    var id = UUID()
    var name: String = ""
    var description: String = ""
    var author: String = ""
    var category: Categories = .Color
    var complexity: Complexity = .Low
    var parameters = [String: (variableValue: Float, editable: Bool)]()

    public init(id: UUID = UUID(), name: String, description: String, author: String, category: Categories, complexity: Complexity, parameters: [String: (variableValue: Float, editable: Bool)]) {
        self.id = id
        self.name = name
        self.description = description
        self.author = author
        self.category = category
        self.complexity = complexity
        self.parameters = parameters
    }
}

final class ShaderShowcases {
    var shaders: [MetalShader] = [
        MetalShader(
            name: "Sepia",
            description: "Sepia makes photos appear hazy, warm, and a bit sentimental. Inverting it makes the photo appear cooler.",
            author: "Raphael Salaja",
            category: Categories.Color,
            complexity: Complexity.Low,
            parameters: ["Strength": (variableValue: 0.5, editable: true)]
        ),
    ]
}
