//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Marc-Antoine BAR on 2023-02-07.
//

import XCTest
@testable import Reciplease
@testable import Alamofire

final class RecipleaseTests: XCTestCase {

    // MARK: - Properties
    var model: RecipiesService!
    var expectation: XCTestExpectation!
    // MARK: - Setups
    override func setUp() {
        super.setUp()
        let manager: Session = {
            let configuration: URLSessionConfiguration = {
                let configuration = URLSessionConfiguration.default
                configuration.protocolClasses = [URLProtocolMock.self]
                return configuration
            }()
            return Session(configuration: configuration)
        }()
        model = RecipiesService(session: manager)
        expectation = expectation(description: "Expectation")
    }
    override func tearDown() {
        super.tearDown()
        model = nil
    }
    // MARK: - Tests
    func testGivenCorrectDataWhenRequestThenExpectSuccess() {
        URLProtocolMock.requestHandler = { _ in
            return (FakeData.ResponseOk, FakeData.RecipeDataCorrect, nil)
        }
        model.getRecipes(url: url) { result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success)
            case .failure:
                XCTFail("sucess expcted")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }

    func testGivenIncorrectDataWhenRequestThenExpectError() {
        URLProtocolMock.requestHandler = { _ in
            return (FakeData.ResponseOk, FakeData.RecipeDataIncorrect, nil)
        }
        model.getRecipes(url: url) { result in
            switch result {
            case .success:
                XCTFail("Error expcted")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    func testGivenHttpErrorWhenRequestThenExpectError() {
        URLProtocolMock.requestHandler = { _ in
            return (FakeData.ResponseKO, FakeData.RecipeDataCorrect, FakeData.error)
        }
        model.getRecipes(url: url) { result in
            switch result {
            case .success:
                XCTFail("Error expcted")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    func testGivenErrorNilWhenRequestThenExpectError() {
        URLProtocolMock.requestHandler = { _ in
            return (FakeData.ResponseOk, nil, FakeData.error)
        }
        model.getRecipes(url: url) { result in
            switch result {
            case .success:
                XCTFail("Error expcted")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    func testwhenGiveIngredientsThenShoudReturnStringUrlWithIngredients() {
        let ingredient = "lemon,basil"
        // swiftlint: disable line_length
        let expectedResult = "https://api.edamam.com/api/recipes/v2?type=public&app_id=\(ApiKeys.applicationId)&app_key=\(ApiKeys.applicationKeys)&field=label&field=image&field=url&field=yield&field=ingredientLines&field=totalTime&q=lemon,basil"
        let result = model.prepareURL(with: ingredient, from: "")
        XCTAssertEqual(expectedResult, result)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    func testwhenGiveIngredientsandCountThenShoudReturnStringUrlWithIngredientsAndCount() {
        let ingredient = "lemon,basil"
        let cont = "2"
        let expectedResult = "https://api.edamam.com/api/recipes/v2?type=public&app_id=\(ApiKeys.applicationId)&app_key=\(ApiKeys.applicationKeys)&field=label&field=image&field=url&field=yield&field=ingredientLines&field=totalTime&q=lemon,basil&_cont=2"
        let result = model.prepareURL(with: ingredient, from: cont)
        XCTAssertEqual(expectedResult, result)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    func testwhenGivenothingThenShoudReturnStringUrl() {
        let ingredient = ""
        let cont = ""
        let expectedResult = "https://api.edamam.com/api/recipes/v2?type=public&app_id=\(ApiKeys.applicationId)&app_key=\(ApiKeys.applicationKeys)&field=label&field=image&field=url&field=yield&field=ingredientLines&field=totalTime&q="
        let result = model.prepareURL(with: ingredient, from: cont)
        XCTAssertEqual(expectedResult, result)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }

}
