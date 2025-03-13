//
//  HeightWeightInputView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI

struct HeightWeightInputView: View {
    @Binding var isMetric: Bool
    @Binding var heightFeet: Int
    @Binding var heightInches: Int
    @Binding var heightCm: Int
    @Binding var weightLbs: Int
    @Binding var weightKg: Double
    let onContinue: () -> Void
    
    // インペリアル単位のオプション
    let heightFeetOptions = Array(2...8)
    let heightInchesOptions = Array(0...11)
    let weightLbsOptions = Array(stride(from: 80, through: 300, by: 1))
    
    // メトリック単位のオプション
    let heightCmOptions = Array(stride(from: 140, through: 220, by: 1))
    let weightKgOptions = Array(stride(from: 40.0, through: 150.0, by: 0.5))
    
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
                
                // 単位切り替えスイッチ
                HStack {
                    Text("Imperial")
                        .foregroundColor(isMetric ? .gray : .primary)
                        .fontWeight(isMetric ? .regular : .bold)
                    
                    Toggle("単位の切り替え", isOn: $isMetric)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: .black))
                        .accessibilityLabel("単位の切り替え")
                        .accessibilityHint(isMetric ? "メートル法からヤード・ポンド法に切り替える" : "ヤード・ポンド法からメートル法に切り替える")
                        .accessibilityValue(isMetric ? "メートル法" : "ヤード・ポンド法")
                    
                    Text("Metric")
                        .foregroundColor(isMetric ? .primary : .gray)
                        .fontWeight(isMetric ? .bold : .regular)
                }
                .padding(.vertical)
                .accessibilityElement(children: .combine)
                
                // 身長と体重の入力
                HStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Height")
                            .font(.headline)
                        
                        if isMetric {
                            // メトリック単位の身長入力
                            Picker("Height (cm)", selection: $heightCm) {
                                ForEach(heightCmOptions, id: \.self) { cm in
                                    Text("\(cm) cm").tag(cm)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(height: 150)
                            .clipped()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemGray6))
                            )
                            .accessibilityLabel("身長")
                            .accessibilityValue("\(heightCm)センチメートル")
                            .accessibilityHint("上下にスワイプして身長を選択してください")
                        } else {
                            // インペリアル単位の身長入力
                            HStack {
                                Picker("Feet", selection: $heightFeet) {
                                    ForEach(heightFeetOptions, id: \.self) { feet in
                                        Text("\(feet) ft").tag(feet)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(width: 80, height: 150)
                                .clipped()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(.systemGray6))
                                )
                                
                                Picker("Inches", selection: $heightInches) {
                                    ForEach(heightInchesOptions, id: \.self) { inches in
                                        Text("\(inches) in").tag(inches)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(width: 80, height: 150)
                                .clipped()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(.systemGray6))
                                )
                            }
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Weight")
                            .font(.headline)
                        
                        if isMetric {
                            // メトリック単位の体重入力
                            Picker("Weight (kg)", selection: $weightKg) {
                                ForEach(weightKgOptions, id: \.self) { kg in
                                    Text("\(Int(kg)) kg").tag(kg)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(height: 150)
                            .clipped()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemGray6))
                            )
                            .accessibilityLabel("体重")
                            .accessibilityValue("\(Int(weightKg))キログラム")
                            .accessibilityHint("上下にスワイプして体重を選択してください")
                        } else {
                            // インペリアル単位の体重入力
                            Picker("Weight (lbs)", selection: $weightLbs) {
                                ForEach(weightLbsOptions, id: \.self) { lbs in
                                    Text("\(lbs) lb").tag(lbs)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(height: 150)
                            .clipped()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemGray6))
                            )
                        }
                    }
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
    HeightWeightInputView(
        isMetric: .constant(true),
        heightFeet: .constant(5),
        heightInches: .constant(10),
        heightCm: .constant(178),
        weightLbs: .constant(160),
        weightKg: .constant(72.5),
        onContinue: {}
    )
}
