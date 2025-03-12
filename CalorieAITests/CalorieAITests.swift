//
//  CalorieAITests.swift
//  CalorieAITests
//
//  Created by wataru takamine on 2025/03/12.
//

import Testing
import SwiftUI
@testable import CalorieAI

struct CalorieAITests {

    @Test func testLanguageSelectionView() async throws {
        let view = LanguageSelectionView(selectedLanguage: .constant("en"), onContinue: {})
        #expect(view.languages.count == 8)
        #expect(view.languages.contains("English"))
        #expect(view.languages.contains("Español"))
        #expect(view.languages.contains("中国人"))
        #expect(view.languages.contains("Português"))
        #expect(view.languages.contains("Français"))
        #expect(view.languages.contains("Deutsch"))
        #expect(view.languages.contains("Italiano"))
        #expect(view.languages.contains("Română"))
    }
    
    @Test func testGenderSelectionView() async throws {
        let view = GenderSelectionView(selectedGender: .constant("male"), onContinue: {})
        #expect(view.genders.count == 3)
        #expect(view.genders.contains("Male"))
        #expect(view.genders.contains("Female"))
        #expect(view.genders.contains("Other"))
    }
    
    @Test func testWorkoutFrequencySelectionView() async throws {
        let view = WorkoutFrequencySelectionView(selectedFrequency: .constant("6+"), onContinue: {})
        #expect(view.frequencies.count == 3)
        #expect(view.frequencies["0-2"] == "Workouts now and then")
        #expect(view.frequencies["3-5"] == "A few workouts per week")
        #expect(view.frequencies["6+"] == "Dedicated athlete")
    }
    
    @Test func testSourceSelectionView() async throws {
        let view = SourceSelectionView(selectedSource: .constant("Instagram"), onContinue: {})
        #expect(view.sources.count == 6)
        #expect(view.sources.contains("Instagram"))
        #expect(view.sources.contains("Facebook"))
        #expect(view.sources.contains("TikTok"))
        #expect(view.sources.contains("Youtube"))
        #expect(view.sources.contains("Google"))
        #expect(view.sources.contains("TV"))
    }
    
    @Test func testCalorieTrackingAppExperienceView() async throws {
        let view = CalorieTrackingAppExperienceView(hasExperience: .constant(true), onContinue: {})
        #expect(view.options.count == 2)
        #expect(view.options.contains("Yes"))
        #expect(view.options.contains("No"))
    }
    
    @Test func testHeightWeightInputView() async throws {
        let view = HeightWeightInputView(
            isMetric: .constant(true),
            heightFeet: .constant(5),
            heightInches: .constant(10),
            heightCm: .constant(178),
            weightLbs: .constant(160),
            weightKg: .constant(72.5),
            onContinue: {}
        )
        #expect(view.heightFeetOptions.count > 0)
        #expect(view.heightInchesOptions.count > 0)
        #expect(view.heightCmOptions.count > 0)
        #expect(view.weightLbsOptions.count > 0)
        #expect(view.weightKgOptions.count > 0)
    }
    
    @Test func testBirthdayInputView() async throws {
        let view = BirthdayInputView(
            selectedMonth: .constant("April"),
            selectedDay: .constant("4"),
            selectedYear: .constant("1994"),
            onContinue: {}
        )
        #expect(view.months.count == 12)
        #expect(view.days.count == 31)
        #expect(view.years.count > 0)
    }
    
    @Test func testDesiredWeightInputView() async throws {
        let view = DesiredWeightInputView(
            currentWeight: 75.0,
            targetWeight: .constant(72.0),
            onContinue: {}
        )
        #expect(view.minWeight < view.maxWeight)
    }
    
    @Test func testWeightLossSpeedSelectionView() async throws {
        let view = WeightLossSpeedSelectionView(
            weightLossPerWeek: .constant(1.0),
            onContinue: {}
        )
        #expect(view.minWeightLoss < view.maxWeightLoss)
    }
    
    @Test func testGoalObstaclesSelectionView() async throws {
        let view = GoalObstaclesSelectionView(
            selectedObstacle: .constant("Lack of consistency"),
            onContinue: {}
        )
        #expect(view.obstacles.count == 5)
        #expect(view.obstacles.contains("Lack of consistency"))
        #expect(view.obstacles.contains("Unhealthy eating habits"))
        #expect(view.obstacles.contains("Lack of support"))
        #expect(view.obstacles.contains("Busy schedule"))
        #expect(view.obstacles.contains("Lack of meal inspiration"))
    }
    
    @Test func testDietaryRestrictionSelectionView() async throws {
        let view = DietaryRestrictionSelectionView(
            selectedDiet: .constant("Classic"),
            onContinue: {}
        )
        #expect(view.diets.count == 4)
        #expect(view.diets.contains("Classic"))
        #expect(view.diets.contains("Pescatarian"))
        #expect(view.diets.contains("Vegetarian"))
        #expect(view.diets.contains("Vegan"))
    }
    
    @Test func testAchievementGoalSelectionView() async throws {
        let view = AchievementGoalSelectionView(
            selectedGoal: .constant("Eat and live healthier"),
            onContinue: {}
        )
        #expect(view.goals.count == 4)
        #expect(view.goals.contains("Eat and live healthier"))
        #expect(view.goals.contains("Boost my energy and mood"))
        #expect(view.goals.contains("Stay motivated and consistent"))
        #expect(view.goals.contains("Feel better about my body"))
    }
    
    @Test func testRatingView() async throws {
        let view = RatingView(rating: .constant(5), onContinue: {})
        #expect(view.maxRating == 5)
    }
}
