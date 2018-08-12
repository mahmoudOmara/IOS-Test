//
//  AllFilmsView.swift
//  IOS Test
//
//  Created by Omara on 26.07.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import Foundation

protocol AllMoviesView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func getMoviesDidFinish(movies : [MovieDTO]?, forPageNumber number: Int)
    func getMoviesFailed(error: Error)
}
