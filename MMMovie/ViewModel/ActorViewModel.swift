//
//  ActorViewModel.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

protocol ActorViewModel{
    var actor:Actor{get set}
    
    func bindActor(actor:Actor)
    func getImagePath() ->String
}


class ActorViewModelImp: ActorViewModel {
    
    //MARK:- public properties
    var actor: Actor
    
    //MARK;- init
    init(actor:Actor) {
        self.actor = actor
    }
    
    //MARK:- public functions
    func bindActor(actor: Actor) {
        self.actor = actor
    }
    
    func getImagePath() -> String {
        let imagePathString = "\(UrlManager.baseImageUrl)\(UrlManager.imageProfileType)\(self.actor.profilePath!)"
        return imagePathString
    }
}
