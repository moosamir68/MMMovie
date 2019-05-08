//
//  FactoryViewModel.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//


struct FactoryViewModel{
    static func ActorsViewModel(actors:[Actor], delegate:ActorsViewModelDelegate) ->ActorsViewModel{
        return ActorsViewModelImp(actors: actors, delegate: delegate)
    }
    
    static func ActorCellViewModel(actor:Actor) ->ActorCellViewModel{
        return ActorCellViewModelImp(actor: actor)
    }
    
    static func ActorViewModel(actor:Actor) ->ActorViewModel{
        return ActorViewModelImp(actor: actor)
    }
    
    static func MoviesViewModel(movies:[Movie]) ->MoviesViewModel{
        return MoviesViewModelImp(movies: movies)
    }
}
