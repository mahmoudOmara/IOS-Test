//
//  SpecificMoviePresenter.swift
//  IOS Test
//
//  Created by Omara on 27.07.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import Foundation

class SpecificMoviePresenter {
 
    private let specificMovieService: SpecificMovieService
    weak private var specificMovieView: SpecificMovieView?
    
    init(specificMovieService:SpecificMovieService){
        self.specificMovieService = specificMovieService
    }
    
    func attachView(specificMovieView: SpecificMovieView){
        self.specificMovieView = specificMovieView
    }
    
    func detachView() {
        specificMovieView = nil
    }
    
    func getMovie(withID id: Int) {
        
        specificMovieService.getMovie(withID: id, callBack: { (result) in
            
            self.specificMovieView?.getMovieDidFinish(movie: result)
            
        }, failureHandler: { (error) in
            self.specificMovieView?.finishLoading()
            self.specificMovieView?.getMoviesFailed(error: error)
        })
        
        
    }
    
}
