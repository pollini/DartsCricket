//
//  CricketPlayer.swift
//  Darts Cricket
//
//  Created by Marius on 07.08.16.
//  Copyright © 2016 MVP Systems. All rights reserved.
//

import UIKit

class CricketPlayer: NSObject {
    
    var fifteens: Int
    var sixteens: Int
    var seventeens: Int
    var eightteens: Int
    var nineteens: Int
    var twenties: Int
    var bulls: Int
    
    var score: Int
    
    var name: String
    
    var selfie: UIImage?
    

    init(name: String) {
        self.fifteens = 0
        self.sixteens = 0
        self.seventeens = 0
        self.eightteens = 0
        self.nineteens = 0
        self.twenties = 0
        self.bulls = 0
        
        self.score = 0
        
        self.name = name
    }
}
