//
//  Cat.swift
//  Cats
//
//  Created by Руслан on 26.10.2019.
//  Copyright © 2019 Руслан. All rights reserved.
//

import Foundation
import UIKit

struct Cat {
    var height: Int
    var id: String
    var url: String
    var width: Int
    
    init(_ dictionary: [String: Any]){
        self.height = dictionary["height"] as? Int ?? 0
        self.id = dictionary["id"] as? String ?? ""
        self.url = dictionary["url"] as? String ?? ""
        self.width = dictionary["width"] as? Int ?? 0
    }
}
