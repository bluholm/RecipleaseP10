//
//  FakeData.swift
//  RecipleaseTests
//
//  Created by Marc-Antoine BAR on 2023-02-07.
//

import Foundation
import LoremSwiftum

let url = Lorem.url

class FakeData {
    static var ResponseOk = HTTPURLResponse(url: URL(string: url)!,
                                            statusCode: 200,
                                            httpVersion: nil,
                                            headerFields: nil)
    static var ResponseKO = HTTPURLResponse(url: URL(string: url)!,
                                            statusCode: 500,
                                            httpVersion: nil,
                                            headerFields: nil)
    static var RecipeDataIncorrect: Data? = Lorem.word.data(using: .utf8)
    class FakeError: Error {}
    static let error = FakeError()
    static var RecipeDataCorrect: Data? {
        let bundle = Bundle(for: FakeData.self)
        let url = bundle.url(forResource: "recipies", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
}
