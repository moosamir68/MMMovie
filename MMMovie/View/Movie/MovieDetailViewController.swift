//
//  MovieDetailViewController.swift
//  MMMovie
//
//  Created by iOS Developer on 5/8/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import UIKit

class MovieDetailViewController: MasterViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var nameBoxView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //overview
    @IBOutlet weak var overviewStackView: UIStackView!
    @IBOutlet weak var overviewTitleLabel: UILabel!
    @IBOutlet weak var overviewValueLabel: UILabel!
    
    //tagline
    @IBOutlet weak var taglineStackView: UIStackView!
    @IBOutlet weak var taglineTitleLabel: UILabel!
    @IBOutlet weak var taglineValueLabel: UILabel!
    
    //popularity
    @IBOutlet weak var popularityStackView: UIStackView!
    @IBOutlet weak var popularityTitleLabel: UILabel!
    @IBOutlet weak var popularityValueLabel: UILabel!
    
    //vote average
    @IBOutlet weak var voteAverageStackView: UIStackView!
    @IBOutlet weak var voteAverageTitleLabel: UILabel!
    @IBOutlet weak var voteAverageValueLabel: UILabel!
    
    //relase date
    @IBOutlet weak var relaseDateStackView: UIStackView!
    @IBOutlet weak var relaseDateTitleLabel: UILabel!
    @IBOutlet weak var relaseDateValueLabel: UILabel!
    
    //production countries
    @IBOutlet weak var productionCountriesStackView: UIStackView!
    @IBOutlet weak var productionCountriesTitleLabel: UILabel!
    @IBOutlet weak var productionCountriesValueLabel: UILabel!
    
    //production companies
    @IBOutlet weak var productionCompaniesStackView: UIStackView!
    @IBOutlet weak var productionCompaniesTitleLabel: UILabel!
    @IBOutlet weak var productionCompaniesValueLabel: UILabel!
    
    //genres
    @IBOutlet weak var genresStackView: UIStackView!
    @IBOutlet weak var genresTitleLabel: UILabel!
    @IBOutlet weak var genresValueLabel: UILabel!
    
    //belong collections
    @IBOutlet weak var belongCollectionsStackView: UIStackView!
    @IBOutlet weak var belongCollectionsTitleLabel: UILabel!
    @IBOutlet weak var belongCollectionsValueLabel: UILabel!
    
    
    
    //MARK:- private properties
    private var viewModel:MovieDetailViewModel!
    
    //MARK:- init
    init(movie:Movie) {
        super.init(nibName: "MovieDetailViewController", bundle: nil)
        self.viewModel = FactoryViewModel.MovieDetailViewModel(movie: movie, delegate: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- init ui
    override func initUI() {
        self.navigationTitleString = self.viewModel.getName()
        super.initUI()
        
        self.bindDataOnView()
    }
    
    //MARK:- get data
    override func getData() {
        self.viewModel.getMovieDetail()
    }
    
    //MARK:- private methods
    private func bindDataOnView(){
        self.setProfileImage()
        self.nameLabel.text = self.viewModel.getName()
        
        //check for overview
        let overviewValue = self.viewModel.getOverview()
        if(overviewValue != nil){
            self.setShowOrHideView(view: self.overviewStackView, hide: false)
            self.overviewValueLabel.text = overviewValue
        }else{
            self.setShowOrHideView(view: self.overviewStackView, hide: true)
        }
        
        //cheching tagline
        let taglineValue = self.viewModel.getTagLine()
        if(taglineValue != nil){
            self.setShowOrHideView(view: self.taglineStackView, hide: false)
            self.taglineValueLabel.text = taglineValue
        }else{
            self.setShowOrHideView(view: self.taglineStackView, hide: true)
        }
        
        //cheching popularity
        let popularityValue = self.viewModel.getPopularity()
        if(popularityValue != nil){
            self.setShowOrHideView(view: self.popularityStackView, hide: false)
            self.popularityValueLabel.text = popularityValue
        }else{
            self.setShowOrHideView(view: self.popularityStackView, hide: true)
        }
        
        //cheching vote average
        let voteAverageValue = self.viewModel.getVoteAverage()
        if(voteAverageValue != nil){
            self.setShowOrHideView(view: self.voteAverageStackView, hide: false)
            self.voteAverageValueLabel.text = voteAverageValue
        }else{
            self.setShowOrHideView(view: self.voteAverageStackView, hide: true)
        }
        
        //cheching relase date
        let releaseDateValue = self.viewModel.getRelaseDate()
        if(releaseDateValue != nil){
            self.setShowOrHideView(view: self.relaseDateStackView, hide: false)
            self.relaseDateValueLabel.text = releaseDateValue
        }else{
            self.setShowOrHideView(view: self.relaseDateStackView, hide: true)
        }
        
        //cheching production countries
        let countriesValue = self.viewModel.getPeroductionCountries()
        if(countriesValue != nil){
            self.setShowOrHideView(view: self.productionCountriesStackView, hide: false)
            self.productionCountriesValueLabel.text = countriesValue
        }else{
            self.setShowOrHideView(view: self.productionCountriesStackView, hide: true)
        }
        
        //cheching production companies
        let companiesValue = self.viewModel.getProductionCompanies()
        if(companiesValue != nil){
            self.setShowOrHideView(view: self.productionCompaniesStackView, hide: false)
            self.productionCompaniesValueLabel.text = companiesValue
        }else{
            self.setShowOrHideView(view: self.productionCompaniesStackView, hide: true)
        }
        
        //cheching production companies
        let genrsValue = self.viewModel.getGenres()
        if(genrsValue != nil){
            self.setShowOrHideView(view: self.genresStackView, hide: false)
            self.genresValueLabel.text = genrsValue
        }else{
            self.setShowOrHideView(view: self.genresStackView, hide: true)
        }
        
        //cheching production companies
        let collectionsValue = self.viewModel.getBelongCollections()
        if(collectionsValue != nil){
            self.setShowOrHideView(view: self.belongCollectionsStackView, hide: false)
            self.belongCollectionsValueLabel.text = collectionsValue
        }else{
            self.setShowOrHideView(view: self.belongCollectionsStackView, hide: true)
        }
    }
    
    private func setProfileImage(){
        let imagePathString = self.viewModel.getImagePath()
        ImageCacheLoader.sharedInstanse.obtainImageWithPath(imagePath: imagePathString, placeHolder: #imageLiteral(resourceName: "MoviePlaceHolder")) {[weak self] (image, imagePath) in
            self?.movieImageView.image = image
        }
    }
    
    private func setShowOrHideView(view:UIStackView, hide:Bool){
        UIView.animate(withDuration: 0.3, animations: {
            view.isHidden = hide
            for subView in view.subviews{
                subView.alpha = hide == true ? 0 : 1
            }
        }) { (finished) in
            self.view.layoutIfNeeded()
        }
    }
    
    func hideActivityIndicator(){
        self.activityIndicator.stopAnimating()
    }
}

//MARK:- extentions
extension MovieDetailViewController:ViewModelDelegate{
    func sucessGetData() {
        DispatchQueue.main.async {
            print("suceess get movie detail")
            self.hideActivityIndicator()
            self.bindDataOnView()
        }
    }
    
    func faildGetData() {
        print("faild get movie detail")
    }
}
