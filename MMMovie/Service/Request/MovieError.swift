//
//  MovieError.swift
//  MMMovie
//
//  Created by iOS Developer on 5/7/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

struct MovieError {
    var message:String = ""
    var statusCode:Int = 0
    
    init(error:Error) {
        
    }
    
    init(message:String, statusCode:Int) {
        self.message = ""
        self.statusCode = statusCode
    }
}
