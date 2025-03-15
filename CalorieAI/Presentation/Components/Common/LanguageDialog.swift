//
//  LanguageDialogView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/15.
//

import SwiftUI

struct LanguageDialog: View {
    let languages: [(String, String, String)]
    @Binding var isPresented: Bool
    @Binding var selectedLanguage: String
    @Binding var languageEmoji: String
    @Binding var languageCode: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 背景のオーバーレイ
                Color.black.opacity(0.5)
                    .onTapGesture {
                        isPresented = false
                    }
                
                // ダイアログコンテンツ
                VStack(spacing: 0) {
                    ForEach(languages, id: \.0) { language, emoji, code in
                        Button {
                            selectedLanguage = language
                            languageEmoji = emoji
                            languageCode = code
                            isPresented = false
                        } label: {
                            HStack(spacing: 12) {
                                Text(language)
                                    .font(.system(size: 20))
                                Text(emoji)
                                    .font(.system(size: 20))
                            }
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                        }
                        .background(Color(red: 248/255, green: 248/255, blue: 253/255))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .frame(width: geometry.size.width)
                .frame(maxHeight: geometry.size.height * 0.7)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    LanguageDialog(
        languages: [
            ("English", "🇺🇸", "EN"),
            ("Español", "🇪🇸", "ES")
        ],
        isPresented: .constant(true),
        selectedLanguage: .constant("English"),
        languageEmoji: .constant("🇺🇸"),
        languageCode: .constant("EN")
    )
} 
