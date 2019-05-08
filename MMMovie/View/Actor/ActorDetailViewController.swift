//
//  ActorViewController.swift
//  MMMovie
//
//  Created by iOS Developer on 5/4/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import UIKit

class ActorDetailViewController: MasterViewController {

    //MARK:- ui properties
    @IBOutlet weak var avatarBoxView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var actorNameLabel: UILabel!
    
    //MARK:- private proeprties
    private var viewModel:ActorDetailViewModel!
    
    //MARK:- init
    init(actor:Actor) {
        super.init(nibName: "ActorDetailViewController", bundle: nil)
        self.viewModel = FactoryViewModel.ActorDetailViewModel(actor: actor, delegate: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- init ui
    override func initUI() {
        
        self.navigationTitleString = self.viewModel.actor.name
        
        super.initUI()
        
        self.profileImageView.layer.cornerRadius = 56.0
        self.profileImageView.layer.masksToBounds = true
        
        self.bindDataOnView()
    }
    
    //MARK:- get data
    override func getData() {
        self.viewModel.getActorDetail()
    }
    
    //MARK:- private methods
    private func bindDataOnView(){
        self.setProfileImage()
        self.actorNameLabel.text = self.viewModel.actor.name
    }
    
    private func setProfileImage(){
        let imagePathString = self.viewModel.getImagePath()
        ImageCacheLoader.sharedInstanse.obtainImageWithPath(imagePath: imagePathString, placeHolder: #imageLiteral(resourceName: "AccountPlaceHolder")) {[weak self] (image, imagePath) in
            self?.profileImageView.image = image
        }
    }
}

//MARK:- extentions
extension ActorDetailViewController:ViewModelDelegate{
    func sucessGetData() {
        print("suceess get actor detail")
    }
    
    func faildGetData() {
        print("faild get actor detail")
    }
}
