//
//  DesiredWeightInputView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI

struct DesiredWeightInputView: View {
    let currentWeight: Double
    @Binding var targetWeight: Double
    let onContinue: () -> Void
    
    // 体重の範囲設定
    let minWeight: Double = 40.0
    let maxWeight: Double = 150.0
    
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
                                .frame(width: 400, height: 4)
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
                Text("What is your desired weight?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                
                Spacer()
                    .frame(height: 40)
                
                // 目標設定
                VStack(alignment: .center, spacing: 20) {
                    Text("Lose weight")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .accessibilityAddTraits(.isHeader)
                    
                    // 目標体重表示
                    Text("\(String(format: "%.1f", targetWeight)) kg")
                        .font(.system(size: 48, weight: .bold))
                        .accessibilityLabel("目標体重")
                        .accessibilityValue("\(String(format: "%.1f", targetWeight))キログラム")
                    
                    // スライダー
                    Slider(value: $targetWeight, in: minWeight...currentWeight)
                        .accentColor(.black)
                        .accessibilityLabel("目標体重の調整")
                        .accessibilityValue("\(String(format: "%.1f", targetWeight))キログラム")
                        .accessibilityHint("左右にスワイプして目標体重を調整してください。最小\(String(format: "%.1f", minWeight))キログラムから最大\(String(format: "%.1f", currentWeight))キログラムまで設定できます。")
                    
                    // 目盛り
                    HStack {
                        ForEach(0..<10) { _ in
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 1, height: 10)
                            Spacer()
                        }
                        Rectangle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 1, height: 10)
                    }
                    .padding(.horizontal)
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
    DesiredWeightInputView(currentWeight: 75.0, targetWeight: .constant(72.0), onContinue: {})
}
