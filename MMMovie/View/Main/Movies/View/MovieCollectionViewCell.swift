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
    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK:- private properties
    private var movie:Movie!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initUI()
    }

    //MARK:- init ui
    private func initUI(){
        
    }
    
    //MARK:- fill data
    func fillData(movie:Movie){
        self.movie = movie
        
        self.nameLabel.text = movie.title
        
        let imagePathString = UrlManager.getMovieImagePath(image: movie.getBackdropPath())
        ImageCacheLoader.sharedInstanse.obtainImageWithPath(imagePath: imagePathString, placeHolder: #imageLiteral(resourceName: "MoviePlaceHolder")) {[weak self] (image, imagePath) in
            guard imagePath == self?.getImagePath() else{
                self?.movieImageView.image = #imageLiteral(resourceName: "MoviePlaceHolder")
                return;
            }
            
            self?.movieImageView.image = image
        }
        
        if(MovieCacheManager.shared.checkExistMovieOnCache(movie: movie)){
            self.favImageView.image = #imageLiteral(resourceName: "selectedStar")
        }else{
            self.favImageView.image = #imageLiteral(resourceName: "star")
        }
    }
    
    private func getImagePath() ->String{
        return UrlManager.getMovieImagePath(image: self.movie.getBackdropPath())
    }
}
