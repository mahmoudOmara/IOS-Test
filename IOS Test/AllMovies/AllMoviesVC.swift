//
//  AllFilmsVC.swift
//  IOS Test
//
//  Created by Omara on 25.07.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit
import KVNProgress

class AllMoviesVC: UIViewController {

    @IBOutlet weak var moviesCV: UICollectionView!
    
    private var movies = [MovieDTO] ()
    private var currentPageNumber : Int = 1 {
        didSet{
            self.navigationItem.prompt = "\(currentPageNumber)"
        }
    }
    private let allMoviesPresenter = AllMoviesPresenter(allMoviesService: AllMoviesService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        allMoviesPresenter.attachView(allMoviesView: self)
        allMoviesPresenter.getMovies(forPageNumber: 1)
    }
    

    @IBAction func previosNextBtnClicked(_ sender: UIButton) {
        guard self.currentPageNumber + sender.tag <= 0 else {
            allMoviesPresenter.getMovies(forPageNumber: self.currentPageNumber + sender.tag)
            return
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedFilm = movies[moviesCV.indexPath(for: sender as! UICollectionViewCell)?.row ?? 0]
        if let specificMovieVC = segue.destination as? SpecificMovieVC {
            specificMovieVC.movie = selectedFilm
        }
    }
 

}

extension AllMoviesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCVC
        cell?.setUpMovieCell(movie: movies[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    
    
    
}

extension AllMoviesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ( collectionView.frame.width - 10 ) / 2
        let height = width * 1.7
        return CGSize(width: width, height: height)
    }
}

extension AllMoviesVC: AllMoviesView {
    
    func startLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        KVNProgress.show()
    }
    
    func finishLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        KVNProgress.showSuccess()
    }
    
    func getMoviesDidFinish(movies: [MovieDTO]?, forPageNumber number: Int) {
        self.movies = movies ?? []
        self.currentPageNumber = number
        self.moviesCV.reloadData()
    }
    
    func getMoviesFailed(error: Error) {
        print(error.localizedDescription)
    }
    
    
}
