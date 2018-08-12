//
//  MovieCVC.swift
//  IOS Test
//
//  Created by Omara on 26.07.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCVC: UICollectionViewCell {
    
    @IBOutlet weak var tittleL: UILabel!
    @IBOutlet weak var posterIV: UIImageView!
    @IBOutlet weak var productionYearL: UILabel!
    @IBOutlet weak var rateL: UILabel!
    
    func setUpMovieCell(movie: MovieDTO) {
        self.tittleL.text = movie.title
        if let url = URL(string: movie.posterURL) {
            self.posterIV.image = UIImage()
            self.posterIV.af_setImage(withURL: url)
        }
        self.productionYearL.text = movie.productionYear
        self.rateL.text = "\(movie.averageVote)"
    }
}
