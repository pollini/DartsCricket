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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
    }
    
    // MARK: - Collection View
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.players.count * 7
        case 1:
            return self.players.count
        default:
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        
        let label = cell.viewWithTag(1337) as! UILabel
        //label.text = self.players[indexPath.item % self.players.count].name
        if indexPath.item < self.players.count {
            label.text = self.players[indexPath.item].name
        } else {
            label.text = ""
        }
        
        return cell
    }
    

}
