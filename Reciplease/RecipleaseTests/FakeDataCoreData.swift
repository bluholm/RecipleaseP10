//
//  FakeDataCoreData.swift
//  RecipleaseTests
//
//  Created by Marc-Antoine BAR on 2023-02-20.
//

import Foundation
@testable import Reciplease

class FakeDataCoreData {
    static let recipie = Recipie(title: "Test",
                                 ingredients: ["salade", "tomate"],
                                 time: 2,
                                 fileName: "test.jpg",
                                 imageurl: "https://example.com/test.jpg",
                                 yield: 30,
                                 url: "https://example.com")
    static let recipeKO = Recipie(title: "",
                                  ingredients: [],
                                  time: -1,
                                  fileName: "",
                                  imageurl: "",
                                  yield: -1,
                                  url: "")
}
