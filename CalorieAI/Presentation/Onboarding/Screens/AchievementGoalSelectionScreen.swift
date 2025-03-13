//
//  AchievementGoalSelectionView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI

struct AchievementGoalSelectionView: View {
    @Binding var selectedGoal: String
    let onContinue: () -> Void
    
    let goals = [
        "Eat and live healthier",
        "Boost my energy and mood",
        "Stay motivated and consistent",
        "Feel better about my body"
    ]
    
    let icons = [
        "Eat and live healthier": "🍎",
        "Boost my energy and mood": "☀️",
        "Stay motivated and consistent": "💪",
        "Feel better about my body": "🧘"
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            // 通知バー
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                    .accessibilityHidden(true)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("times_sakai (ONIGIRI)")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("今")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Text("Yuya Sakai: 作れそうか見てみてー")
                        .font(.subheadline)
                }
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .accessibilityHidden(true)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
            .accessibilityElement(children: .combine)
            .accessibilityLabel("通知: times_sakai (ONIGIRI)からのメッセージ")
            .accessibilityValue("Yuya Sakai: 作れそうか見てみてー")
            
            // メインコンテンツ
            VStack(alignment: .leading, spacing: 16) {
                Text("What would you like to accomplish?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                
                Spacer()
                    .frame(height: 40)
                
                // 目標選択
                ForEach(goals, id: \.self) { goal in
                    Button(action: {
                        selectedGoal = goal
                    }) {
                        HStack {
                            Text(icons[goal] ?? "")
                                .font(.title2)
                                .padding(.trailing, 8)
                            
                            Text(goal)
                                .font(.title3)
                                .fontWeight(.medium)
                            
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
                    .accessibilityLabel("\(goal)を目標にする")
                    .accessibilityHint("タップして\(goal)を目標として選択します")
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
                .disabled(selectedGoal.isEmpty)
                .opacity(selectedGoal.isEmpty ? 0.6 : 1)
                .accessibilityLabel("続行")
                .accessibilityHint("次の画面に進みます")
                .accessibilityAddTraits(.isButton)
                .accessibilityValue(selectedGoal.isEmpty ? "目標が選択されていません" : "目標が選択されています")
            }
            .padding()
        }
    }
}

#Preview {
    AchievementGoalSelectionView(selectedGoal: .constant("Eat and live healthier"), onContinue: {})
}
