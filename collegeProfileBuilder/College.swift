//
//  College.swift
//  collegeProfileBuilder
//
//  Created by cmacgregor on 2/8/17.
//  Copyright © 2017 cmacgregor. All rights reserved.
//

import UIKit

class College: Object {
   
    dynamic var name = String()
    dynamic var location = String()
    dynamic var population = Int()
    dynamic var image = Data()
    
    convenience init(name: String, location: String, population: Int, image: Data) {
        self.init()
        self.name = name
        self.location = location
        self.population = population
        self.image = image
    }
}
