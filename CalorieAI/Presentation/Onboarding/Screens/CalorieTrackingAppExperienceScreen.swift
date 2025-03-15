//
//  CalorieTrackingAppExperienceView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI

struct CalorieTrackingAppExperienceScreen: View {
    @Binding var hasExperience: Bool
    let onContinue: () -> Void
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            // 戻るボタン
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
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
                Image("IMG_8941")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                Text("Have you tried other calorie tracking apps?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                
                Text("This will be used to calibrate your custom plan.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .accessibilityLabel("この情報はあなたのカスタムプランの作成に使用されます")
                
                Spacer()
                    .frame(height: 40)
                
                // 経験選択ボタン
                HStack {
                    Button(action: {
                        hasExperience = false
                    }) {
                        HStack {
                            Text("No")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                            
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(!hasExperience ? Color.black : Color(.systemGray6))
                        )
                        .foregroundColor(!hasExperience ? .white : .primary)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel("いいえを選択")
                    .accessibilityHint("タップしていいえを選択します")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityValue(!hasExperience ? "選択中" : "")
                    
                    Button(action: {
                        hasExperience = true
                    }) {
                        HStack {
                            Text("Yes")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                            
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(hasExperience ? Color.black : Color(.systemGray6))
                        )
                        .foregroundColor(hasExperience ? .white : .primary)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel("はいを選択")
                    .accessibilityHint("タップしてはいを選択します")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityValue(hasExperience ? "選択中" : "")
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
    CalorieTrackingAppExperienceScreen(hasExperience: .constant(false), onContinue: {})
}
