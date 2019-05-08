//
//  FactoryViewModel.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//
protocol ViewModelDelegate:class {
    func sucessGetData()
    func faildGetData()
}

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
    
    static func MoviesViewModel(movies:[Movie], pageIndex:Int) ->MoviesViewModel{
        return MoviesViewModelImp(movies: movies, pageIndex: pageIndex)
    }
    
    static func MovieDetailViewModel(movie:Movie, delegate:ViewModelDelegate) ->MovieDetailViewModel{
        return MovieDetailViewModelImp(movie: movie, delegate: delegate)
    }
    
    static func ActorDetailViewModel(actor:Actor, delegate:ViewModelDelegate) ->ActorDetailViewModel{
        return ActorDetailViewModelImp(actor: actor, delegate: delegate)
    }
}
