//
//  AchievementGoalSelectionView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI

struct AchievementGoalSelectionScreen: View {
    @Binding var selectedGoal: String
    let onContinue: () -> Void
    @Environment(\.presentationMode) var presentationMode
    
    let goals = ["Eat and live healthier", "Boost my energy and mood", "Stay motivated and consistent", "Feel better about my body"]
    
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
                                .frame(width: 600, height: 4)
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
                Image("IMG_8952")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                Text("What would you like to accomplish?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                
                Text("This will be used to calibrate your custom plan.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .accessibilityLabel("この情報はあなたのカスタムプランの作成に使用されます")
                
                Spacer()
                    .frame(height: 40)
                
                // 目標選択ボタン
                ForEach(goals, id: \.self) { goal in
                    Button(action: {
                        selectedGoal = goal
                    }) {
                        HStack {
                            Text(goal)
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                            
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedGoal == goal ? Color.black : Color(.systemGray6))
                        )
                        .foregroundColor(selectedGoal == goal ? .white : .primary)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel("\(goal)を選択")
                    .accessibilityHint("タップして\(goal)を選択します")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityValue(selectedGoal == goal ? "選択中" : "")
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
    AchievementGoalSelectionScreen(selectedGoal: .constant("Eat and live healthier"), onContinue: {})
}
