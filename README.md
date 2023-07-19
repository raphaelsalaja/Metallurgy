https://github.com/rafunderscore/metallurgy/assets/52125687/88cae9ff-a3f3-4af0-8c43-eb1f3dc8b81e

A collection of metal shaders taking advantage of the brand new visual effect added in the iOS 17 beta

## Mission

I started this project as a way to learn more about Metal and how to use it in SwiftUI. Seeing the response of others online intrested in seeing and learning more about this, I decided to make this project open source. I hope that this project will help others learn more about Metal and how to use it in SwiftUI.

## Architecture

The overall architecture of the project is fairly simple to grasp, but there are a few things to keep in mind when adding new shaders to the project.

Firstly, the project is split into two main parts: the list view and the detail view. The list view is where the user will see all of the shaders that are available to them. The detail view is where the user will see the shader in action and be able to adjust the arguments of the shader.

Secondly, the shaders is split into three main parts: the shader showcases, the shader models, and the shader functions. The shader showcases hold the data for each shader. The shader models hold the data for each argument. The shader functions hold the functions for each shader.

The shaders are then passed into a class which holds the data for each individual shader. This array of shaders is then passed into the list view where it is displayed to the user. When the user selects a shader, the shader is passed into the detail view where it is displayed to the user.

The project is set up like this to provide an emphasis on the shaders themselves. The shaders are the main focus of the project. Doing this allows for the shaders to be easily added and removed from the project without having to worry about creating individual views for each shader.

## Adding Shaders

The process for creating new shaders is fairly simple. There are only a few steps that need to be followed.

### 1. Write A Shader File

Firstly, you must create a new shader metal file. You can find examples from the repository here as well as checking out ShaderToy for more examples. To add a new shader, create a new file in the Shaders folder inside the respective subfolder of the shader type. For example, to add a new visual shader of type color, create a new file in the <code>Shaders/Color</code> folder. 

Try to keep the file name and function name similar to prevent confusion. Use snake case when defining the name of the file to help keep consistency within the files. For example, if the shader name is <code>ColorShader</code>, the file name should be <code>color_shader.metal</code>.

### 2. Add The Shader To The Model

Secondly, you must add the shader to the model. To do this, open the ShaderShowcases.swift file. This file holds the data for each shader. To add a new shader, create a new instance of the Showcase class. This class holds the data for each shader. See the Models section for more information on the Showcase class.

## Models

#### Argument 

This holds the data for each argument. This is passed into each shader which will be used in the shader function. It is also shown in the detail view where it can be adjusted by the user.

```swift
class Argument: Identifiable, ObservableObject {
    var id = UUID()
    let name: String
    @Published var value: Float
    let range: ClosedRange<Float>
    let editable: Bool
}
```

##### `name: String`

This will hold the name of the argument. This will be used to display the name of the argument in the detail view.

##### `value: Float`

This will hold the value of the argument. This will be used to display the value of the argument in the detail view.

##### `range: ClosedRange<Float>`

This will hold the range of the argument. This will be used to display the range of the argument in the detail view.

##### `editable: Bool`

This will hold whether or not the argument should be editable. If the argument should be editable, set this to true. If the argument should not be editable, set this to false.

#### Showcase 

This holds the data for each shader. This will be used to display the name of the shader in the list view and the title of the shader in the detail view.

```swift
class Showcase: Identifiable, ObservableObject {
    var id = UUID()
    let name: String
    let time: Bool
    let size: Bool
    let bounding: Bool
    let function: String
    let category: Categories
    @Published var arguments: [Argument]
}
```

##### `name: String`

This will hold the name of the shader. This will be used to display the name of the shader in the list view and the title of the shader in the detail view.

##### `time: Bool`

This will hold whether or not the shader should have a time argument. If the shader should have a time argument, set this to true. If the shader should not have a time argument, set this to false.

##### `size: Bool`

This will hold whether or not the shader should have a size argument. If the shader should have a size argument, set this to true. If the shader should not have a size argument, set this to false.

##### `bounding: Bool`

This will hold whether or not the shader should have a bounding argument. If the shader should have a bounding argument, set this to true. If the shader should not have a bounding argument, set this to false.

##### `function: String`

This will hold the name of the function that will be called when the shader is run. Be mindful of spelling and capitalization, hence why it is recommended to keep the file name and function name similar.

##### `category: Categories`

This will hold the category of the shader. Whether it is a color shader, a distortion shader, or a layer shader. This will be used to display the category of the shader category button in the detail view.

##### `arguments: [Argument]`

This will hold the arguments that will be passed into the shader. Make sure they are in the same order as the arguments in the shader function. See the ShaderShowcases.swift file for examples.
