//
//  DietaryRestrictionSelectionView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI

struct DietaryRestrictionSelectionView: View {
    @Binding var selectedDiet: String
    let onContinue: () -> Void
    
    let diets = ["Classic", "Pescatarian", "Vegetarian", "Vegan"]
    
    let icons = [
        "Classic": "🍗",
        "Pescatarian": "🐟",
        "Vegetarian": "🥗",
        "Vegan": "🌱"
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
                Text("Do you follow a specific diet?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                
                Spacer()
                    .frame(height: 40)
                
                // 食事制限選択
                ForEach(diets, id: \.self) { diet in
                    Button(action: {
                        selectedDiet = diet
                    }) {
                        HStack {
                            Text(icons[diet] ?? "")
                                .font(.title2)
                                .padding(.trailing, 8)
                            
                            Text(diet)
                                .font(.title3)
                                .fontWeight(.medium)
                            
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedDiet == diet ? Color.black : Color(.systemGray6))
                        )
                        .foregroundColor(selectedDiet == diet ? .white : .primary)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel("\(diet)食を選択")
                    .accessibilityHint("タップして\(diet)食を選択します")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityValue(selectedDiet == diet ? "選択中" : "")
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
                .disabled(selectedDiet.isEmpty)
                .opacity(selectedDiet.isEmpty ? 0.6 : 1)
                .accessibilityLabel("続行")
                .accessibilityHint("次の画面に進みます")
                .accessibilityAddTraits(.isButton)
                .accessibilityValue(selectedDiet.isEmpty ? "食事制限が選択されていません" : "食事制限が選択されています")
            }
            .padding()
        }
    }
}

#Preview {
    DietaryRestrictionSelectionView(selectedDiet: .constant("Classic"), onContinue: {})
}
