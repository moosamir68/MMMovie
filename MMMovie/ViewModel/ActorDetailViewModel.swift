//
//  ActorDetailViewModel.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

protocol ActorDetailViewModel {
    var actor:Actor{get set}
    var errorDescription:String?{get set}
    
    func getActorDetail()
    func getImagePath() ->String
}

class ActorDetailViewModelImp: ActorDetailViewModel {
    
    //MARK:- public properties
    var actor: Actor
    var errorDescription: String? = "Fetching data"
    
    //MARK:- private properties
    private weak var delegate:ViewModelDelegate? = nil
    
    //MARK:- init
    init(actor:Actor, delegate:ViewModelDelegate) {
        self.actor = actor
        self.delegate = delegate
    }
    
    //MARK:- public methods
    func getActorDetail() {
        
    }
    
    func getImagePath() -> String {
        return UrlManager.getMovieImagePath(image: self.actor.profilePath!)
    }
}

extension ActorDetailViewModelImp:MovieRequestDelegate{
    func sucessGetData(item: Codable, request: MovieRequest) {
        self.delegate?.sucessGetData()
    }
    
    func faildGetData(error: MovieError, request: MovieRequest) {
        self.delegate?.faildGetData()
    }
}
