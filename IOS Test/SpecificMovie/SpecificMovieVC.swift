//
//  SpecificVC.swift
//  IOS Test
//
//  Created by Omara on 25.07.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit
import ShadowView
import KVNProgress

class SpecificMovieVC: UIViewController {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var imageContainerV: ShadowView!
    @IBOutlet weak var movieIV: UIImageView!
    @IBOutlet weak var movieNameL: UILabel!
    @IBOutlet var stars: [UIImageView]!
    @IBOutlet weak var movieProductionYearL: UILabel!
    @IBOutlet weak var genresL: UILabel!
    @IBOutlet weak var overviewL: UILabel!
    @IBOutlet weak var productionCompaniesTV: UITableView!
    @IBOutlet var loadingIndicators: [UIActivityIndicatorView]!
    
    
    private let specificMoviePresenter = SpecificMoviePresenter(specificMovieService: SpecificMovieService())
    var movie: MovieDTO!
    private var productionCompanies = [ProductionCompanyDTO] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupImageContainerView()
        NotificationCenter.default.addObserver(self, selector: #selector(setupImageContainerView) , name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        specificMoviePresenter.attachView(specificMovieView: self)
        self.fillMovieDate(movie: self.movie)
        specificMoviePresenter.getMovie(withID: movie.id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func setupImageContainerView(){
        
        imageContainerV.layer.cornerRadius = imageContainerV.frame.size.width / 2
        self.imageContainerV.clipsToBounds = true
        shadowView.layer.cornerRadius = shadowView.frame.size.width / 2
    }
    
    private func fillMovieDate(movie: MovieDTO){
        if let url = URL(string: movie.posterURL) {
            self.movieIV.image = UIImage(named: "")
            self.movieIV.af_setImage(withURL: url)
        }
        self.movieNameL.text = movie.title
        for i in 0..<Int((movie.averageVote/2).rounded()) {
            stars[i].image = #imageLiteral(resourceName: "star")
        }
        self.movieProductionYearL.text = movie.productionYear
        self.overviewL.text = movie.overview
    }

}

extension SpecificMovieVC : SpecificMovieView {
    func startLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        KVNProgress.show()
    }
    
    func finishLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        KVNProgress.showSuccess()
    }
    
    func getMovieDidFinish(movie: MovieDTO) {
        
        self.movie = movie
        self.genresL.text = movie.genresDescribtion
        self.productionCompanies = movie.productionCompanies ?? []
        self.productionCompaniesTV.reloadData()
        self.loadingIndicators.forEach { (indicator) in
            indicator.isHidden = true
        }
    }
    
    func getMoviesFailed(error: Error) {
        print(error.localizedDescription)
    }
    
    
}
extension SpecificMovieVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productionCompanies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productionCompanyCell", for: indexPath) as? ProductionCompanyTVC
        cell?.setUpCompanyCell(company: self.productionCompanies[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    
}
