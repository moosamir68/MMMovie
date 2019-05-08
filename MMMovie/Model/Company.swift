//
//  Company.swift
//  MMMovie
//
//  Created by iOS Developer on 5/8/19.
//  Copyright © 2019 MMMovie. All rights reserved.
//

import Foundation

struct Company: Codable {
    var id:Int = 0
    var logoPath:String? = ""
    var name:String? = ""
    var originCountry:String? = ""
    
    private enum CodingKeys:String, CodingKey{
        case id
        case name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}
