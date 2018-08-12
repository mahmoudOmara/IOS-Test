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

class AllMoviesService {
    
    private var urlString = Constant.baseURL + Constant.discoverMovies + "?api_key=\(Constant.apiKey)"
    
    
    func getMovies(forPageNumber number: Int, callBack:@escaping (AllMoviesResultDTO) -> Void, failureHandler:@escaping (Error) -> Void) {
        
        urlString += "&page=\(number)"
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseObject(completionHandler: { (response: DataResponse<AllMoviesResultDTO>) in
            switch response.result {
            case .success:
                if let result = response.result.value{
                    callBack(result)
                }
                else {
                    callBack(AllMoviesResultDTO(movies: nil))
                }
            case .failure(let error):
                failureHandler(error)
                print(error)
            }
        })
    }
}
