//
//  CalorieAIApp.swift
//  CalorieAI
//
//  Created by wataru takamine on 2025/03/12.
//

import SwiftUI

@main
struct CalorieAIApp: App {
    @State private var showSimpleSplashScreen = true
    @State private var showWelcomeScreen = false
    @State private var currentScreen: OnboardingScreen = .language
    
    // ユーザー設定
    @State private var selectedLanguage: String = "English"
    @State private var selectedGender: String = ""
    @State private var selectedFrequency: String = ""
    @State private var selectedSource: String = ""
    @State private var hasExperience: Bool = false
    @State private var isMetric: Bool = false
    @State private var heightFeet: Int = 5
    @State private var heightInches: Int = 10
    @State private var heightCm: Int = 178
    @State private var weightLbs: Int = 160
    @State private var weightKg: Double = 72.5
    @State private var selectedMonth: String = "April"
    @State private var selectedDay: String = "4"
    @State private var selectedYear: String = "1994"
    @State private var targetWeight: Double = 68.0
    @State private var weightLossPerWeek: Double = 1.0
    @State private var selectedObstacle: String = ""
    @State private var selectedDiet: String = ""
    @State private var selectedGoal: String = ""
    @State private var rating: Int = 5
    
    var body: some Scene {
        WindowGroup {
            if showSimpleSplashScreen {
                SplashScreen(onComplete: {
                    withAnimation {
                        showSimpleSplashScreen = false
                        showWelcomeScreen = true
                    }
                })
            } else if showWelcomeScreen {
                WelcomeScreen(onComplete: {
                    withAnimation {
                        showWelcomeScreen = false
                    }
                })
            } else {
                NavigationView {
                    Group {
                        switch currentScreen {
                        case .language:
                            LanguageSelectionView(selectedLanguage: $selectedLanguage) {
                                currentScreen = .gender
                            }
                        case .gender:
                            GenderSelectionView(selectedGender: $selectedGender) {
                                currentScreen = .workoutFrequency
                            }
                        case .workoutFrequency:
                            WorkoutFrequencySelectionView(selectedFrequency: $selectedFrequency) {
                                currentScreen = .source
                            }
                        case .source:
                            SourceSelectionView(selectedSource: $selectedSource) {
                                currentScreen = .calorieTrackingExperience
                            }
                        case .calorieTrackingExperience:
                            CalorieTrackingAppExperienceView(hasExperience: $hasExperience) {
                                currentScreen = .weightTransition
                            }
                        case .weightTransition:
                            WeightTransitionGraphView {
                                currentScreen = .heightWeight
                            }
                        case .heightWeight:
                            HeightWeightInputView(
                                isMetric: $isMetric,
                                heightFeet: $heightFeet,
                                heightInches: $heightInches,
                                heightCm: $heightCm,
                                weightLbs: $weightLbs,
                                weightKg: $weightKg
                            ) {
                                currentScreen = .birthday
                            }
                        case .birthday:
                            BirthdayInputView(
                                selectedMonth: $selectedMonth,
                                selectedDay: $selectedDay,
                                selectedYear: $selectedYear
                            ) {
                                currentScreen = .desiredWeight
                            }
                        case .desiredWeight:
                            DesiredWeightInputView(
                                currentWeight: weightKg,
                                targetWeight: $targetWeight
                            ) {
                                currentScreen = .weightLossSpeed
                            }
                        case .weightLossSpeed:
                            WeightLossSpeedSelectionView(weightLossPerWeek: $weightLossPerWeek) {
                                currentScreen = .goalObstacles
                            }
                        case .goalObstacles:
                            GoalObstaclesSelectionView(selectedObstacle: $selectedObstacle) {
                                currentScreen = .dietaryRestriction
                            }
                        case .dietaryRestriction:
                            DietaryRestrictionSelectionView(selectedDiet: $selectedDiet) {
                                currentScreen = .achievementGoal
                            }
                        case .achievementGoal:
                            AchievementGoalSelectionView(selectedGoal: $selectedGoal) {
                                currentScreen = .rating
                            }
                        case .rating:
                            RatingView(rating: $rating) {
                                currentScreen = .home
                            }
                        case .home:
                            HomeView()
                        }
                    }
                    .navigationBarHidden(true)
                }
            }
        }
    }
}

// オンボーディング画面の列挙型
enum OnboardingScreen {
    case language
    case gender
    case workoutFrequency
    case source
    case calorieTrackingExperience
    case weightTransition
    case heightWeight
    case birthday
    case desiredWeight
    case weightLossSpeed
    case goalObstacles
    case dietaryRestriction
    case achievementGoal
    case rating
    case home
}
