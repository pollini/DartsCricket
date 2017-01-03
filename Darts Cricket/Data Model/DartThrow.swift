//
//  DartThrow.swift
//  Darts Cricket
//
//  Created by Marius on 03.01.17.
//  Copyright © 2017 MVP Systems. All rights reserved.
//

import UIKit

class DartThrow: NSObject {
    
    // MARK: - Properties
    var throwingPlayer: CricketPlayer
    var players: [CricketPlayer]
    
    var scoredFifteens: Int
    var scoredSixteens: Int
    var scoredSeventeens: Int
    var scoredEightteens: Int
    var scoredNineteens: Int
    var scoredTwenties: Int
    var scoredBulls: Int
    
    
    // MARK: - Initializer
    init(player: CricketPlayer,
         players: [CricketPlayer],
         fifteens: Int,
         sixteens: Int,
         seventeens: Int,
         eightteens: Int,
         nineteens: Int,
         twenties: Int,
         bulls: Int) {
        
        self.throwingPlayer = player
        self.players = players
        self.scoredFifteens = fifteens
        self.scoredSixteens = sixteens
        self.scoredSeventeens = seventeens
        self.scoredEightteens = eightteens
        self.scoredNineteens = nineteens
        self.scoredTwenties = twenties
        self.scoredBulls = bulls
    }

}
