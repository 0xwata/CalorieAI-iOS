//
//  WorkoutFrequencySelectionView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI

struct WorkoutFrequencySelectionScreen: View {
    @Binding var selectedFrequency: String
    let onContinue: () -> Void
    @Environment(\.presentationMode) var presentationMode
    
    let frequencies = ["0-2", "3-5", "6+"]
    
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
                Image("IMG_8939")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
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
                ForEach(frequencies, id: \.self) { frequency in
                    Button(action: {
                        selectedFrequency = frequency
                    }) {
                        HStack {
                            Text(frequency)
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                            
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedFrequency == frequency ? Color.black : Color(.systemGray6))
                        )
                        .foregroundColor(selectedFrequency == frequency ? .white : .primary)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel("\(frequency)を選択")
                    .accessibilityHint("タップして\(frequency)を選択します")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityValue(selectedFrequency == frequency ? "選択中" : "")
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
                .accessibilityValue(selectedFrequency.isEmpty ? "頻度が選択されていません" : "頻度が選択されています")
            }
            .padding()
        }
    }
}

#Preview {
    WorkoutFrequencySelectionScreen(selectedFrequency: .constant("3-5"), onContinue: {})
}
