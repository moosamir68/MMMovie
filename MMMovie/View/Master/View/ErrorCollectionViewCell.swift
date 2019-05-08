//
//  ErrorCollectionViewCell.swift
//  Frikadell
//
//  Created by Moosa Mir on 7/22/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

let identifireErrorCollectionViewCell = "ErrorCollectionViewCell"

import UIKit

class ErrorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var errorTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillData(title:String){
        self.errorTitle.text = title
    }
}
