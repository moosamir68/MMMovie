//
//  Constrant+Extention.swift
//  MMMovie
//
//  Created by iOS Developer on 5/10/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import UIKit

extension UIView {
    
    func addConstaintsToSuperview(topMargin:CGFloat = 0, bottomMargin:CGFloat = 0, tralingMargin:CGFloat = 0, leadingMargin:CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = self.getTopConstraint()
        topConstraint.isActive = true
        
        let tralingConstraint = self.getTralingConstraint()
        tralingConstraint.isActive = true
        
        let leadingConstraint = self.getLeadingConstraint()
        leadingConstraint.isActive = true
        
        let bottomConstraint = self.getBottomConstraint()
        bottomConstraint.isActive = true
        
        
    }
    
    func addConstaintsToSuperviewFromTop(height:CGFloat = 54.0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = self.getTopConstraint()
        topConstraint.isActive = true
        
        let tralingConstraint = self.getTralingConstraint()
        tralingConstraint.isActive = true
        
        let leadingConstraint = self.getLeadingConstraint()
        leadingConstraint.isActive = true
        
        let heightConstraint = self.getHeightConstraint(height: height)
        heightConstraint.isActive = true
    }
    
    func addConstraintToCenter(){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalyCenterConstraint = self.getHorizintalyCenterConstraint()
        horizontalyCenterConstraint.isActive = true
        
        let vetricalCenterConstraint = self.getVerticalCenterConstraint()
        vetricalCenterConstraint.isActive = true
    }
    
    //MARK:- private methods
    private func getLeadingConstraint() ->NSLayoutConstraint{
        let constraint = NSLayoutConstraint(item: self,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 0)
        
        return constraint
    }
    
    private func getTralingConstraint() ->NSLayoutConstraint{
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .trailing,
                                            relatedBy: .equal,
                                            toItem: self.superview,
                                            attribute: .trailing,
                                            multiplier: 1,
                                            constant: 0)
        
        return constraint
    }
    
    private func getTopConstraint() ->NSLayoutConstraint{
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: self.superview,
                                            attribute: .top,
                                            multiplier: 1,
                                            constant: 0)
        
        return constraint
    }
    
    private func getBottomConstraint() ->NSLayoutConstraint{
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: self.superview,
                                            attribute: .bottom,
                                            multiplier: 1,
                                            constant: 0)
        
        return constraint
    }
    
    private func getHeightConstraint(height:CGFloat) ->NSLayoutConstraint{
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: height)
        
        return constraint
    }
    
    private func getHorizintalyCenterConstraint() ->NSLayoutConstraint{
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .centerX,
                                            relatedBy: .equal,
                                            toItem: self.superview,
                                            attribute: .centerX,
                                            multiplier: 1,
                                            constant: 0)
        
        return constraint
    }
    
    private func getVerticalCenterConstraint() ->NSLayoutConstraint{
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .centerY,
                                            relatedBy: .equal,
                                            toItem: self.superview,
                                            attribute: .centerY,
                                            multiplier: 1,
                                            constant: 0)
        
        return constraint
    }
}
