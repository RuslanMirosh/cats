//
//  CarRequest.swift
//  Cats
//
//  Created by Руслан on 26.10.2019.
//  Copyright © 2019 Руслан. All rights reserved.
//

import Foundation
import UIKit

class CatRequest {
        
    func getCats(limit:Int = 50, completion: @escaping ([Cat]) -> Void, completionError: @escaping (String) -> Void) {
        var components = URLComponents(string: "https://api.thecatapi.com/v1/images/search")!
        components.queryItems = [
            URLQueryItem(name: "limit", value: String(limit))
        ]
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completionError(error?.localizedDescription ?? "Error connection")
                return
            }
            
            guard let data = data,
                let jsonArray = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
                    completionError("Nil data received")
                    return
            }
            
            guard let cats: [Cat] = self.parseCats(jsonArray) else {
                completionError("Malformed data received")
                return
            }
            
            completion(cats)
        }
        task.resume()
    }
    
    func downlandImage(url: String, completion: @escaping (UIImage?) -> Void){
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    completion(nil)
                    return
                }
            completion(image)
            }
       task.resume()
    }
    
    func parseCats(_ dictionaries: [[String: Any]]) -> [Cat] {
        var cats: [Cat] = []
        for dictionary in dictionaries {
            cats.append(Cat(dictionary))
        }
        return cats
    }
}


