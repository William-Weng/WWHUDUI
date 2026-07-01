//
//  LoadingModifier.swift
//  Wordie
//
//  Created by William.Weng on 2026/6/30.
//

import SwiftUI

/// 一個可重用的 HUD modifier
///
/// 這個 modifier 會在原本的 view 上方疊一層 HUD，當 `controller.isPresented` 為 `true` 時顯示 loading 視圖
struct LoadingModifier: ViewModifier {
    
    var controller: WWHUDUI         // 控制 HUD 顯示狀態與文字內容的物件
    var background: Color           // HUD 卡片的背景顏色
    var cornerRadius: CGFloat = 18  // 卡片圓角半徑
    
    /// 建立 modifier 的實際畫面內容
    ///
    /// 透過 `overlay` 疊上 HUD，當 `controller.isPresented` 為 `true` 時才顯示 `loadingView`
    func body(content: Content) -> some View {
        
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                if controller.isPresented {
                    backgroundView
                    loadingView
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - 私有屬性
private extension LoadingModifier {
    
    /// HUD 本體畫面
    ///
    /// 顯示一個 loading spinner 與文字，並套用固定尺寸、內距與圓角背景
    var loadingView: some View {
        
        ZStack {
            
            VStack(spacing: 12) {
                ProgressView()
                    .tint(.white)
                    .controlSize(.regular)
                
                Text(controller.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 18)
            .frame(minWidth: 92, minHeight: 92)
            .background(background, in: shape)
        }
        .transition(.opacity)
        .allowsHitTesting(true)
    }
    
    /// HUD 背景整體
    var backgroundView: some View {
        
        Color.black.opacity(0.001)
            .ignoresSafeArea()
            .allowsHitTesting(true)
    }
    
    /// HUD 卡片使用的圓角形狀
    var shape: RoundedRectangle {
        .init(cornerRadius: cornerRadius, style: .continuous)
    }
}
