//
//  ActorViewModel.swift
//  MMMovie
//
//  Created by iOS Developer on 5/4/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate:class {
    func sucessGetActors()
    func faildGetActors()
    func reloadData()
}

protocol MainViewModel {
    var actors:[Actor]{get set}
    var errorDescription:String?{get set}
    
    func getActors() ->Bool
    func getActorCellViewModel(row:Int) ->ActorCellViewModel
    func userDidTaponSearchButton(text:String?)
    func userDidTapOnCancelButton(text:String?)
    
    func getIndexOfItem(movieId:Int) ->Int?
}

class MainViewModelImp: MainViewModel {
    
    //MARK:- public properties
    var actors: [Actor]
    var errorDescription:String? = "Fetching actors"
    
    //MARK:- private methods
    private var delegate:MainViewModelDelegate? = nil
    lazy private var filter:MovieSearchObject = {return MovieSearchObject()}()
    private var isGettingData:Bool = false
    private var isCompletedGetData:Bool = false
    private var actorCellViewModels:[ActorCellViewModel] = []
    
    //MARK:- init
    init(actors:[Actor], delegate:MainViewModelDelegate){
        self.actors = actors
        self.delegate = delegate
        self.actorCellViewModels = self.getActorsViewModelForSpecialActors(actors: actors)
    }
    
    //MARK:- public methods
    //MARK:- network methods
    func getActors() ->Bool{
        
        guard !self.isCompletedGetData else{
            return false
        }
        
        guard  !self.isGettingData else {
            return false
        }
        
        self.isGettingData = true
        self.filter.page = self.getNextPageNumber()
        if(self.filter.searchKey != nil){
            HttpManager.searchActor(filter: self.filter, delegate: self)
        }else{
            HttpManager.getPopularActor(filter: self.filter, delegate: self)
        }
        
        return true
    }
    
    func getActorCellViewModel(row: Int) -> ActorCellViewModel {
        return self.actorCellViewModels[row]
    }
    
    func userDidTaponSearchButton(text: String?) {
        guard let _ = text else{
            return;
        }
        
        self.setSearchObjectValueAndResetData(text: text!)
        self.delegate?.reloadData()
        self.searchActors()
    }
    
    func userDidTapOnCancelButton(text: String?) {
        guard let _ = text, text != "" else{
            self.filter.searchKey = nil
            self.resetContent()
            self.errorDescription = "Fetching actors"
            self.delegate?.reloadData()
            _ = self.getActors()
            return;
        }
        
        return;
    }
    
    func getIndexOfItem(movieId:Int = 0) -> Int? {
        let actor = self.actors.first(where: {($0.movies?.contains(where: {$0.id == movieId}))!})
        guard let _ = actor else{
            return nil
        }
        
        let index = self.actors.firstIndex(where: {$0.id == actor?.id})
        return index
    }
    
    //MARK:- private methods
    //set search object values and reset data
    private func setSearchObjectValueAndResetData(text:String){
        self.resetContent()
        self.errorDescription = "Searching..."
        self.filter.searchKey = text
    }
    
    private func resetContent(){
        self.actors = []
        self.actorCellViewModels = []
        self.isGettingData = false
        self.isCompletedGetData = false
        self.filter.page = 1
    }
    
    //search actors
    private func searchActors(){
        HttpManager.searchActor(filter: self.filter, delegate: self)
    }
    
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

extension MainViewModelImp:MovieRequestDelegate{
    func faildGetData(error: MovieError, request: MovieRequest) {
        print("faield get movies")
        self.isGettingData = false
        self.delegate?.faildGetActors()
    }
    
    func sucessGetData(item: Codable, request: MovieRequest) {
        self.isGettingData = false
        if((item as! [Actor]).count == 0 || (item as! [Actor]).count < self.filter.pageSize){
            self.isCompletedGetData = true
        }
        self.appendNewItems(actors: item as! [Actor])
        self.appendActorCellViewModelToViewModels(actors: item as! [Actor])
        self.delegate?.sucessGetActors()
        print("sucess get movies")
    }
}
