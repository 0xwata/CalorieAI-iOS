//
//  GoalObstaclesSelectionView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI

struct GoalObstaclesSelectionView: View {
    @Binding var selectedObstacle: String
    let onContinue: () -> Void
    
    let obstacles = [
        "Lack of consistency",
        "Unhealthy eating habits",
        "Lack of support",
        "Busy schedule",
        "Lack of meal inspiration"
    ]
    
    let icons = [
        "Lack of consistency": "📊",
        "Unhealthy eating habits": "🍔",
        "Lack of support": "👥",
        "Busy schedule": "📅",
        "Lack of meal inspiration": "🍽️"
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
                                .frame(width: 500, height: 4)
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
                Text("What's stopping you from reaching your goals?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                
                Spacer()
                    .frame(height: 40)
                
                // 障害要因選択
                ForEach(obstacles, id: \.self) { obstacle in
                    Button(action: {
                        selectedObstacle = obstacle
                    }) {
                        HStack {
                            Text(icons[obstacle] ?? "")
                                .font(.title2)
                                .padding(.trailing, 8)
                            
                            Text(obstacle)
                                .font(.title3)
                                .fontWeight(.medium)
                            
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedObstacle == obstacle ? Color.black : Color(.systemGray6))
                        )
                        .foregroundColor(selectedObstacle == obstacle ? .white : .primary)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel("\(obstacle)が目標達成の障害です")
                    .accessibilityHint("タップして選択します")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityValue(selectedObstacle == obstacle ? "選択中" : "")
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
                                .fill(Color.gray)
                        )
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(selectedObstacle.isEmpty)
                .opacity(selectedObstacle.isEmpty ? 0.6 : 1)
                .accessibilityLabel("続行")
                .accessibilityHint("次の画面に進みます")
                .accessibilityAddTraits(.isButton)
                .accessibilityValue(selectedObstacle.isEmpty ? "障害が選択されていません" : "障害が選択されています")
            }
            .padding()
        }
    }
}

#Preview {
    GoalObstaclesSelectionView(selectedObstacle: .constant("Lack of consistency"), onContinue: {})
}
