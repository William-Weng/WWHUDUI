[English](./README.en.md) | [繁體中文](./README.md)

# [WWHUDUI](https://swiftpackageindex.com/William-Weng)

![SwiftUI](https://img.shields.io/badge/SwiftUI-524520?logo=swift)
[![Swift-5.10](https://img.shields.io/badge/Swift-5.10-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![iOS-17.0](https://img.shields.io/badge/iOS-17.0-pink.svg?style=flat)](https://developer.apple.com/swift/)
![TAG](https://img.shields.io/github/v/tag/William-Weng/WWHUDUI)
[![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/)
[![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

一個用 SwiftUI 製作的簡單 HUD（Head-Up Display）元件，支援顯示載入指示器、動態文字，以及淡入淡出的顯示效果。HUD 透過 `ViewModifier` 疊加在既有畫面上，並由 `WWHUDUI` 控制顯示狀態與文案內容。

## ✨ [功能特色](https://peterpanswift.github.io/iphone-bezels/)

- 以 `@Observable` 與 `@MainActor` 管理 HUD 狀態，適合直接驅動 SwiftUI 畫面更新。
- 使用 `withAnimation` 與 `.transition(.opacity)` 實作淡入淡出效果，避免 HUD 突然出現或瞬間消失。
- 支援最短顯示時間 `minimumVisibleDuration`，避免 loading 太快時畫面只閃一下。
- 透過 `Task` 管理延遲隱藏流程，連續呼叫 `display()` / `dismiss()` 時可先取消上一個隱藏任務，避免狀態互相干擾。
- 以 `ViewModifier` 封裝，可用 `.loadingOverlay(hud:)` 很自然地套用到任意 SwiftUI View 上。

## 📦 安裝方式

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/William-Weng/WWHUDUI.git", .upToNextMajor(from: "1.0.0"))
]
```

## 🧩 可用API

| 方法 | 說明 |
|---|---|
| `display(_:duration:)` | 顯示 HUD，並以指定動畫時間淡入。 |
| `dismiss(minimumVisibleDuration:duration:)` | 關閉 HUD，並保證至少顯示指定秒數後才淡出。 |

🚀 範例畫面結構

```swift
struct ContentView: View {

    @State private var hud = WWHUDUI()

    var body: some View {
        VStack(spacing: 20) {
            Button("開始載入") {
                hud.display("資料載入中...")

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

