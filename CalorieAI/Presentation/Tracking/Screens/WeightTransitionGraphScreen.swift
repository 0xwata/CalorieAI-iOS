//
//  WeightTransitionGraphView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI

struct WeightTransitionGraphScreen: View {
    let onContinue: () -> Void
    
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
                                .frame(width: 250, height: 4)
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
                Text("Cal AI creates long-term results")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                
                Spacer()
                    .frame(height: 40)
                
                // グラフ表示
                VStack(alignment: .leading, spacing: 16) {
                    Text("Your Weight")
                        .font(.headline)
                        .padding(.leading)
                        .accessibilityLabel("体重の推移グラフ")
                    
                    ZStack {
                        // グラフの背景
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemGray6))
                            .frame(height: 250)
                        
                        // グラフの内容
                        VStack(alignment: .leading, spacing: 8) {
                            // グラフの線
                            ZStack {
                                // 従来のダイエットの線（赤）
                                Path { path in
                                    path.move(to: CGPoint(x: 20, y: 100))
                                    path.addCurve(
                                        to: CGPoint(x: 330, y: 50),
                                        control1: CGPoint(x: 120, y: 150),
                                        control2: CGPoint(x: 250, y: 20)
                                    )
                                }
                                .stroke(Color.red.opacity(0.7), lineWidth: 3)
                                .accessibilityHidden(true)
                                
                                // Cal AIの線（黒）
                                Path { path in
                                    path.move(to: CGPoint(x: 20, y: 100))
                                    path.addCurve(
                                        to: CGPoint(x: 330, y: 180),
                                        control1: CGPoint(x: 120, y: 80),
                                        control2: CGPoint(x: 250, y: 180)
                                    )
                                }
                                .stroke(Color.black, lineWidth: 3)
                                .accessibilityHidden(true)
                                
                                // 始点と終点のマーカー
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 16, height: 16)
                                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                                    .position(x: 20, y: 100)
                                    .accessibilityHidden(true)
                                
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 16, height: 16)
                                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                                    .position(x: 330, y: 180)
                                    .accessibilityHidden(true)
                            }
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("体重の推移グラフ。従来のダイエットでは一時的な減量後にリバウンドする傾向がありますが、Cal AIでは持続的な減量効果が得られます。")
                            
                            // 凡例
                            HStack {
                                HStack {
                                    Text("🍎")
                                    Text("Cal AI")
                                        .font(.caption)
                                    
                                    Text("Weight")
                                        .font(.caption)
                                        .padding(.horizontal, 4)
                                        .padding(.vertical, 2)
                                        .background(
                                            RoundedRectangle(cornerRadius: 4)
                                                .fill(Color.black)
                                        )
                                        .foregroundColor(.white)
                                }
                                .accessibilityElement(children: .combine)
                                .accessibilityLabel("Cal AIによる体重推移")
                                
                                Spacer()
                                
                                Text("Traditional Diet")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .accessibilityLabel("従来のダイエット方法による体重推移")
                            }
                            .padding(.horizontal)
                            
                            // 月表示
                            HStack {
                                Text("Month 1")
                                    .font(.caption)
                                    .accessibilityLabel("開始時点")
                                
                                Spacer()
                                
                                Text("Month 6")
                                    .font(.caption)
                                    .accessibilityLabel("6ヶ月後")
                            }
                            .padding(.horizontal)
                        }
                        .padding()
                    }
                    
                    Text("80% of Cal AI users maintain their weight loss even 6 months later")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding()
                        .accessibilityLabel("Cal AIユーザーの80%が6ヶ月後も減量を維持しています")
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
    WeightTransitionGraphScreen(onContinue: {})
}
