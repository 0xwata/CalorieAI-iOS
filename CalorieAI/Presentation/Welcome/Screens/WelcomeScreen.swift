//
//  WelcomeScreen.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/15.
//

import SwiftUI
import Combine

struct WelcomeScreen: View {
    var onComplete: () -> Void
    var onGoToHome: () -> Void
    
    @State private var showLanguageSelection: Bool = false
    @State private var selectedLanguage: String = "English"
    @State private var languageEmoji: String = "🇺🇸"
    @State private var languageCode: String = "EN"
    
    // 言語オプション
    private let languages = [
        ("English", "🇺🇸", "EN"),
        ("Español", "🇪🇸", "ES"),
        ("中国人", "🇨🇳", "CN"),
        ("Português", "🇧🇷", "PT"),
        ("Français", "🇫🇷", "FR"),
        ("Deutsch", "🇩🇪", "DE"),
        ("Italiano", "🇮🇹", "IT"),
        ("Română", "🇷🇴", "RO")
    ]
    
    // タブビューの現在のページ
    @State private var currentPage = 0
    
    // アニメーション用のタイマー関連
    @State private var cancellables = Set<AnyCancellable>()
    
    // スクリーンショット画像の配列
    private let screenImages = ["HomeScreen", "CameraScreen", "ResultsScreen"]
    
    var body: some View {
        ZStack {
            // メインコンテンツ
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button {
                        showLanguageSelection = true
                    } label: {
                        HStack(spacing: 4) {
                            Text(languageEmoji)
                            Text(languageCode)
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                // スクリーンショットカルーセル
                TabView(selection: $currentPage) {
                    ForEach(0..<screenImages.count, id: \.self) { index in
                        Image(screenImages[index])
                            .resizable()
                            .scaledToFit()
                            .tag(index)
                            .transition(.opacity)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: 500)
                .padding(.vertical)
                .animation(.easeInOut, value: currentPage)
                
                Spacer()
                
                // キャッチフレーズ
                Text("Calorie tracking\nmade easy")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal)
                
                Spacer()
                
                // Get Startedボタン
                Button(action: {
                    onComplete()
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(30)
                }
                .padding(.horizontal, 20)
                
                // Go to Homeボタン（デバッグ用）
                Button(action: {
                    onGoToHome()
                }) {
                    Text("Go to Home")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(30)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // Sign Inリンク
                HStack {
                    Text("Purchased on the web?")
                        .foregroundColor(.secondary)
                    
                    Button("Sign In") {
                        // サインイン処理
                    }
                    .fontWeight(.semibold)
                }
                .padding(.top, 8)
                .padding(.bottom, 20)
            }
            
            // 言語選択ダイアログ
            if showLanguageSelection {
                LanguageDialog(
                    languages: languages,
                    isPresented: $showLanguageSelection,
                    selectedLanguage: $selectedLanguage,
                    languageEmoji: $languageEmoji,
                    languageCode: $languageCode
                )
            }
        }
        .onAppear {
            // タイマーイベントを購読してページを自動的に切り替える
            Timer.publish(every: 3, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    withAnimation {
                        currentPage = (currentPage + 1) % screenImages.count
                    }
                }
                .store(in: &cancellables)
        }
        .onDisappear {
            cancellables.forEach { $0.cancel() }
        }
    }
}

// For backward compatibility
struct WelcomeScreenScreen: View {
    var onComplete: () -> Void = {}
    var onGoToHome: () -> Void = {}
    
    var body: some View {
        WelcomeScreen(
            onComplete: onComplete,
            onGoToHome: onGoToHome
        )
    }
}

#Preview {
    WelcomeScreen(onComplete: {}, onGoToHome: {})
}
