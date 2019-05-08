//
//  MovieDetailViewModel.swift
//  MMMovie
//
//  Created by iOS Developer on 5/8/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

protocol MovieDetailViewModel {
    var errorDescription:String?{get set}
    
    func getMovieDetail()
    func getImagePath() ->String
    
    func getName() ->String?
    func getOverview() ->String?
    func getTagLine() ->String?
    func getPopularity() ->String?
    func getVoteAverage() ->String?
    func getRelaseDate() ->String?
    func getPeroductionCountries() ->String?
    func getProductionCompanies() ->String?
    func getGenres() ->String?
    func getBelongCollections() ->String?
}

class MovieDetailViewModelImp: MovieDetailViewModel {
    
    //MARK:- public properties
    
    var errorDescription: String? = "Fetching data"
    
    //MARK:- private properties
    private weak var delegate:ViewModelDelegate? = nil
    private var movie: Movie
    private var movieDetail:MovieDetail? = nil
    
    //MARK:- init
    init(movie:Movie, delegate:ViewModelDelegate) {
        self.movie = movie
        self.delegate = delegate
    }
    
    //MARK:- public methods
    func getImagePath() -> String {
        return UrlManager.getMovieImagePath(image: self.movie.backdropPath!)
    }
    
    func getName() -> String? {
        return self.movie.title
    }
    
    func getOverview() -> String? {
        return self.movieDetail?.overview
    }
    
    func getTagLine() -> String? {
        return self.movieDetail?.tagline
    }
    
    func getVoteAverage() -> String? {
        guard let _ = self.movieDetail, let _ = self.movieDetail?.voteAverage else {
            return nil
        }
        return "\((self.movieDetail?.voteAverage)!)"
    }
    
    func getRelaseDate() -> String? {
        return self.movieDetail?.releaseDate
    }
    
    func getPeroductionCountries() -> String? {
        guard let _ = self.movieDetail, let _ = self.movieDetail?.productionCountries else {
            return nil
        }
        var contriesName:[String] = []
        for country in (self.movieDetail?.productionCountries)!{
            contriesName.append(country.name!)
        }
        
        let value = contriesName.joined(separator: "\n")
        return value
    }
    
    func getProductionCompanies() -> String? {
        guard let _ = self.movieDetail, let _ = self.movieDetail?.productionCompanies else {
            return nil
        }
        var companiesName:[String] = []
        for company in (self.movieDetail?.productionCompanies)!{
            companiesName.append(company.name!)
        }
        
        let value = companiesName.joined(separator: "\n")
        return value
    }
    
    func getGenres() -> String? {
        guard let _ = self.movieDetail, let _ = self.movieDetail?.genres else {
            return nil
        }
        var genresName:[String] = []
        for genre in (self.movieDetail?.genres)!{
            genresName.append(genre.name!)
        }
        
        let value = genresName.joined(separator: "\n")
        return value
    }
    
    func getPopularity() -> String? {
        guard let _ = self.movieDetail, let _ = self.movieDetail?.popularity else {
            return nil
        }
        return "\((self.movieDetail?.popularity)!)"
    }
    
    func getBelongCollections() -> String? {
        guard let _ = self.movieDetail, let _ = self.movieDetail?.belongsToCollection else {
            return nil
        }
        
        return self.movieDetail?.belongsToCollection?.name
    }
    
    //MARK:- network methods
    func getMovieDetail() {
        HttpManager.getMovieDetail(id: self.movie.id, delegate: self)
    }
}

extension MovieDetailViewModelImp:MovieRequestDelegate{
    func sucessGetData(item: Codable, request: MovieRequest) {
        self.movieDetail = item as? MovieDetail
        self.delegate?.sucessGetData()
    }
    
    func faildGetData(error: MovieError, request: MovieRequest) {
        self.delegate?.faildGetData()
    }
}
