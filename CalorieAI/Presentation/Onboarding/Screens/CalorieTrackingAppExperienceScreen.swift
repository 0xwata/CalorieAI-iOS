//
//  CalorieTrackingAppExperienceView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI

struct CalorieTrackingAppExperienceView: View {
    @Binding var hasExperience: Bool
    let onContinue: () -> Void
    
    let options = ["No", "Yes"]
    
    let icons = [
        "No": "👎",
        "Yes": "👍"
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            // 戻るボタンと進捗バー
            HStack {
                Button(action: {
                    // 戻るアクション
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .padding()
                        .background(Circle().fill(Color(.systemGray6)))
                }
                .accessibilityLabel("戻る")
                .accessibilityHint("前の画面に戻ります")
                
                Spacer()
                
                // 進捗バー
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 4)
                    .overlay(
                        HStack {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.black)
                                .frame(width: 200, height: 4)
                            Spacer()
                        }
                    )
                    .padding(.horizontal)
                
                // 言語表示
                Text("EN")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.systemGray6))
                    )
                    .overlay(
                        HStack {
                            Text("🇺🇸")
                                .font(.caption)
                        }
                    )
            }
            .padding(.horizontal)
            
            // メインコンテンツ
            VStack(alignment: .leading, spacing: 16) {
                Text("Have you tried other calorie tracking apps?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                
                Spacer()
                    .frame(height: 40)
                
                // 選択ボタン
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        hasExperience = option == "Yes"
                    }) {
                        HStack {
                            Text(icons[option] ?? "")
                                .font(.title2)
                                .padding(.trailing, 8)
                            
                            Text(option)
                                .font(.title3)
                                .fontWeight(.medium)
                            
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill((option == "Yes" && hasExperience) || (option == "No" && !hasExperience) ? Color.black : Color(.systemGray6))
                        )
                        .foregroundColor((option == "Yes" && hasExperience) || (option == "No" && !hasExperience) ? .white : .primary)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel("\(option == "Yes" ? "はい、使用経験があります" : "いいえ、使用経験はありません")")
                    .accessibilityHint("タップして選択します")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityValue((option == "Yes" && hasExperience) || (option == "No" && !hasExperience) ? "選択中" : "")
                }
                
                Spacer()
                
                // 続行ボタン
                Button(action: {
                    onContinue()
                }) {
                    Text("Continue")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.black)
                        )
                }
                .buttonStyle(PlainButtonStyle())
                .accessibilityLabel("続行")
                .accessibilityHint("次の画面に進みます")
                .accessibilityAddTraits(.isButton)
            }
            .padding()
        }
    }
}

#Preview {
    CalorieTrackingAppExperienceView(hasExperience: .constant(true), onContinue: {})
}
