//
//  ActorViewController.swift
//  MMMovie
//
//  Created by iOS Developer on 5/8/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import UIKit

class ActorViewController: MasterViewController {
    
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var actorPopularityLabel: UILabel!
    @IBOutlet weak var actorImageView: UIImageView!
    
    //MARK:- private properties
    private var viewModel:ActorViewModel
    
    //MARK:- init
    init(actor:Actor) {
        self.viewModel = FactoryViewModel.ActorViewModel(actor: actor)
        super.init(nibName: "ActorViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- init ui
    override func initUI() {
        super.initUI()
    }
    
    //MARK:- public methods
    func updateContent(actor:Actor){
        self.viewModel.bindActor(actor: actor)
        self.updateContentUIAfterChangeDataFromParent()
    }
    
    //MARK:- priva methods
    private func updateContentUIAfterChangeDataFromParent(){
        self.actorNameLabel.text = self.viewModel.actor.name
    }
    
}
