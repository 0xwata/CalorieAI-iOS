//
//  WorkoutFrequencySelectionView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI

struct WorkoutFrequencySelectionView: View {
    @Binding var selectedFrequency: String
    let onContinue: () -> Void
    
    let frequencies = [
        "0-2": "Workouts now and then",
        "3-5": "A few workouts per week",
        "6+": "Dedicated athlete"
    ]
    
    let icons = [
        "0-2": "•",
        "3-5": "•••",
        "6+": ":::"
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
                                .frame(width: 100, height: 4)
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
                Text("How many workouts do you do per week?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                
                Text("This will be used to calibrate your custom plan.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .accessibilityLabel("この情報はあなたのカスタムプランの作成に使用されます")
                
                Spacer()
                    .frame(height: 40)
                
                // ワークアウト頻度選択ボタン
                ForEach(Array(frequencies.keys.sorted()), id: \.self) { key in
                    Button(action: {
                        selectedFrequency = key
                    }) {
                        HStack {
                            Text(icons[key] ?? "")
                                .font(.title2)
                                .padding(.trailing, 8)
                            
                            VStack(alignment: .leading) {
                                Text(key)
                                    .font(.title3)
                                    .fontWeight(.medium)
                                
                                Text(frequencies[key] ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedFrequency == key ? Color.black : Color(.systemGray6))
                        )
                        .foregroundColor(selectedFrequency == key ? .white : .primary)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel("週\(key)回のワークアウト")
                    .accessibilityHint("\(frequencies[key] ?? "")。タップして選択します")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityValue(selectedFrequency == key ? "選択中" : "")
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
                .disabled(selectedFrequency.isEmpty)
                .opacity(selectedFrequency.isEmpty ? 0.6 : 1)
                .accessibilityLabel("続行")
                .accessibilityHint("次の画面に進みます")
                .accessibilityAddTraits(.isButton)
                .accessibilityValue(selectedFrequency.isEmpty ? "ワークアウト頻度が選択されていません" : "ワークアウト頻度が選択されています")
            }
            .padding()
        }
    }
}

#Preview {
    WorkoutFrequencySelectionView(selectedFrequency: .constant("6+"), onContinue: {})
}
