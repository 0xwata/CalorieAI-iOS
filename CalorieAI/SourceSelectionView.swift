//
//  SourceSelectionView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI

struct SourceSelectionView: View {
    @Binding var selectedSource: String
    let onContinue: () -> Void
    
    let sources = ["Instagram", "Facebook", "TikTok", "Youtube", "Google", "TV"]
    
    let icons = [
        "Instagram": "📷",
        "Facebook": "👍",
        "TikTok": "🎵",
        "Youtube": "▶️",
        "Google": "🔍",
        "TV": "📺"
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
                                .frame(width: 150, height: 4)
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
                Text("Where did you hear about us?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                
                Spacer()
                    .frame(height: 20)
                
                // 情報源選択ボタン
                ForEach(sources, id: \.self) { source in
                    Button(action: {
                        selectedSource = source
                    }) {
                        HStack {
                            Text(icons[source] ?? "")
                                .font(.title2)
                                .padding(.trailing, 8)
                            
                            Text(source)
                                .font(.title3)
                                .fontWeight(.medium)
                            
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedSource == source ? Color.black : Color(.systemGray6))
                        )
                        .foregroundColor(selectedSource == source ? .white : .primary)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel("\(source)で知りました")
                    .accessibilityHint("タップして\(source)を選択します")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityValue(selectedSource == source ? "選択中" : "")
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
                .disabled(selectedSource.isEmpty)
                .opacity(selectedSource.isEmpty ? 0.6 : 1)
                .accessibilityLabel("続行")
                .accessibilityHint("次の画面に進みます")
                .accessibilityAddTraits(.isButton)
                .accessibilityValue(selectedSource.isEmpty ? "情報源が選択されていません" : "情報源が選択されています")
            }
            .padding()
        }
    }
}

#Preview {
    SourceSelectionView(selectedSource: .constant("Instagram"), onContinue: {})
}
