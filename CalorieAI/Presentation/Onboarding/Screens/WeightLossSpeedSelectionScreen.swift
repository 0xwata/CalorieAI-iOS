//
//  WeightLossSpeedSelectionView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI

struct WeightLossSpeedSelectionView: View {
    @Binding var weightLossPerWeek: Double
    let onContinue: () -> Void
    
    // 減量スピードの範囲設定
    let minWeightLoss: Double = 0.1
    let maxWeightLoss: Double = 1.5
    
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
                                .frame(width: 450, height: 4)
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
                Text("How fast do you want to reach your goal?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                
                Spacer()
                    .frame(height: 40)
                
                // 減量スピード設定
                VStack(alignment: .center, spacing: 20) {
                    Text("Loss weight speed per week")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .accessibilityAddTraits(.isHeader)
                    
                    // 減量スピード表示
                    Text("\(String(format: "%.1f", weightLossPerWeek)) kg")
                        .font(.system(size: 48, weight: .bold))
                        .accessibilityLabel("週あたりの減量目標")
                        .accessibilityValue("週\(String(format: "%.1f", weightLossPerWeek))キログラム")
                    
                    // スライダー
                    HStack {
                        // 遅いアイコン
                        Image(systemName: "tortoise.fill")
                            .font(.title)
                            .foregroundColor(.black)
                            .accessibilityHidden(true)
                        
                        Slider(value: $weightLossPerWeek, in: minWeightLoss...maxWeightLoss)
                            .accentColor(.black)
                            .accessibilityLabel("減量スピードの調整")
                            .accessibilityValue("週\(String(format: "%.1f", weightLossPerWeek))キログラム")
                            .accessibilityHint("左右にスワイプして減量スピードを調整してください。最小週\(String(format: "%.1f", minWeightLoss))キログラムから最大週\(String(format: "%.1f", maxWeightLoss))キログラムまで設定できます。")
                        
                        // 速いアイコン
                        Image(systemName: "hare.fill")
                            .font(.title)
                            .foregroundColor(.black)
                            .accessibilityHidden(true)
                    }
                    
                    // 目盛り
                    HStack {
                        Text("\(String(format: "%.1f", minWeightLoss)) kg")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text("\(String(format: "%.1f", (minWeightLoss + maxWeightLoss) / 2)) kg")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text("\(String(format: "%.1f", maxWeightLoss)) kg")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    // 推奨表示
                    Text("Recommended")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(.systemGray6))
                        )
                        .accessibilityLabel("この減量スピードは推奨値です")
                }
                .padding()
                
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
    WeightLossSpeedSelectionView(weightLossPerWeek: .constant(1.0), onContinue: {})
}
