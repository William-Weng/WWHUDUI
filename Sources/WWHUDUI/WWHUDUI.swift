//
//  WWHUDUI.swift
//  WWHUDUI
//
//  Created by William.Weng on 2026/6/30.
//

import SwiftUI

@MainActor @Observable
public final class WWHUDUI {
    
    public private(set) var isPresented = false     // HUD 是否顯示中
    public private(set) var title = "Loading..."    // HUD 顯示的文字
    
    private var displayDate: Date?                  // 記錄 HUD 開始顯示的時間，用來計算最短顯示時間
    private var dismissTask: Task<Void, Never>?     // 延遲隱藏 HUD 的任務 (防止短時間內重複顯示／隱藏)
    
    public init() {}
}

// MARK: - 公開API
public extension WWHUDUI {
    
    /// 顯示 HUD，並更新顯示文字
    ///
    /// 這個方法會先取消前一次尚未完成的隱藏任務，再記錄本次顯示時間，最後用動畫將 HUD 顯示出來
    ///
    /// - Parameters:
    ///   - title: HUD 顯示的文字內容，預設為 `"Loading..."`
    ///   - duration: 顯示動畫時間，預設為 `0.25` 秒
    func display(_ title: String, duration: TimeInterval = 0.25) {
        
        dismissTask?.cancel()
        dismissTask = nil
        
        self.title = title
        self.displayDate = Date()
        
        withAnimation(.easeInOut(duration: duration)) {
            isPresented = true
        }
    }
    
    /// 隱藏 HUD，並保證至少顯示指定的最短時間
    ///
    /// 如果 HUD 顯示時間還沒達到 `minimumVisibleDuration`，會先補足剩餘時間後再執行隱藏動畫，避免 HUD 一閃而過
    ///
    /// - Parameters:
    ///   - minimumVisibleDuration: HUD 最少顯示秒數，預設為 `0.25` 秒
    ///   - duration: 隱藏動畫時間，預設為 `0.25` 秒
    func dismiss(minimumVisibleDuration: TimeInterval = 0.25, duration: TimeInterval = 0.25) {
        
        dismissTask?.cancel()
        
        let elapsed = Date().timeIntervalSince(displayDate ?? Date())
        let delay = max(0, minimumVisibleDuration - elapsed)
        
        dismissTask = Task { [weak self] in
            
            guard let self else { return }
            
            if delay > 0 {
                try? await Task.sleep(for: .seconds(delay))
            }
            
            guard !Task.isCancelled else { return }
            
            withAnimation(.easeInOut(duration: duration)) {
                isPresented = false
            }
        }
        
        dismissTask = nil
    }
}
