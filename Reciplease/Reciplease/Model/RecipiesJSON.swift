//
//  Recipies.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-05.
//

import Foundation

// MARK: - Recipies

struct Recipies: Codable {
    let hits: [Hit]
}

// MARK: - Hit

struct Hit: Codable {
    let recipe: Recipe
}

// MARK: - Recipe

struct Recipe: Codable {
    let label: String
    let image: String
    let yield: Int
    let ingredientLines: [String]
    let totalTime: Int
    let url: URL
}

