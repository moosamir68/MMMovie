//
//  ActorTableViewCell.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

let identifireActorTableViewCell = "ActorTableViewCell"

protocol ActorCellDelegate:class {
    func userDidTapOnActor(actor:Actor)
    func userDidTapOnMovie(movie:Movie)
    
    func getActorCellController(viewModel:ActorCellViewModel) ->ActorCellViewController
}

import UIKit

class ActorTableViewCell: UITableViewCell {

    //MARK:- ui properties
    @IBOutlet weak var boxView: UIView!
    
    //MARK:- Properties
    private weak var actorCellController:ActorCellViewController? = nil
    private weak var delegate:ActorCellDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- private methods
    //MARK:- init ui
    private func initUI(){
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
    
    //MARK:- fill data
    func fillData(delegate:ActorCellDelegate, actorCellviewModel:ActorCellViewModel){
        self.delegate = delegate
        if(self.actorCellController == nil){
            self.actorCellController = self.delegate?.getActorCellController(viewModel: actorCellviewModel)
            self.boxView.addSubview((self.actorCellController?.view)!)
            self.actorCellController?.view.addConstaintsToSuperview()
        }
        
        self.actorCellController?.updateContent(viewModel: actorCellviewModel)
    }
    
}
