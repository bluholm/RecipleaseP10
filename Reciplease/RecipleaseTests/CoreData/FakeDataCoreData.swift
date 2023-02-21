//
//  FakeDataCoreData.swift
//  RecipleaseTests
//
//  Created by Marc-Antoine BAR on 2023-02-20.
//

import Foundation
@testable import Reciplease

class FakeDataCoreData {
    static let recipie = Recipie(title: "Test Title",
                                 ingredients: ["salade", "tomate"],
                                 time: 2,
                                 fileName: "test.jpg",
                                 imageurl: "https://example.com/test.jpg",
                                 yield: 30,
                                 url: "https://example.com")
    static let recipie2 = Recipie(title: "Test Title 2 ",
                                 ingredients: ["garlic", "lemon"],
                                 time: 2,
                                 fileName: "test2.jpg",
                                 imageurl: "https://example2.com/test2.jpg",
                                 yield: 30,
                                 url: "https://example2.com")
}
