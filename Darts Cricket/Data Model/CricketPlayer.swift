//
//  CricketPlayer.swift
//  Darts Cricket
//
//  Created by Marius on 07.08.16.
//  Copyright © 2016 MVP Systems. All rights reserved.
//

import UIKit

class CricketPlayer: NSObject {
    
    var fifteens: Int {
        didSet {
            if fifteens > 3 {
                fifteens = 3
            }
            self.checkStatus()
        }
    }
    
    var sixteens: Int {
        didSet {
            if sixteens > 3 {
                sixteens = 3
            }
            self.checkStatus()
        }
    }
    
    var seventeens: Int {
        didSet {
            if seventeens > 3 {
                seventeens = 3
            }
            self.checkStatus()
        }
    }
    
    var eightteens: Int {
        didSet {
            if eightteens > 3 {
                eightteens = 3
            }
            self.checkStatus()
        }
    }
    
    var nineteens: Int {
        didSet {
            if nineteens > 3 {
                nineteens = 3
            }
            self.checkStatus()
        }
    }
    
    var twenties: Int {
        didSet {
            if twenties > 3 {
                twenties = 3
            }
            self.checkStatus()
        }
    }
    
    var bulls: Int {
        didSet {
            if bulls > 3 {
                bulls = 3
            }
            self.checkStatus()
        }
    }
    
    var score: Int
    
    var name: String
    
    var finished: Bool
    
    var onFire: Bool
    
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
        
        self.finished = false
        
        self.onFire = false
    }
    
    func resetPlayer() {
        self.fifteens = 0
        self.sixteens = 0
        self.seventeens = 0
        self.eightteens = 0
        self.nineteens = 0
        self.twenties = 0
        self.bulls = 0
        
        self.score = 0
        self.finished = false
        self.onFire = false
    }
    
    private func checkStatus() {
        if self.bulls == 3 {
            if self.fifteens == 3 {
                if self.sixteens == 3 {
                    if self.seventeens == 3 {
                        if self.eightteens == 3 {
                            if self.nineteens == 3 {
                                if self.twenties == 3 {
                                    self.finished = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
