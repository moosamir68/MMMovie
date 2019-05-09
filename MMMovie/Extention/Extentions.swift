//
//  Extentions.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import UIKit

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func removeItem(object: Element) {
        guard let index = index(of: object) else {return}
        remove(at: index)
    }
}

extension UIView {
    
    func addConstaintsToSuperview(topMargin:CGFloat = 0, bottomMargin:CGFloat = 0, tralingMargin:CGFloat = 0, leadingMargin:CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: self,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .leading,
                           multiplier: 1,
                           constant: leadingMargin).isActive = true
        
        NSLayoutConstraint(item: self,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: tralingMargin).isActive = true
        
        NSLayoutConstraint(item: self,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .top,
                           multiplier: 1,
                           constant: topMargin).isActive = true
        
        NSLayoutConstraint(item: self,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: bottomMargin).isActive = true
    }
    
    func addConstaintsToSuperviewFromTop(height:CGFloat = 54.0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: self,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: self,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: self,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: self,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: height).isActive = true
    }
}
