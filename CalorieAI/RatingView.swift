//
//  RatingView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    let onContinue: () -> Void
    
    let maxRating = 5
    
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
                                .frame(width: 550, height: 4)
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
                Text("Give us a rating")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                
                // 星評価
                HStack(spacing: 10) {
                    ForEach(1...maxRating, id: \.self) { star in
                        Button(action: {
                            rating = star
                        }) {
                            Image(systemName: star <= rating ? "star.fill" : "star")
                                .font(.system(size: 40))
                                .foregroundColor(.yellow)
                        }
                        .accessibilityLabel("\(star)星")
                        .accessibilityHint("タップして\(star)星を選択します")
                        .accessibilityAddTraits(.isButton)
                        .accessibilityValue(star <= rating ? "選択中" : "")
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemGray6))
                )
                .accessibilityElement(children: .combine)
                .accessibilityLabel("星評価")
                .accessibilityValue("\(rating)星")
                .accessibilityHint("1から5までの星をタップして評価してください")
                
                // ユーザー情報
                VStack(alignment: .center, spacing: 16) {
                    Text("Cal AI was made for people like you")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .accessibilityAddTraits(.isHeader)
                    
                    // ユーザーアイコン
                    HStack(spacing: -15) {
                        ForEach(0..<3) { index in
                            Image(systemName: "person.fill")
                                .font(.system(size: 30))
                                .padding()
                                .background(Circle().fill(index == 1 ? Color.yellow.opacity(0.5) : Color.gray.opacity(Double(0.3 + Double(index) * 0.2))))
                                .clipShape(Circle())
                        }
                    }
                    .accessibilityHidden(true)
                    
                    Text("+2M Cal AI users")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .accessibilityLabel("200万人以上のユーザーが利用しています")
                }
                .padding()
                
                // レビュー例
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                            .accessibilityHidden(true)
                        
                        Text("Marley Bryle")
                            .font(.headline)
                        
                        Spacer()
                        
                        // 星5つ
                        HStack(spacing: 2) {
                            ForEach(0..<5) { _ in
                                Image(systemName: "star.fill")
                                    .font(.caption)
                                    .foregroundColor(.yellow)
                            }
                        }
                        .accessibilityLabel("5つ星の評価")
                    }
                    
                    Text("\"I lost 15 lbs in 2 months! I was about to go on Ozempic but decided to give this app a shot and it worked :)\"")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(16)
                .accessibilityElement(children: .combine)
                .accessibilityLabel("ユーザーレビュー: Marley Bryle")
                .accessibilityValue("2ヶ月で7キロ減量に成功。オゼンピックを使用する予定でしたが、このアプリを試してみたところ効果がありました。")
                
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
    RatingView(rating: .constant(5), onContinue: {})
}
