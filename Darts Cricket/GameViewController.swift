//
//  GameViewController.swift
//  Darts Cricket
//
//  Created by Marius on 08.08.16.
//  Copyright © 2016 MVP Systems. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var fifteensSegment: UISegmentedControl!
    @IBOutlet weak var sixteensSegment: UISegmentedControl!
    @IBOutlet weak var seventeensSegment: UISegmentedControl!
    @IBOutlet weak var eightteensSegment: UISegmentedControl!
    @IBOutlet weak var nineteensSegment: UISegmentedControl!
    @IBOutlet weak var twentiesSegment: UISegmentedControl!
    @IBOutlet weak var bullsSegment: UISegmentedControl!
    @IBOutlet weak var submitButton: UIButton!
    
    var players: [CricketPlayer] = []
    var currentPlayerIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.playerNameLabel.text = self.players[self.currentPlayerIndex].name
        
        // TO DO: CollectionViewLayout for self.players.count
        let cVWidth = self.collectionView.frame.size.width
        let cVLayout = UICollectionViewFlowLayout()
        cVLayout.itemSize = CGSize.init(width: cVWidth/CGFloat(self.players.count)-1, height: 63.0)
        cVLayout.minimumInteritemSpacing = 1
        self.collectionView.collectionViewLayout = cVLayout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: - Action for Submit Button
    @IBAction func submitButtonPressed(sender: AnyObject) {
        
        let currentPlayer = self.players[self.currentPlayerIndex]
        var nullRound = true
        
        var remainingFifteens = self.fifteensSegment.selectedSegmentIndex
        if remainingFifteens > 0 {
            nullRound = false
            while currentPlayer.fifteens < 3 && remainingFifteens > 0 {
                currentPlayer.fifteens += 1
                remainingFifteens -= 1
            }
        }
        
        var remainingSixteens = self.sixteensSegment.selectedSegmentIndex
        if remainingSixteens > 0 {
            nullRound = false
            while currentPlayer.sixteens < 3 && remainingSixteens > 0 {
                currentPlayer.sixteens += 1
                remainingSixteens -= 1
            }
        }
        
        var remainingSeventeens = self.seventeensSegment.selectedSegmentIndex
        if remainingSeventeens > 0 {
            nullRound = false
            while currentPlayer.seventeens < 3 && remainingSeventeens > 0 {
                currentPlayer.seventeens += 1
                remainingSeventeens -= 1
            }
        }
        
        var remainingEightteens = self.eightteensSegment.selectedSegmentIndex
        if remainingEightteens > 0 {
            nullRound = false
            while currentPlayer.eightteens < 3 && remainingEightteens > 0 {
                currentPlayer.eightteens += 1
                remainingEightteens -= 1
            }
        }
        
        var remainingNineteens = self.nineteensSegment.selectedSegmentIndex
        if remainingNineteens > 0 {
            nullRound = false
            while currentPlayer.nineteens < 3 && remainingNineteens > 0 {
                currentPlayer.nineteens += 1
                remainingNineteens -= 1
            }
        }
        
        var remainingTwenties = self.twentiesSegment.selectedSegmentIndex
        if remainingTwenties > 0 {
            nullRound = false
            while currentPlayer.twenties < 3 && remainingTwenties > 0 {
                currentPlayer.twenties += 1
                remainingTwenties -= 1
            }
        }
        
        var remainingBulls = self.bullsSegment.selectedSegmentIndex
        if remainingBulls > 0 {
            nullRound = false
            while currentPlayer.bulls < 3 && remainingBulls > 0 {
                currentPlayer.bulls += 1
                remainingBulls -= 1
            }
        }
        
        if nullRound {
            if currentPlayer.onFire {
                let alertController = UIAlertController(title: "2nd Null Round!", message: "<Insert Penalty Message here>", preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                self.presentViewController(alertController, animated: true, completion: { 
                    currentPlayer.onFire = false
                })
                
            } else {
                currentPlayer.onFire = true
            }
        } else {
            currentPlayer.onFire = false
        }
        
        for player in self.players {
            if player.name != currentPlayer.name {
                if player.fifteens < 3 {
                    player.score += remainingFifteens * 15
                }
                if player.sixteens < 3 {
                    player.score += remainingSixteens * 16
                }
                if player.seventeens < 3 {
                    player.score += remainingSeventeens * 17
                }
                if player.eightteens < 3 {
                    player.score += remainingEightteens * 18
                }
                if player.nineteens < 3 {
                    player.score += remainingNineteens * 19
                }
                if player.twenties < 3 {
                    player.score += remainingTwenties * 20
                }
                if player.bulls < 3 {
                    player.score += remainingBulls * 25
                }
            }
            
            //print("\(player.name) - score: \(player.score) - 15: \(player.fifteens) - 16: \(player.sixteens) - 17: \(player.seventeens) - 18: \(player.eightteens) - 19: \(player.nineteens) - 20: \(player.twenties) - B: \(player.bulls)")
        }
        
        self.collectionView.reloadData()
        
        // Check if current Player is leading and if he has finished the Game.
        let leadingPlayer = self.players.minElement { (player1: CricketPlayer, player2: CricketPlayer) -> Bool in
            return player1.score < player2.score
        }
        //print("leadingPlayer: \(leadingPlayer!.name)")
        
        if currentPlayer.finished && leadingPlayer == currentPlayer {
            // Current Player has finished the Game.
            let alertController = UIAlertController(title: "\(currentPlayer.name) wins!", message: "<Insert potential Penalty Message for all other Players here>", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "Game Over", style: .Destructive, handler: { (action: UIAlertAction) in
                for player in self.players {
                    player.resetPlayer()
                }
                self.navigationController?.popViewControllerAnimated(true)
            })
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            self.currentPlayerIndex = (self.currentPlayerIndex + 1) % self.players.count
            self.playerNameLabel.text = self.players[self.currentPlayerIndex].name
        }
        
        self.fifteensSegment.selectedSegmentIndex = 0
        self.sixteensSegment.selectedSegmentIndex = 0
        self.seventeensSegment.selectedSegmentIndex = 0
        self.eightteensSegment.selectedSegmentIndex = 0
        self.nineteensSegment.selectedSegmentIndex = 0
        self.twentiesSegment.selectedSegmentIndex = 0
        self.bullsSegment.selectedSegmentIndex = 0
    }
    
    
    // MARK: - Collection View
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.players.count * 8
        case 1:
            return self.players.count * 2
        default:
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.whiteColor()
        
        let label = cell.viewWithTag(1337) as! UILabel
        //label.text = self.players[indexPath.item % self.players.count].name
        let column = indexPath.item%self.players.count
        var row: Int
        if indexPath.item == 0 {
            row = 0
        } else {
            row = indexPath.item/self.players.count
        }
        //print("column: \(column) - row: \(row)")
        
        if indexPath.section == 0 {
            // Fifteens, Sixteens and so on...
            if indexPath.item < self.players.count {
                label.text = self.players[indexPath.item].name
                // "On Fire"
                if self.players[indexPath.item].onFire {
                    cell.backgroundColor = UIColor.redColor()
                } else {
                    cell.backgroundColor = UIColor.whiteColor()
                }
            } else {
                if row > 0 {
                    switch row {
                    case 1:
                        // Fifteens
                        label.text = "\(self.players[column].fifteens)"
                        let fifteens = self.players[column].fifteens
                        switch fifteens {
                        case 0:
                            cell.backgroundColor = UIColor.redColor()
                            break
                        case 1:
                            cell.backgroundColor = UIColor.orangeColor()
                            break
                        case 2:
                            cell.backgroundColor = UIColor.yellowColor()
                            break
                        case 3:
                            cell.backgroundColor = UIColor.greenColor()
                            break
                        default:
                            break
                        }
                    case 2:
                        // Sixteens
                        label.text = "\(self.players[column].sixteens)"
                        let sixteens = self.players[column].sixteens
                        switch sixteens {
                        case 0:
                            cell.backgroundColor = UIColor.redColor()
                            break
                        case 1:
                            cell.backgroundColor = UIColor.orangeColor()
                            break
                        case 2:
                            cell.backgroundColor = UIColor.yellowColor()
                            break
                        case 3:
                            cell.backgroundColor = UIColor.greenColor()
                            break
                        default:
                            break
                        }
                        break
                    case 3:
                        // Seventeens
                        label.text = "\(self.players[column].seventeens)"
                        let seventeens = self.players[column].seventeens
                        switch seventeens {
                        case 0:
                            cell.backgroundColor = UIColor.redColor()
                            break
                        case 1:
                            cell.backgroundColor = UIColor.orangeColor()
                            break
                        case 2:
                            cell.backgroundColor = UIColor.yellowColor()
                            break
                        case 3:
                            cell.backgroundColor = UIColor.greenColor()
                            break
                        default:
                            break
                        }
                        break
                    case 4:
                        // Eightteens
                        label.text = "\(self.players[column].eightteens)"
                        let eightteens = self.players[column].eightteens
                        switch eightteens {
                        case 0:
                            cell.backgroundColor = UIColor.redColor()
                            break
                        case 1:
                            cell.backgroundColor = UIColor.orangeColor()
                            break
                        case 2:
                            cell.backgroundColor = UIColor.yellowColor()
                            break
                        case 3:
                            cell.backgroundColor = UIColor.greenColor()
                            break
                        default:
                            break
                        }
                        break
                    case 5:
                        // Nineteens
                        label.text = "\(self.players[column].nineteens)"
                        let nineteens = self.players[column].nineteens
                        switch nineteens {
                        case 0:
                            cell.backgroundColor = UIColor.redColor()
                            break
                        case 1:
                            cell.backgroundColor = UIColor.orangeColor()
                            break
                        case 2:
                            cell.backgroundColor = UIColor.yellowColor()
                            break
                        case 3:
                            cell.backgroundColor = UIColor.greenColor()
                            break
                        default:
                            break
                        }
                        break
                    case 6:
                        // Twenties
                        label.text = "\(self.players[column].twenties)"
                        let twenties = self.players[column].twenties
                        switch twenties {
                        case 0:
                            cell.backgroundColor = UIColor.redColor()
                            break
                        case 1:
                            cell.backgroundColor = UIColor.orangeColor()
                            break
                        case 2:
                            cell.backgroundColor = UIColor.yellowColor()
                            break
                        case 3:
                            cell.backgroundColor = UIColor.greenColor()
                            break
                        default:
                            break
                        }
                        break
                    case 7:
                        // Bulls
                        label.text = "\(self.players[column].bulls)"
                        let bulls = self.players[column].bulls
                        switch bulls {
                        case 0:
                            cell.backgroundColor = UIColor.redColor()
                            break
                        case 1:
                            cell.backgroundColor = UIColor.orangeColor()
                            break
                        case 2:
                            cell.backgroundColor = UIColor.yellowColor()
                            break
                        case 3:
                            cell.backgroundColor = UIColor.greenColor()
                            break
                        default:
                            break
                        }
                        break
                    
                    default:
                        break
                    }
                } else {
                }
            }
            
        } else {
            // Score
            if row == 0 {
                label.text = self.players[column].name
            } else {
                label.text = "\(self.players[column].score)"
            }
        }
        
        return cell
    }
    
    // TO DO: "Revert Submit".

}
