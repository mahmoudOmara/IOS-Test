//
//  GenresDTO.swift
//  IOS Test
//
//  Created by Omara on 27.07.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import Foundation
import ObjectMapper

class GenreDTO: Mappable {
    required init?(map: Map) {
        if let id = map["id"].currentValue as? Int,
            let name = map["name"].currentValue as? String {
            self.id = id
            self.name = name
        } else {
            return nil
        }
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
    
    var id: Int
    var name: String
    
    
    
}
