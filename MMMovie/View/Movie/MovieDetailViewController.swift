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
        self.navigationTitleString = self.viewModel.movie.title
        
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
        self.nameLabel.text = self.viewModel.movie.title
    }
    
    private func setProfileImage(){
        let imagePathString = self.viewModel.getImagePath()
        ImageCacheLoader.sharedInstanse.obtainImageWithPath(imagePath: imagePathString, placeHolder: #imageLiteral(resourceName: "MoviePlaceHolder")) {[weak self] (image, imagePath) in
            self?.movieImageView.image = image
        }
    }
}

//MARK:- extentions
extension MovieDetailViewController:ViewModelDelegate{
    func sucessGetData() {
        print("suceess get movie detail")
    }
    
    func faildGetData() {
        print("faild get movie detail")
    }
}
