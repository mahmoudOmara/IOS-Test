//
//  SpecificMovieService.swift
//  IOS Test
//
//  Created by Omara on 27.07.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class SpecificMovieService {

    
    
    func getMovie(withID id: Int, callBack:@escaping (MovieDTO) -> Void, failureHandler:@escaping (Error) -> Void) {
        
        let urlString = Constant.baseURL + Constant.specificMovie + "/\(id)" + "?api_key=\(Constant.apiKey)"
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseObject(completionHandler: { (response: DataResponse<MovieDTO>) in
            switch response.result {
            case .success:
                if let result = response.result.value{
                    callBack(result)
                }
            case .failure(let error):
                failureHandler(error)
                print(error)
            }
        })
    }
}

