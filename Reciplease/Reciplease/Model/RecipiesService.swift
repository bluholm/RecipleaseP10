//
//  RecipiesService.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-05.
//

import Foundation


final class RecipiesService {
    
    //MARK: - Properties
    
    var ingredients = ""
    private let urlSession = URLSession(configuration: .default)
    private var url: String? {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.edamam.com"
        urlComponent.path = "/api/recipes/v2"
        urlComponent.queryItems = [
            URLQueryItem(name: "type", value: "public"),
            URLQueryItem(name: "app_id", value: "884ebb7d"),
            URLQueryItem(name: "app_key", value: "07a7d574b7926165e46876679070d5de"),
            URLQueryItem(name: "field", value: "label"),
            URLQueryItem(name: "field", value: "image"),
            URLQueryItem(name: "field", value: "yield"),
            URLQueryItem(name: "field", value: "ingredientLines"),
            URLQueryItem(name: "field", value: "ingredients"),
            URLQueryItem(name: "field", value: "totalTime"),
            URLQueryItem(name: "q", value: ingredients)
            ]
        return urlComponent.url?.absoluteString
    }
    
    //MARK: - API call
    
    func getRecipies(callback: @escaping (Result<Recipies, NetworkError>) -> Void) {
        guard let url = URL(string: url!) else { return }
        let request = URLRequest(url: url)
        let task = urlSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(.failure(.errorNil))
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(.statusCode))
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Recipies.self, from: data) else {
                    callback(.failure(.decoderJSON))
                    return
                }
                callback(.success(responseJSON))
            }
        }
        task.resume()
    }
}
