//
//  HomeView.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI
import Charts

struct HomeView: View {
    @State private var selectedTab = 0
    @State private var showingAddMeal = false
    
    // サンプルデータ
    let weeklyCalories = [
        (day: "月", calories: 2100),
        (day: "火", calories: 1950),
        (day: "水", calories: 2050),
        (day: "木", calories: 1900),
        (day: "金", calories: 2200),
        (day: "土", calories: 2300),
        (day: "日", calories: 2000)
    ]
    
    let meals = [
        Meal(name: "朝食", time: "7:30", calories: 450, protein: 20, carbs: 60, fat: 15),
        Meal(name: "昼食", time: "12:30", calories: 650, protein: 30, carbs: 80, fat: 20),
        Meal(name: "夕食", time: "19:00", calories: 750, protein: 35, carbs: 90, fat: 25)
    ]
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // ホームタブ
            NavigationView {
                ScrollView {
                    VStack(spacing: 20) {
                        // ヘッダー
                        HStack {
                            VStack(alignment: .leading) {
                                Text("今日の摂取カロリー")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .accessibilityAddTraits(.isHeader)
                                
                                Text("1,850 / 2,000 kcal")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .accessibilityLabel("摂取カロリー")
                                    .accessibilityValue("目標2,000キロカロリーのうち1,850キロカロリーを摂取済み")
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                showingAddMeal = true
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 44))
                                    .foregroundColor(.black)
                            }
                            .accessibilityLabel("食事を追加")
                            .accessibilityHint("タップして新しい食事を記録します")
                        }
                        .padding()
                        
                        // 栄養素バー
                        HStack(spacing: 20) {
                            NutrientBar(name: "タンパク質", current: 85, target: 120, color: .blue)
                            NutrientBar(name: "炭水化物", current: 230, target: 250, color: .green)
                            NutrientBar(name: "脂質", current: 60, target: 65, color: .orange)
                        }
                        .padding()
                        
                        // 週間グラフ
                        VStack(alignment: .leading) {
                            Text("週間カロリー")
                                .font(.headline)
                                .padding(.horizontal)
                                .accessibilityAddTraits(.isHeader)
                            
                            Chart {
                                ForEach(weeklyCalories, id: \.day) { data in
                                    BarMark(
                                        x: .value("Day", data.day),
                                        y: .value("Calories", data.calories)
                                    )
                                    .foregroundStyle(Color.black.gradient)
                                }
                            }
                            .frame(height: 200)
                            .padding()
                        }
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                        .padding()
                        
                        // 食事リスト
                        VStack(alignment: .leading, spacing: 16) {
                            Text("今日の食事")
                                .font(.headline)
                                .padding(.horizontal)
                                .accessibilityAddTraits(.isHeader)
                            
                            ForEach(meals) { meal in
                                MealCard(meal: meal)
                            }
                        }
                        .padding()
                    }
                }
                .navigationTitle("ホーム")
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("ホーム")
            }
            .tag(0)
            
            // 食事記録タブ
            NavigationView {
                Text("食事記録")
                    .navigationTitle("食事記録")
                    .accessibilityAddTraits(.isHeader)
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("記録")
            }
            .tag(1)
            
            // 統計タブ
            NavigationView {
                Text("統計")
                    .navigationTitle("統計")
                    .accessibilityAddTraits(.isHeader)
            }
            .tabItem {
                Image(systemName: "chart.bar.fill")
                Text("統計")
            }
            .tag(2)
            
            // プロフィールタブ
            NavigationView {
                Text("プロフィール")
                    .navigationTitle("プロフィール")
                    .accessibilityAddTraits(.isHeader)
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("プロフィール")
            }
            .tag(3)
        }
        .sheet(isPresented: $showingAddMeal) {
            AddMealView()
        }
    }
}

// 栄養素バーコンポーネント
struct NutrientBar: View {
    let name: String
    let current: Int
    let target: Int
    let color: Color
    
    var progress: CGFloat {
        CGFloat(current) / CGFloat(target)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text("\(current)g")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(.systemGray5))
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(color)
                        .frame(width: geometry.size.width * progress, height: 8)
                }
            }
            .frame(height: 8)
            
            Text("目標: \(target)g")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(name)の摂取量")
        .accessibilityValue("目標\(target)グラムのうち\(current)グラムを摂取済み")
    }
}

// 食事カードコンポーネント
struct MealCard: View {
    let meal: Meal
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading) {
                    Text(meal.name)
                        .font(.headline)
                    
                    Text(meal.time)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text("\(meal.calories) kcal")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            
            HStack {
                NutrientLabel(name: "タンパク質", amount: meal.protein)
                NutrientLabel(name: "炭水化物", amount: meal.carbs)
                NutrientLabel(name: "脂質", amount: meal.fat)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(meal.name) - \(meal.time)")
        .accessibilityValue("\(meal.calories)キロカロリー、タンパク質\(meal.protein)グラム、炭水化物\(meal.carbs)グラム、脂質\(meal.fat)グラム")
    }
}

// 栄養素ラベルコンポーネント
struct NutrientLabel: View {
    let name: String
    let amount: Int
    
    var body: some View {
        VStack {
            Text("\(amount)g")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            Text(name)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(name)の量")
        .accessibilityValue("\(amount)グラム")
    }
}

// 食事追加シート
struct AddMealView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
                Text("食事を追加")
                    .navigationTitle("食事を追加")
                    .accessibilityAddTraits(.isHeader)
                .navigationBarItems(
                    leading: Button("キャンセル") {
                        dismiss()
                    },
                    trailing: Button("保存") {
                        dismiss()
                    }
                )
        }
    }
}

// 食事モデル
struct Meal: Identifiable {
    let id = UUID()
    let name: String
    let time: String
    let calories: Int
    let protein: Int
    let carbs: Int
    let fat: Int
}

#Preview {
    HomeView()
}
