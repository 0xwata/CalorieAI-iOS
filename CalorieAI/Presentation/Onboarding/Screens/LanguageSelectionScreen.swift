//
//  LanguageSelectionView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI

struct LanguageSelectionScreen: View {
    @Binding var selectedLanguage: String
    let onContinue: () -> Void
    
    let languages = [
        "English",
        "Español",
        "中国人",
        "Português",
        "Français",
        "Deutsch",
        "Italiano",
        "Română"
    ]
    
    let flags = [
        "English": "🇺🇸",
        "Español": "🇪🇸",
        "中国人": "🇨🇳",
        "Português": "🇧🇷",
        "Français": "🇫🇷",
        "Deutsch": "🇩🇪",
        "Italiano": "🇮🇹",
        "Română": "🇷🇴"
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Cal AI")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            ForEach(languages, id: \.self) { language in
                Button(action: {
                    selectedLanguage = language
                    onContinue()
                }) {
                    HStack {
                        Text(language)
                            .font(.title3)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        Text(flags[language] ?? "")
                            .font(.title2)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )
                }
                .buttonStyle(PlainButtonStyle())
                .accessibilityLabel("\(language)を選択")
                .accessibilityHint("タップして\(language)を選択し、次の画面に進みます")
                .accessibilityAddTraits(.isButton)
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Text("Purchased on the web?")
                    .foregroundColor(.secondary)
                
                Button("Sign In") {
                    // Sign in action
                }
                .fontWeight(.semibold)
            }
            .padding(.bottom)
        }
        .padding()
    }
}

#Preview {
    LanguageSelectionScreen(selectedLanguage: .constant("English"), onContinue: {})
}
