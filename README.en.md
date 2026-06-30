[English](./README.en.md) | [繁體中文](./README.md)

# [WWHUDUI](https://swiftpackageindex.com/William-Weng)

![SwiftUI](https://img.shields.io/badge/SwiftUI-524520?logo=swift)
[![Swift-5.10](https://img.shields.io/badge/Swift-5.10-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![iOS-17.0](https://img.shields.io/badge/iOS-17.0-pink.svg?style=flat)](https://developer.apple.com/swift/)
![TAG](https://img.shields.io/github/v/tag/William-Weng/WWHUDUI)
[![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/)
[![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

A simple SwiftUI HUD (Head-Up Display) component that supports a loading indicator, dynamic text, and smooth fade-in/fade-out transitions. The HUD is layered on top of existing content with a `ViewModifier`, while `WWHUDUI` controls the presentation state and displayed title.

## ✨ [Features](https://peterpanswift.github.io/iphone-bezels/)

- Manages HUD state with `@Observable` and `@MainActor`, making it ideal for driving SwiftUI UI updates directly.
- Uses `withAnimation` together with `.transition(.opacity)` to create smooth fade-in/fade-out behavior, so the HUD does not appear or disappear abruptly.
- Supports a minimum visible duration through `minimumVisibleDuration`, preventing loading states from flashing too briefly.
- Uses `Task` to manage delayed dismissal, so repeated calls to `display()` / `dismiss()` can cancel the previous hide task and avoid state conflicts.
- Wrapped in a `ViewModifier`, so it can be applied naturally to any SwiftUI view with `.loadingOverlay(hud:)`.

## 📦 Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/William-Weng/WWHUDUI.git", .upToNextMajor(from: "1.0.0"))
]
```

## 🧩 Available APIs

| Method | Description |
|---|---|
| `display(_:duration:)` | Shows the HUD with the specified animation duration. |
| `dismiss(minimumVisibleDuration:duration:)` | Hides the HUD, ensuring it stays visible for at least the specified duration before fading out. |

## 🚀 Example

```swift
struct ContentView: View {

    @State private var hud = WWHUDUI()

    var body: some View {
        VStack(spacing: 20) {
            Button("Start Loading") {
                hud.display("Loading data...")

                Task {
                    try? await Task.sleep(for: .seconds(1.2))
                    hud.dismiss(minimumVisibleDuration: 0.3)
                }
            }
        }
        .loadingOverlay(hud: hud)
    }
}
```
