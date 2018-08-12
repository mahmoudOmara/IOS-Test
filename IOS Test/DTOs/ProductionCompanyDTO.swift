//
//  ProductionCompaniesDTO.swift
//  IOS Test
//
//  Created by Omara on 27.07.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductionCompanyDTO: Mappable {
    required init?(map: Map) {
        if let id = map["id"].currentValue as? Int,
            let logoPath = map["logo_path"].currentValue as? String,
            let name = map["name"].currentValue as? String {
            self.id = id
            self.logoPath = logoPath
            self.name = name
        } else {
            return nil
        }
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        logoPath <- map["logo_path"]
        name <- map["name"]
        setupProductionCompany()
    }
    
    private func setupProductionCompany(){
        self.logoURL = Constant.imagesURL + "original/" + self.logoPath
    }
    
    var id: Int
    private var logoPath: String
    var name: String
    var logoURL: String = ""
    
    
    
}

