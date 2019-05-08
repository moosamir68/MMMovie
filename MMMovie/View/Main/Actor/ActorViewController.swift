//
//  ActorViewController.swift
//  MMMovie
//
//  Created by iOS Developer on 5/8/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

protocol ActorControllerDelegate:class {
    func userSelectActor(actor:Actor)
}

import UIKit

class ActorViewController: MasterViewController {
    
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var actorImageView: UIImageView!
    
    //MARK:- private properties
    private var viewModel:ActorViewModel
    private weak var delegate:ActorControllerDelegate?
    
    //MARK:- init
    init(actor:Actor, delegate:ActorControllerDelegate) {
        self.viewModel = FactoryViewModel.ActorViewModel(actor: actor)
        self.delegate = delegate
        super.init(nibName: "ActorViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- init ui
    override func initUI() {
        super.initUI()
        
        let tapGestureOnBoxView = UITapGestureRecognizer(target: self, action: #selector(ActorViewController.userDidTapOnBoxView))
        self.boxView.addGestureRecognizer(tapGestureOnBoxView)
        
        self.actorImageView.layer.cornerRadius = 28.0
        self.actorImageView.layer.masksToBounds = true
    }
    
    //MARK:- public methods
    func updateContent(actor:Actor){
        self.viewModel.bindActor(actor: actor)
        self.updateContentUIAfterChangeDataFromParent()
    }
    
    //MARK:- priva methods
    private func updateContentUIAfterChangeDataFromParent(){
        self.actorNameLabel.text = self.viewModel.actor.name
        
        let imagePathString = self.viewModel.getImagePath()
        ImageCacheLoader.sharedInstanse.obtainImageWithPath(imagePath: imagePathString, placeHolder: #imageLiteral(resourceName: "AccountPlaceHolder")) {[weak self] (image, imagePath) in
            guard imagePath == self?.viewModel.getImagePath() else{
                self?.actorImageView.image = #imageLiteral(resourceName: "AccountPlaceHolder")
                return;
            }
            
            self?.actorImageView.image = image
        }
    }
    
    //MARK:- user did tap
    @objc private func userDidTapOnBoxView(){
        self.delegate?.userSelectActor(actor: self.viewModel.actor)
    }
}
