//
//  WorkGroupDTO.swift
//  ADES
//
//  Created by mac on 08.06.18.
//  Copyright © 2018 Sameh Farouk. All rights reserved.
//

import Foundation
import ObjectMapper

class AllMoviesResultDTO : Mappable {
    
    init(movies: [MovieDTO]?) {
        self.pageNumber = 0
        self.movies = movies
    }
    
    required init?(map: Map) {
        if let pageNumber = map["page"].currentValue as? Int,
        let _ = map["results"].currentValue as? [[String : Any]]{
            self.pageNumber = pageNumber
            
        } else {
            return nil
        }
    }
    
    func mapping(map: Map) {
        pageNumber <- map["page"]
        movies <- map["results"]
    }
    
    
    var pageNumber: Int
    var movies: [MovieDTO]?
    

}
