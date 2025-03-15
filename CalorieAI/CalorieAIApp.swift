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
    @State private var currentScreen: OnboardingScreen = .gender
    
    // ユーザー設定
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
                WelcomeScreen(
                    onComplete: {
                        withAnimation {
                            showWelcomeScreen = false
                        }
                    },
                    onGoToHome: {
                        withAnimation {
                            showWelcomeScreen = false
                            currentScreen = .home
                        }
                    }
                )
            } else {
                NavigationView {
                    Group {
                        switch currentScreen {
                        case .gender:
                            GenderSelectionScreen(selectedGender: $selectedGender) {
                                currentScreen = .workoutFrequency
                            }
                        case .workoutFrequency:
                            WorkoutFrequencySelectionScreen(selectedFrequency: $selectedFrequency) {
                                currentScreen = .source
                            }
                        case .source:
                            SourceSelectionScreen(selectedSource: $selectedSource) {
                                currentScreen = .calorieTrackingExperience
                            }
                        case .calorieTrackingExperience:
                            CalorieTrackingAppExperienceScreen(hasExperience: $hasExperience) {
                                currentScreen = .longTermResults
                            }
                        case .longTermResults:
                            OWeightTransitionGraphScreen {
                                currentScreen = .heightWeight
                            }
                        case .heightWeight:
                            HeightWeightInputScreen(
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
                            BirthdayInputScreen(
                                selectedMonth: $selectedMonth,
                                selectedDay: $selectedDay,
                                selectedYear: $selectedYear
                            ) {
                                currentScreen = .desiredWeight
                            }
                        case .desiredWeight:
                            DesiredWeightInputScreen(
                                currentWeight: $weightKg,
                                targetWeight: $targetWeight
                            ) {
                                currentScreen = .gainingWeight
                            }
                        case .gainingWeight:
                            GainingWeightScreen {
                                currentScreen = .weightLossSpeed
                            }
                        case .weightLossSpeed:
                            WeightLossSpeedSelectionScreen(weightLossPerWeek: $weightLossPerWeek) {
                                currentScreen = .twiceWeightLoss
                            }
                        case .twiceWeightLoss:
                            TwiceWeightLossScreen {
                                currentScreen = .goalObstacles
                            }
                        case .goalObstacles:
                            GoalObstaclesSelectionScreen(selectedObstacle: $selectedObstacle) {
                                currentScreen = .dietaryRestriction
                            }
                        case .dietaryRestriction:
                            DietaryRestrictionSelectionScreen(selectedDiet: $selectedDiet) {
                                currentScreen = .achievementGoal
                            }
                        case .achievementGoal:
                            AchievementGoalSelectionScreen(selectedGoal: $selectedGoal) {
                                currentScreen = .greatPotential
                            }
                        case .greatPotential:
                            GreatPotentialScreen {
                                currentScreen = .rating
                            }
                        case .rating:
                            RatingScreen(rating: $rating) {
                                currentScreen = .notification
                            }
                        case .notification:
                            NotificationScreen {
                                currentScreen = .referralCode
                            }
                        case .referralCode:
                            ReferralCodeScreen {
                                currentScreen = .thankYou
                            }
                        case .thankYou:
                            ThankYouScreen {
                                currentScreen = .settingUp
                            }
                        case .settingUp:
                            SettingUpScreen {
                                currentScreen = .customPlansReady
                            }
                        case .customPlansReady:
                            CustomPlansReadyScreen {
                                currentScreen = .home
                            }
                        case .home:
                            HomeScreen()
                        default:
                            EmptyScreen()
                        }
                    }
                    .navigationBarHidden(true)
                }
            }
        }
    }
}

// EmptyScreenの構造体を定義
struct EmptyScreen: View {
    var body: some View {
        Color.clear
    }
}

// オンボーディング画面の列挙型
enum OnboardingScreen {
    case language
    case gender
    case workoutFrequency
    case source
    case calorieTrackingExperience
    case longTermResults
    case heightWeight
    case birthday
    case desiredWeight
    case gainingWeight
    case weightLossSpeed
    case twiceWeightLoss
    case goalObstacles
    case dietaryRestriction
    case achievementGoal
    case greatPotential
    case rating
    case notification
    case referralCode
    case thankYou
    case settingUp
    case customPlansReady
    case home
}
