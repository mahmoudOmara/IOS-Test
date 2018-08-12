//
//  AllFilmsPresenter.swift
//  IOS Test
//
//  Created by Omara on 26.07.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import Foundation

class AllMoviesPresenter {
    
    private let allMoviesService: AllMoviesService
    weak private var allMoviesView: AllMoviesView?
    
    init(allMoviesService:AllMoviesService){
        self.allMoviesService = allMoviesService
    }
    
    func attachView(allMoviesView:AllMoviesView){
        self.allMoviesView = allMoviesView
    }
    
    func detachView() {
        allMoviesView = nil
    }
    
    func getMovies(forPageNumber number: Int) {
        
        self.allMoviesView?.startLoading()
        allMoviesService.getMovies(forPageNumber: number, callBack: { (result) in
            
            self.allMoviesView?.finishLoading()
            self.allMoviesView?.getMoviesDidFinish(movies: result.movies, forPageNumber: result.pageNumber)
            
        }, failureHandler: { (error) in
            self.allMoviesView?.finishLoading()
            self.allMoviesView?.getMoviesFailed(error: error)
        })
        
        
    }
    
}
