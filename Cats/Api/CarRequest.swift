//
//  CarRequest.swift
//  Cats
//
//  Created by Руслан on 26.10.2019.
//  Copyright © 2019 Руслан. All rights reserved.
//

import Foundation

class CatRequest: NSObject {
    
    func getCat(url: String = "https://api.thecatapi.com/v1/images/search", completionSuccess: @escaping (Cat) -> Void, completionError: @escaping (String) -> Void) {
        guard let url = URL(string: url) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionError(error?.localizedDescription ?? "Error connection")
                return
            }
            
            guard let data = data,
                let jsonArray = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]],
                let json = jsonArray.first else {
                    completionError("Nil data received")
                    return
            }
            
            guard let cat: Cat = Cat(json) else {
                completionError("Malformed data received")
                return
            }
            completionSuccess(cat)
        }
        task.resume()
    }
}
