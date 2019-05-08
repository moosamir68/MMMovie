//
//  ErrorTableViewCell.swift
//  Frikadell
//
//  Created by Moosa Mir on 6/10/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

let identifireErrorTableViewCell = "ErrorTableViewCell"

import UIKit

class ErrorTableViewCell: UITableViewCell {

    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.initUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- init ui
    private func initUI(){
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        self.boxView.backgroundColor = .clear
        
        self.titleLabel.textColor = UIColor.darkGray
        
        self.boxView.layer.cornerRadius = 4.0
    }
    
    //MARK:- public methods
    public func fillData(title:String?){
        self.titleLabel.text = title
    }
}
