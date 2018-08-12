//
//  FilmDTO.swift
//  IOS Test
//
//  Created by Omara on 26.07.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieDTO : Mappable {
    
    
    
    required init?(map: Map) {
        if let id = map["id"].currentValue as? Int,
            let averageVote = map["vote_average"].currentValue as? Double,
            let title = map["title"].currentValue as? String,
            let posterPath = map["poster_path"].currentValue as? String,
            let releaseDate = map["release_date"].currentValue as? String,
        let overview = map["overview"].currentValue as? String {
            
            self.id = id
            self.averageVote = averageVote
            self.title = title
            self.posterPath = posterPath
            self.releaseDate = releaseDate
            self.overview = overview
            
        } else {
            return nil
        }
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        averageVote <- map["vote_average"]
        title <- map["title"]
        posterPath <- map["poster_path"]
        releaseDate <- map["release_date"]
        genres <- map["genres"]
        overview <- map["overview"]
        productionCompanies <- map["production_companies"]
        setupMovie()
    }
    
    private func setupMovie() {
        self.posterURL = Constant.imagesURL + "original/" + self.posterPath
        self.productionYear = self.releaseDate.components(separatedBy: "-").first ?? ""
        
        for gener in self.genres ?? [] {
            genresDescribtion += "\(gener.name) / "
        }
        guard genresDescribtion.count > 0 else {
            return
        }
        genresDescribtion.removeLast(2)
        }
    
    
    var id : Int
    var averageVote: Double
    var title: String
    private var posterPath: String
    private var releaseDate: String
    var posterURL = ""
    var productionYear = ""
    private var genres: [GenreDTO]?
    var overview: String
    var productionCompanies: [ProductionCompanyDTO]?
    var genresDescribtion = ""
}
