//
//  CalorieAIUITests.swift
//  CalorieAIUITests
//
//  Created by wataru takamine on 2025/03/12.
//

import XCTest

final class CalorieAIUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it's important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testOnboardingFlow() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // 1. 言語選択画面のテスト
        XCTAssertTrue(app.staticTexts["English"].exists)
        XCTAssertTrue(app.staticTexts["Español"].exists)
        XCTAssertTrue(app.staticTexts["中国人"].exists)
        XCTAssertTrue(app.staticTexts["Português"].exists)
        XCTAssertTrue(app.staticTexts["Français"].exists)
        XCTAssertTrue(app.staticTexts["Deutsch"].exists)
        XCTAssertTrue(app.staticTexts["Italiano"].exists)
        XCTAssertTrue(app.staticTexts["Română"].exists)
        
        app.staticTexts["English"].tap()
        
        // 2. 性別選択画面のテスト
        XCTAssertTrue(app.staticTexts["Choose your Gender"].exists)
        XCTAssertTrue(app.staticTexts["This will be used to calibrate your custom plan."].exists)
        XCTAssertTrue(app.staticTexts["Male"].exists)
        XCTAssertTrue(app.staticTexts["Female"].exists)
        XCTAssertTrue(app.staticTexts["Other"].exists)
        XCTAssertTrue(app.buttons["Continue"].exists)
        
        app.staticTexts["Male"].tap()
        app.buttons["Continue"].tap()
        
        // 3. ワークアウト頻度選択画面のテスト
        XCTAssertTrue(app.staticTexts["How many workouts do you do per week?"].exists)
        XCTAssertTrue(app.staticTexts["0-2"].exists)
        XCTAssertTrue(app.staticTexts["Workouts now and then"].exists)
        XCTAssertTrue(app.staticTexts["3-5"].exists)
        XCTAssertTrue(app.staticTexts["A few workouts per week"].exists)
        XCTAssertTrue(app.staticTexts["6+"].exists)
        XCTAssertTrue(app.staticTexts["Dedicated athlete"].exists)
        
        app.staticTexts["6+"].tap()
        app.buttons["Continue"].tap()
        
        // 4. 情報源選択画面のテスト
        XCTAssertTrue(app.staticTexts["Where did you hear about us?"].exists)
        XCTAssertTrue(app.staticTexts["Instagram"].exists)
        XCTAssertTrue(app.staticTexts["Facebook"].exists)
        XCTAssertTrue(app.staticTexts["TikTok"].exists)
        XCTAssertTrue(app.staticTexts["Youtube"].exists)
        XCTAssertTrue(app.staticTexts["Google"].exists)
        XCTAssertTrue(app.staticTexts["TV"].exists)
        
        app.staticTexts["Instagram"].tap()
        app.buttons["Continue"].tap()
        
        // 5. カロリートラッキングアプリ使用経験選択画面のテスト
        XCTAssertTrue(app.staticTexts["Have you tried other calorie tracking apps?"].exists)
        XCTAssertTrue(app.staticTexts["No"].exists)
        XCTAssertTrue(app.staticTexts["Yes"].exists)
        
        app.staticTexts["Yes"].tap()
        app.buttons["Continue"].tap()
        
        // 6. 体重遷移グラフ表示画面のテスト
        XCTAssertTrue(app.staticTexts["Cal AI creates long-term results"].exists)
        XCTAssertTrue(app.staticTexts["Your Weight"].exists)
        XCTAssertTrue(app.staticTexts["Traditional Diet"].exists)
        XCTAssertTrue(app.staticTexts["Cal AI"].exists)
        XCTAssertTrue(app.staticTexts["Month 1"].exists)
        XCTAssertTrue(app.staticTexts["Month 6"].exists)
        XCTAssertTrue(app.staticTexts["80% of Cal AI users maintain their weight loss even 6 months later"].exists)
        
        app.buttons["Continue"].tap()
        
        // 7. 身長・体重入力画面のテスト
        XCTAssertTrue(app.staticTexts["Height & weight"].exists)
        
        // インペリアル単位のテスト
        XCTAssertTrue(app.staticTexts["Imperial"].exists)
        XCTAssertTrue(app.staticTexts["Height"].exists)
        XCTAssertTrue(app.staticTexts["Weight"].exists)
        
        // メトリック単位に切り替え
        app.switches.firstMatch.tap()
        
        XCTAssertTrue(app.staticTexts["Metric"].exists)
        
        app.buttons["Continue"].tap()
        
        // 8. 生年月日入力画面のテスト
        XCTAssertTrue(app.staticTexts["When were you born?"].exists)
        
        app.buttons["Continue"].tap()
        
        // 9. 目標体重設定画面のテスト
        XCTAssertTrue(app.staticTexts["What is your desired weight?"].exists)
        XCTAssertTrue(app.staticTexts["Lose weight"].exists)
        
        app.buttons["Continue"].tap()
        
        // 10. 減量スピード選択画面のテスト
        XCTAssertTrue(app.staticTexts["Losing 4 kg is a realistic target. It's not hard at all!"].exists)
        XCTAssertTrue(app.staticTexts["90% of users say that the change is obvious after using Cal AI and it is not easy to rebound."].exists)
        
        app.buttons["Continue"].tap()
        
        // 11. 減量スピード選択画面のテスト
        XCTAssertTrue(app.staticTexts["How fast do you want to reach your goal?"].exists)
        XCTAssertTrue(app.staticTexts["Loss weight speed per week"].exists)
        XCTAssertTrue(app.staticTexts["Recommended"].exists)
        
        app.buttons["Continue"].tap()
        
        // 12. 目標達成障害要因選択画面のテスト
        XCTAssertTrue(app.staticTexts["What's stopping you from reaching your goals?"].exists)
        XCTAssertTrue(app.staticTexts["Lack of consistency"].exists)
        XCTAssertTrue(app.staticTexts["Unhealthy eating habits"].exists)
        XCTAssertTrue(app.staticTexts["Lack of support"].exists)
        XCTAssertTrue(app.staticTexts["Busy schedule"].exists)
        XCTAssertTrue(app.staticTexts["Lack of meal inspiration"].exists)
        
        app.staticTexts["Lack of consistency"].tap()
        app.buttons["Continue"].tap()
        
        // 13. 食事制限選択画面のテスト
        XCTAssertTrue(app.staticTexts["Do you follow a specific diet?"].exists)
        XCTAssertTrue(app.staticTexts["Classic"].exists)
        XCTAssertTrue(app.staticTexts["Pescatarian"].exists)
        XCTAssertTrue(app.staticTexts["Vegetarian"].exists)
        XCTAssertTrue(app.staticTexts["Vegan"].exists)
        
        app.staticTexts["Classic"].tap()
        app.buttons["Continue"].tap()
        
        // 14. 達成目標選択画面のテスト
        XCTAssertTrue(app.staticTexts["What would you like to accomplish?"].exists)
        XCTAssertTrue(app.staticTexts["Eat and live healthier"].exists)
        XCTAssertTrue(app.staticTexts["Boost my energy and mood"].exists)
        XCTAssertTrue(app.staticTexts["Stay motivated and consistent"].exists)
        XCTAssertTrue(app.staticTexts["Feel better about my body"].exists)
        
        app.staticTexts["Eat and live healthier"].tap()
        app.buttons["Continue"].tap()
        
        // 15. 評価画面のテスト
        XCTAssertTrue(app.staticTexts["You have great potential to crush your goal"].exists)
        XCTAssertTrue(app.staticTexts["Your weight transition"].exists)
        XCTAssertTrue(app.staticTexts["Based on Cal AI's historical data, weight loss is usually delayed at first, but after 7 days, you can burn fat like crazy!"].exists)
        
        app.buttons["Continue"].tap()
        
        // 16. 評価画面のテスト
        XCTAssertTrue(app.staticTexts["Give us a rating"].exists)
        XCTAssertTrue(app.staticTexts["Cal AI was made for people like you"].exists)
        XCTAssertTrue(app.staticTexts["+2M Cal AI users"].exists)
        
        // 最終的にホーム画面に遷移することを確認
        app.buttons["Continue"].tap()
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
