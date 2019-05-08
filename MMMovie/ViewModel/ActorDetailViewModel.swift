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
}

class ActorDetailViewModelImp:ActorDetailViewModel{
    
    //MARK:- public properties
    var actor: Actor
    
    //MARK:- init
    init(actor:Actor) {
        self.actor = actor
    }
}
