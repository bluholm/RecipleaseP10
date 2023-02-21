//
//  RecipiesService.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-05.
//

import Foundation
import Alamofire

final class RecipiesService {
    
    // MARK: - Properties
    
    private var session: Session
    static let shared = RecipiesService()
    
    // MARK: - initializer
    
    init(session: Session = Session.default) {
        self.session = session
    }
    
    // MARK: - Nework Logic
    
    func prepareURL(with ingredients: String, from cont: String) -> String? {
            var urlComponent = URLComponents()
            urlComponent.scheme = "https"
            urlComponent.host = "api.edamam.com"
            urlComponent.path = "/api/recipes/v2"
            urlComponent.queryItems = [
                URLQueryItem(name: "type", value: "public"),
                URLQueryItem(name: "app_id", value: ApiKeys.applicationId),
                URLQueryItem(name: "app_key", value: ApiKeys.applicationKeys),
                URLQueryItem(name: "field", value: "label"),
                URLQueryItem(name: "field", value: "image"),
                URLQueryItem(name: "field", value: "url"),
                URLQueryItem(name: "field", value: "yield"),
                URLQueryItem(name: "field", value: "ingredientLines"),
                URLQueryItem(name: "field", value: "totalTime"),
                URLQueryItem(name: "q", value: ingredients)
            ]
        if !cont.isEmpty {
            urlComponent.queryItems?.append(URLQueryItem(name: "_cont", value: cont))
        }
            return urlComponent.url?.absoluteString
    }
    
    func getRecipes(url: String, completionHandler: @escaping (Result<Recipies, AFError>) -> Void) {
        
        session.request(url).responseDecodable(of: Recipies.self) { response in
            switch response.result {
            case .success(let edaman):
                completionHandler(.success(edaman))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
   
}
