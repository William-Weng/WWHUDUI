//
//  LoadingModifier.swift
//  Wordie
//
//  Created by William.Weng on 2026/6/30.
//

import SwiftUI

/// 一個可重用的 Toast modifier
///
/// 這個 modifier 會在原本的 view 上方疊一層 toast，當 `controller.isPresented` 為 `true` 時顯示提示視圖
struct ToastModifier: ViewModifier {
    
    var controller: WWHUDUI         // 控制 HUD 顯示狀態與文字內容的物件
    var background: Color           // HUD 卡片的背景顏色
    var cornerRadius: CGFloat = 18  // 卡片圓角半徑
    
    /// 建立 modifier 的實際畫面內容
    ///
    /// 透過 `overlay` 疊上 HUD，當 `controller.isPresented` 為 `true` 時才顯示 `toastView`
    func body(content: Content) -> some View {
        
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                if controller.isPresented {
                    ZStack {
                        backgroundView
                        
                        VStack {
                            Spacer()
                            toastView
                                .padding(.bottom, 24)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
    }
}

// MARK: - 私有屬性
private extension ToastModifier {
    
    /// Toast 本體畫面
    ///
    /// 顯示一段文字，並套用固定尺寸、內距與圓角背景
    var toastView: some View {
        
        Text(controller.title)
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: 280)
            .padding(.horizontal, 24)
            .padding(.vertical, 18)
            .background(background, in: shape)
            .transition(.opacity)
            .allowsHitTesting(false)
    }
    
    /// HUD 背景整體
    var backgroundView: some View {
        
        Color.clear
            .ignoresSafeArea()
            .allowsHitTesting(true)
    }
    
    /// HUD 卡片使用的圓角形狀
    var shape: RoundedRectangle {
        .init(cornerRadius: cornerRadius, style: .continuous)
    }
}
