//
//  Extention+UIButton.swift
//  MMMovie
//
//  Created by iOS Developer on 5/9/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import UIKit

extension UIButton{
    func setImageWithTransition(image:UIImage, duration:Double = 0.7){
        UIView.transition(with: self, duration: 0.7, options: .transitionFlipFromRight, animations: {
            self.setImage(image, for: .normal)
        }, completion: nil)
    }
}
