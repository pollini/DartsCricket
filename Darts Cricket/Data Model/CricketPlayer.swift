//
//  CricketPlayer.swift
//  Darts Cricket
//
//  Created by Marius on 07.08.16.
//  Copyright © 2016 MVP Systems. All rights reserved.
//

import UIKit

class CricketPlayer: NSObject {
    
    
    // MARK: - Properties
    // Note: The Fifteens the Player has scored.
    var fifteens: Int {
        didSet {
            if fifteens > 3 {
                fifteens = 3
            }
            self.checkFinishedStatus()
        }
    }
    
    // Note: The Sixteens the Player has scored.
    var sixteens: Int {
        didSet {
            if sixteens > 3 {
                sixteens = 3
            }
            self.checkFinishedStatus()
        }
    }
    
    // Note: The Seventeens the Player has scored.
    var seventeens: Int {
        didSet {
            if seventeens > 3 {
                seventeens = 3
            }
            self.checkFinishedStatus()
        }
    }
    
    // Note: The Eightteens the Player has scored.
    var eightteens: Int {
        didSet {
            if eightteens > 3 {
                eightteens = 3
            }
            self.checkFinishedStatus()
        }
    }
    
    // Note: The Nineteens the Player has scored.
    var nineteens: Int {
        didSet {
            if nineteens > 3 {
                nineteens = 3
            }
            self.checkFinishedStatus()
        }
    }
    
    // Note: The Twenties the Player has scored.
    var twenties: Int {
        didSet {
            if twenties > 3 {
                twenties = 3
            }
            self.checkFinishedStatus()
        }
    }
    
    // Note: The Bulls the Player has scored.
    var bulls: Int {
        didSet {
            if bulls > 3 {
                bulls = 3
            }
            self.checkFinishedStatus()
        }
    }
    
    // Note: The (overall) Points the Player has collected.
    var score: Int
    
    // Note: Trivial.
    var name: String
    
    // Note: A Bool for quickly indicating if the Player has striked all his Targets.
    var finished: Bool
    
    // Note: A Bool indicating if the Player has not hit anything in the Round before.
    var onFire: Bool
    
    // Note: An Optional for allocating an Image to the Player.
    var selfie: UIImage?
    
    
    // MARK: - Initializers
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
    
    init(cricketPlayer: CricketPlayer) {
        self.fifteens = cricketPlayer.fifteens
        self.sixteens = cricketPlayer.sixteens
        self.seventeens = cricketPlayer.seventeens
        self.eightteens = cricketPlayer.eightteens
        self.nineteens = cricketPlayer.nineteens
        self.twenties = cricketPlayer.twenties
        self.bulls = cricketPlayer.bulls
        
        self.score = cricketPlayer.score
        
        self.name = cricketPlayer.name
        
        self.finished = cricketPlayer.finished
        
        self.onFire = cricketPlayer.onFire
    }
    
    // MARK: - Resetting the (Properties of the) Player. (e.g. for a new Game)
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
    
    
    // MARK: - Helper for checking the "finished" Bool of the Player.
    private func checkFinishedStatus() {
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
    
    
    // MARK: - NSCopying Protocol
    func copyWithZone(zone: NSZone) -> CricketPlayer {
        return CricketPlayer(cricketPlayer: self)
    }
}
