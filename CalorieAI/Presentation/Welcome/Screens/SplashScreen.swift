//
//  SimpleSplashScreen.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/15.
//

import SwiftUI

struct SplashScreen: View {
    var onComplete: () -> Void
    @State private var opacity: Double = 0
    
    var body: some View {
        ZStack {
            // 白背景
            Color.white.edgesIgnoringSafeArea(.all)
            
            // ロゴ
            VStack(spacing: 0) {
                HStack(spacing: 10) {
                    // リンゴアイコン
                    Image(systemName: "apple.logo")
                        .font(.system(size: 50))
                        .foregroundColor(.black)
                    
                    // Cal AIテキスト
                    Text("Cal AI")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.black)
                }
            }
            .opacity(opacity)
        }
        .onAppear {
            // フェードインアニメーション
            withAnimation(.easeIn(duration: 0.8)) {
                opacity = 1.0
            }
            
            // 2秒後に完了ハンドラーを呼び出す
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    opacity = 0.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    onComplete()
                }
            }
        }
    }
}

#Preview {
    SplashScreen(onComplete: {})
}
