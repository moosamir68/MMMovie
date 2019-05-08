//
//  ActorViewModel.swift
//  MMMovie
//
//  Created by iOS Developer on 5/4/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

protocol ActorsViewModelDelegate:class {
    func sucessGetActors()
    func faildGetActors()
}

protocol ActorsViewModel {
    var actors:[Actor]{get set}
    var errorDescription:String?{get set}
    
    func getActors()
    func getActorCellViewModel(row:Int) ->ActorCellViewModel
}

class ActorsViewModelImp: ActorsViewModel {
    
    //MARK:- public properties
    internal var actors: [Actor]
    internal var errorDescription:String? = "Fetching data"
    
    //MARK:- private methods
    private var delegate:ActorsViewModelDelegate? = nil
    lazy private var filter:MovieSearchObject = {return MovieSearchObject()}()
    private var isGettingData:Bool = false
    private var isCompletedGetData:Bool = false
    private var actorCellViewModels:[ActorCellViewModel] = []
    
    //MARK:- init
    init(actors:[Actor], delegate:ActorsViewModelDelegate){
        self.actors = actors
        self.delegate = delegate
        self.actorCellViewModels = self.getActorsViewModelForSpecialActors(actors: actors)
    }
    
    //MARK:- public methods
    //MARK:- network methods
    func getActors() {
        
        guard !self.isCompletedGetData else{
            return;
        }
        
        guard  !self.isGettingData else {
            return;
        }
        
        self.isGettingData = true
        self.filter.page = self.getNextPageNumber()
        HttpManager.getPopularActor(filter: self.filter, delegate: self)
    }
    
    func getActorCellViewModel(row: Int) -> ActorCellViewModel {
        return self.actorCellViewModels[row]
    }
    
    //MARK:- private methods
    //get next page number for request
    private func getNextPageNumber() ->Int{
        let page = (self.actors.count / self.filter.pageSize) + 1
        return page
    }
    
    //MARK:- append new items to actors
    private func appendNewItems(actors:[Actor]){
        self.actors.append(contentsOf: actors)
    }
    
    //MARK:- append new items to viewmodels
    private func appendActorCellViewModelToViewModels(actors:[Actor]){
        let viewModels = self.getActorsViewModelForSpecialActors(actors: self.actors)
        self.actorCellViewModels.append(contentsOf: viewModels)
    }
    
    private func getActorsViewModelForSpecialActors(actors:[Actor]) ->[ActorCellViewModel]{
        var viewModels:[ActorCellViewModel] = []
        for actor in self.actors{
            let actorCellViewModel = FactoryViewModel.ActorCellViewModel(actor: actor)
            viewModels.append(actorCellViewModel)
        }
        
        return viewModels
    }
}

extension ActorsViewModelImp:MovieRequestDelegate{
    func faildGetData(error: MovieError, request: MovieRequest) {
        print("faield get movies")
        self.isGettingData = false
        self.delegate?.faildGetActors()
    }
    
    func sucessGetData(item: Codable, request: MovieRequest) {
        self.isGettingData = false
        self.appendNewItems(actors: item as! [Actor])
        self.appendActorCellViewModelToViewModels(actors: item as! [Actor])
        self.delegate?.sucessGetActors()
        print("sucess get movies")
    }
}
