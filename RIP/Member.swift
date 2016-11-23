//
//  Member.swift
//  RIP
//
//  Created by Sanjay Shrestha on 11/23/16.
//  Copyright © 2016 cs197. All rights reserved.
//

import Foundation


class Member{
    var product_id: String?
    var summary: String?
    var rating: Int?
    var text: String?
    init(product_id: String, summary: String, rating: Int, text: String){
        self.product_id = product_id
        self.rating = rating
        self.summary = summary
        self.text = text
        
    }

}
