//
//  Extention+UISearchBar.swift
//  MMMovie
//
//  Created by iOS Developer on 5/9/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    func change(textFont : UIFont?, color:UIColor) {
        
        for view : UIView in (self.subviews[0]).subviews {
            
            if let textField = view as? UITextField {
                textField.font = textFont
                textField.textColor = color
            }
        }
    }
    
    func clearText() {
        self.text = ""
    }
}
