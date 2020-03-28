//
//  NetworkService.swift
//  cocktail-categoies-app
//
//  Created by Serhiy Prikhodko on 3/25/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import Foundation
import UIKit

class NetworkService {
    
    static func fetchCategories(completion: @escaping (CategoriesList?, Error?)-> Void) {
        let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let articles = try jsonDecoder.decode(CategoriesList.self, from: data)
                    completion(articles, nil)
                    
                } catch let error as NSError {
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    static func fetchDrinksByCategory(category: Category, completion: @escaping (CocktailList?, Error?)-> Void) {
        let category = category.strCategory ?? ""
        let baseURL = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php")!
        let query: [String: String] = [
            "c": category
        ]
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let articles = try jsonDecoder.decode(CocktailList.self, from: data)
                    completion(articles, nil)
                    
                } catch let error as NSError {
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    static func fetchNewsImage(cocktail: Cocktail, completionHandler: @escaping (_ data: Data?) -> () ) {
        if let url = URL(string: cocktail.strDrinkThumb ?? "") {
            if UIApplication.shared.canOpenURL(url) { // check that image URL can be opened
                let session = URLSession.shared
                let dataTask = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        completionHandler(nil)
                    } else {
                        completionHandler(data)
                    }
                }
                dataTask.resume()
            }
        }
    }
}
extension URL {
    //Creates ULR, adding params queries to him
    func withQueries(_ queries: [String: String])-> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
