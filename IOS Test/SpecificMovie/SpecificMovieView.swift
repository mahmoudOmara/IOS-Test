//
//  SpecificMovieView.swift
//  IOS Test
//
//  Created by Omara on 27.07.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import Foundation

protocol SpecificMovieView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func getMovieDidFinish(movie : MovieDTO)
    func getMoviesFailed(error: Error)
}
