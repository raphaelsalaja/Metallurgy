<p align="center">
    <img height="256" src="https://github.com/rafunderscore/metallurgy/assets/52125687/22988915-fd54-4298-a099-3dc13926779c" />
</p>

## Mission

I started this project as a way to learn more about Metal and how to use it in SwiftUI. Seeing the response of others online intrested in seeing and learning more about this, I decided to make this project open source. I hope that this project will help others learn more about Metal and how to use it in SwiftUI.

<p align="center">
    <video controls>
        <source src="https://github.com/rafunderscore/metallurgy/assets/52125687/f8eadeb0-20df-4d3a-af96-3c7a4038a99a">
    </video>
</p>

## Architecture

The overall architecture of the project is fairly simple to grasp, but there are a few things to keep in mind when adding new shaders to the project.

Firstly, the project is split into two main parts: the list view and the detail view. The list view is where the user will see all of the shaders that are available to them. The detail view is where the user will see the shader in action and be able to adjust the arguments of the shader.

Secondly, the shaders is split into three main parts: the shader showcases, the shader models, and the shader functions. The shader showcases hold the data for each shader. The shader models hold the data for each argument. The shader functions hold the functions for each shader.

The shaders are then passed into a class which holds the data for each individual shader. This array of shaders is then passed into the list view where it is displayed to the user. When the user selects a shader, the shader is passed into the detail view where it is displayed to the user.

The project is set up like this to provide an emphasis on the shaders themselves. The shaders are the main focus of the project. Doing this allows for the shaders to be easily added and removed from the project without having to worry about creating individual views for each shader.

<p align="center">
    <table>
        <tr>
            <td>    
                <p align="center">
                    <video width="320" height="320" controls>
                        <source src="https://github.com/rafunderscore/metallurgy/assets/52125687/f96fe26b-6744-4491-9566-88bc8dc5c53b">
                    </video>
                </p>
            </td>
            <td>   
                <p align="center">
                    <video width="320" height="320" controls>
                        <source src="https://github.com/rafunderscore/metallurgy/assets/52125687/06486bdd-3178-45d9-8fdd-a913545d7e7c">
                    </video>
                </p>
            </td>
        </tr>
    </table>
</p>

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

This will hold the arguments that will be passed into the shader. Make sure they are in the same order as the arguments in the shader function.

## Contributing

This project is open to and encourages contributions! Feel free to discuss any bug fixes/features by creating a new. If you are interested in contributing code to this project, fork the repository and submit a pull request. Please make sure to document your code changes and test the project before submitting a pull request. Try to keep the code style consistent with the rest of the project as well.

## Disclaimer

This project is open source under the MIT license, which means you have full access to the source code and can modify it to fit your own needs.

This project is also still in beta, so there may be some bugs or areas that could be improved. If you find any bugs or areas that could be improved, please report them by creating a new issue.
