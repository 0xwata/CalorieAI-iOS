//
//  HeightWeightInputView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI

struct HeightWeightInputScreen: View {
    @Binding var isMetric: Bool
    @Binding var heightFeet: Int
    @Binding var heightInches: Int
    @Binding var heightCm: Int
    @Binding var weightLbs: Int
    @Binding var weightKg: Double
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
                                .frame(width: 300, height: 4)
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
                Image("IMG_8943")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                Text("Height & weight")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                
                Text("This will be used to calibrate your custom plan.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .accessibilityLabel("この情報はあなたのカスタムプランの作成に使用されます")
                
                Spacer()
                    .frame(height: 40)
                
                // メトリック/インペリアル切り替え
                Toggle(isOn: $isMetric) {
                    Text(isMetric ? "Metric" : "Imperial")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                }
                .padding()
                
                // 身長入力
                HStack {
                    if isMetric {
                        Picker("Height (cm)", selection: $heightCm) {
                            ForEach(100..<250) { cm in
                                Text("\(cm) cm")
                            }
                        }
                    } else {
                        Picker("Height (feet)", selection: $heightFeet) {
                            ForEach(2..<9) { feet in
                                Text("\(feet) ft")
                            }
                        }
                        Picker("Height (inches)", selection: $heightInches) {
                            ForEach(0..<12) { inches in
                                Text("\(inches) in")
                            }
                        }
                    }
                }
                
                // 体重入力
                HStack {
                    if isMetric {
                        TextField("Weight (kg)", value: $weightKg, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                    } else {
                        TextField("Weight (lbs)", value: $weightLbs, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
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
    HeightWeightInputScreen(
        isMetric: .constant(true),
        heightFeet: .constant(5),
        heightInches: .constant(10),
        heightCm: .constant(178),
        weightLbs: .constant(160),
        weightKg: .constant(72.5),
        onContinue: {}
    )
}
