//
//  MoviesViewController.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import UIKit

class MoviesViewController: MasterViewController {

    //MARK:- private properties
    private var viewModel:MoviesViewModel
    private var size:CGSize
    
    //MARK:- init
    init(movies:[Movie], size:CGSize) {
        self.viewModel = FactoryViewModel.MoviesViewModel(movies: movies)
        self.size = size
        super.init(nibName: "MoviesViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:- public methods
    func updateContent(movies:[Movie]){
        self.viewModel.bindMovies(movies: movies)
    }
}
