//
//  ActorDetailViewModel.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

protocol ActorDetailViewModel {
    
    var errorDescription:String?{get set}
    
    func getActorDetail()
    func getImagePath() ->String
    
    func canShowBioView() ->Bool
    func canShowPlaceBirhdayView() ->Bool
    func canShowBirthdayView() ->Bool
    func canShowDeathdayView() ->Bool
    func canShowPopularityView() ->Bool
    func canShowDepartmentView() ->Bool
    func canShowAlsoKnowView() ->Bool
    
    func getName() ->String?
    func getBio() ->String?
    func getPlaceOfBirhday() ->String?
    func getBirthday() ->String?
    func getDeathday() ->String?
    func getPopularity() ->String?
    func getDepartment() ->String?
    func getAlsoKnow() ->String?
}

class ActorDetailViewModelImp: ActorDetailViewModel {
    
    //MARK:- public properties
    var errorDescription: String? = "Fetching data"
    
    //MARK:- private properties
    var actor: Actor
    var actorDetail:ActorDetail? = nil
    private weak var delegate:ViewModelDelegate? = nil
    
    //MARK:- init
    init(actor:Actor, delegate:ViewModelDelegate) {
        self.actor = actor
        self.delegate = delegate
    }
    
    //MARK:- public methods
    func getActorDetail() {
        HttpManager.getActorDetail(id: self.actor.id, delegate: self)
    }
    
    func getImagePath() -> String {
        return UrlManager.getMovieImagePath(image: self.actor.profilePath!)
    }
    
    func canShowBioView() -> Bool {
        guard let  _ = self.actorDetail, let _ = self.actorDetail?.biography else{
            return false
        }
        return true
    }
    
    func canShowPlaceBirhdayView() -> Bool {
        guard let  _ = self.actorDetail, let _ = self.actorDetail?.placeOfBirth else{
            return false
        }
        return true
    }
    
    func canShowBirthdayView() -> Bool {
        guard let  _ = self.actorDetail, let _ = self.actorDetail?.birthday else{
            return false
        }
        return true
    }
    
    func canShowDeathdayView() -> Bool {
        guard let  _ = self.actorDetail, let _ = self.actorDetail?.deathday else{
            return false
        }
        return true
    }
    
    func canShowPopularityView() -> Bool {
        guard let  _ = self.actorDetail, let _ = self.actorDetail?.popularity else{
            return false
        }
        return true
    }
    
    func canShowAlsoKnowView() -> Bool {
        guard let  _ = self.actorDetail, let _ = self.actorDetail?.alsoKnownAs else{
            return false
        }
        return true
    }
    
    func canShowDepartmentView() -> Bool {
        guard let  _ = self.actorDetail, let _ = self.actorDetail?.knownForDepartment else{
            return false
        }
        return true
    }
    
    func getName() -> String? {
        return self.actor.name
    }
    
    func getBio() -> String? {
        return self.actorDetail?.biography
    }
    
    func getPlaceOfBirhday() -> String? {
        return self.actorDetail?.placeOfBirth
    }
    
    func getBirthday() -> String? {
        return self.actorDetail?.birthday
    }
    
    func getDeathday() -> String? {
        return self.actorDetail?.deathday
    }
    
    func getPopularity() -> String? {
        return "\(self.actorDetail?.popularity ?? 0)"
    }
    
    func getDepartment() -> String? {
        return self.actorDetail?.knownForDepartment
    }
    
    func getAlsoKnow() -> String? {
        return self.actorDetail?.alsoKnownAs?.joined(separator: "\n")
    }
}

extension ActorDetailViewModelImp:MovieRequestDelegate{
    func sucessGetData(item: Codable, request: MovieRequest) {
        self.actorDetail = item as? ActorDetail
        self.delegate?.sucessGetData()
    }
    
    func faildGetData(error: MovieError, request: MovieRequest) {
        self.delegate?.faildGetData()
    }
}
