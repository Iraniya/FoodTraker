//
//  Meal.swift
//  FoodTracker
//
//  Created by Iraniya Naynesh on 20/03/18.
//  Copyright © 2018 Iraniya Naynesh. All rights reserved.
//

import UIKit

class Meal {
    
    //MARK: properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        //Name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        //rating should be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        //Initialize store properties
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
