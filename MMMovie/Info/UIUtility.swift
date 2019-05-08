//
//  UIUtility.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/3/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit

struct UIUtility {
    
    static func boldFontWithPlusSize(increaseSize:CGFloat = 0.0) ->UIFont{
        return UIFont.boldSystemFont(ofSize:14 + increaseSize)
    }
    
    static func normalFontWithPlusSize(increaseSize:CGFloat = 0.0) ->UIFont{
        return UIFont.systemFont(ofSize:14 + increaseSize)
    }

    static func navigationBarColor() ->UIColor{
        return UIColor(red: 39.0/255.0, green: 54.0/255.0, blue: 60.0/255.0, alpha: 1.0)
    }
    
    static func defulatButtonColor() ->UIColor{
        return UIColor(red:0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.000)
    }
    
    static func backgroundColor() ->UIColor{
        return UIColor(red: 27.0/255.0, green: 31.0/255.0, blue: 44.0/255.0, alpha: 1.0)
    }
}
