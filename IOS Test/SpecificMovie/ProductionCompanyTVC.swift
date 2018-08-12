//
//  ProductionCompanyTVC.swift
//  IOS Test
//
//  Created by Omara on 27.07.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit
import AlamofireImage

class ProductionCompanyTVC: UITableViewCell {

    @IBOutlet weak var companyLogoIV: UIImageView!
    @IBOutlet weak var companyNameL: UILabel!
    
    func setUpCompanyCell(company: ProductionCompanyDTO) {
        self.companyNameL.text = company.name
        if let url = URL(string: company.logoURL){
            self.companyLogoIV.af_setImage(withURL: url)
        }
        
    }

}
