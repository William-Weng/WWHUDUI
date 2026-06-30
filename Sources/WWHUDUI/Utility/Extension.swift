//
//  Extension.swift
//  WWHUDUI
//
//  Created by William.Weng on 2026/6/30.
//

import SwiftUI

// MARK: - View
public extension View {
    
    /// 在目前 view 上方顯示一個 loading HUD
    ///
    /// 這個方法會套用 `WWHUDModifier`，並根據 `hud` 的狀態來決定是否顯示 overlay
    ///
    /// - Parameters:
    ///   - hud: 控制 HUD 顯示狀態與文字內容的物件
    ///   - background: HUD 卡片的背景顏色，預設為半透明黑色
    ///
    /// - Returns: 套用 loading HUD 後的新 view
    func loadingOverlay(hud: WWHUDUI, background: Color = .black.opacity(0.25)) -> some View {
        modifier(WWHUDModifier(controller: hud, background: background))
    }
}
