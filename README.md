# TimePoint

A [Swift][swift] model for relative points in time. The API is based on the [Dispatch][dispatch] library, but there are additional methods and
operations added with some customized behavior for special values.

A few server side projects and some other Swift packages needed a representation of points in time. The projects also manipulated time
(such as subtracting two points in time to find the relative difference). Instead of copying the code around between projects, this
common Swift package is being used now as a dependency.

## Usage

### Swift Package Manager

Add this package to your `Package.swift` `dependencies` and target's `dependencies`:

```swift
import PackageDescription

let package = Package(
    name: "Example",
    dependencies: [
        .package(
            url: "https://github.com/bluk/TimePoint",
            from: "0.9.0"
        ),
    ],
    targets: [
        .target(
            name: "YourProject",
            dependencies: ["TimePoint"]
        )
    ]
)
```

### Code

```swift
import TimePoint

let firstPointInTime = TimePoint.now()
// Do some computation
let secondPointInTime = TimePoint.now()
let difference = secondPointInTime - firstPointInTime
```

## Design Considerations

### Why not add extensions to DispatchTime/DispatchTimeInterval?

While practically all of the functionality can be added as extensions to existing types, there are several other libraries that already
added public extensions which cause conflicts. So instead of adding more potential code conflicts to a type that is owned by Apple,
another type is necessary.

## License

[Apache-2.0 License][license]

[license]: LICENSE
[swift]: https://swift.org
[dispatch]: https://developer.apple.com/documentation/dispatch

