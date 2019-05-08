//
//  ReusableView.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var cellIdentifier: String {
        return NSStringFromClass(classForCoder())
    }
}

