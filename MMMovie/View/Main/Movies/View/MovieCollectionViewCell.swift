//
//  MovieCollectionViewCell.swift
//  MMMovie
//
//  Created by iOS Developer on 5/8/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

let identifireMovieCollectionViewCell = "MovieCollectionViewCell"

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    
    //MARK:- private properties
    private var movie:Movie!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initUI()
    }

    //MARK:- init ui
    private func initUI(){
        self.movieImageView.backgroundColor = .red
    }
    
    //MARK:- fill data
    func fillData(movie:Movie){
        self.movie = movie
    }
}
