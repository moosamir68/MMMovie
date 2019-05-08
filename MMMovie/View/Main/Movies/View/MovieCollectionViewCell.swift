//
//  MovieCollectionViewCell.swift
//  MMMovie
//
//  Created by iOS Developer on 5/8/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//
protocol MovieCollectionCellDelegate:class{
    func userDidTapOnMovie(movie:Movie)
}

let identifireMovieCollectionViewCell = "MovieCollectionViewCell"

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    
    //MARK:- private properties
    private var movie:Movie!
    private weak var delegate:MovieCollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initUI()
    }

    //MARK:- init ui
    private func initUI(){
        self.boxView.backgroundColor = .red
    }
    
    //MARK:- fill data
    func fillData(movie:Movie, delegate:MovieCollectionCellDelegate){
        self.movie = movie
        self.delegate = delegate
    }
}
