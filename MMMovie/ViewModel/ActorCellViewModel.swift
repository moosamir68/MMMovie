//
//  ActorCellViewModel.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

protocol ActorCellViewModel {
    func getMovies() ->[Movie]
    func getActor() ->Actor
    func bindPageIndexOfMovies(pageIndex:Int)
    
    var pageIndexOfMovies:Int{get set}
}

class ActorCellViewModelImp:ActorCellViewModel{
    
    //MARK:- public properties
    var pageIndexOfMovies: Int = 0
    
    //MARK:- private properties
    var actor: Actor
    
    //MARK:- init
    init(actor:Actor) {
        self.actor = actor
    }
    
    //MARK:- public methods
    func getActor() -> Actor {
        return self.actor
    }
    
    func getMovies() -> [Movie] {
        return self.actor.movies!
    }
    
    func bindPageIndexOfMovies(pageIndex: Int) {
        self.pageIndexOfMovies = pageIndex
    }
}
