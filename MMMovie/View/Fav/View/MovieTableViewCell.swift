//
//  MovieTableViewCell.swift
//  MMMovie
//
//  Created by iOS Developer on 5/9/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

let identifireMovieTableViewCell = "MovieTableViewCell"

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    //MARK:- private properties
    private var movie:Movie!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- init ui
    private func initUI(){
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
    
    //MARK:- fill data with movie
    func fillData(movie:Movie){
        self.movie = movie
        self.movieNameLabel.text = movie.title
        
        let imagePathString = self.getImagePath()
        ImageCacheLoader.sharedInstanse.obtainImageWithPath(imagePath: imagePathString, placeHolder: #imageLiteral(resourceName: "MoviePlaceHolder")) {[weak self] (image, imagePath) in
            guard imagePath == self?.getImagePath() else{
                self?.movieImageView.image = #imageLiteral(resourceName: "MoviePlaceHolder")
                return;
            }
            
            self?.movieImageView.image = image
        }
    }
    
    private func getImagePath() ->String{
        return UrlManager.getMovieImagePath(image: self.movie.backdropPath!)
    }
}
