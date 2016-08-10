//
//  NewGameTableViewController.swift
//  Darts Cricket
//
//  Created by Marius on 10.08.16.
//  Copyright © 2016 MVP Systems. All rights reserved.
//

import UIKit

class NewGameTableViewController: UITableViewController {

    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var doneBarButtonItem: UIBarButtonItem!
    
    //var players: [CricketPlayer] = [CricketPlayer(name: "PR"), CricketPlayer(name: "SH"), CricketPlayer(name: "P"), CricketPlayer(name: "MVP"), CricketPlayer(name: "MM")]
    var players: [CricketPlayer] = []
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(NewGameTableViewController.handleLongPress))
        self.tableView.addGestureRecognizer(longPressRecognizer)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        let label = cell.viewWithTag(1337) as! UILabel
        label.text = self.players[indexPath.row].name
        label.sizeToFit()

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            self.players.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let movedPlayer = self.players[fromIndexPath.row]
        
        self.players.removeAtIndex(fromIndexPath.row)
        self.players.insert(movedPlayer, atIndex: toIndexPath.row)
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alertController = UIAlertController(title: "Change Username", message: nil, preferredStyle: .Alert)
        
        let changeAction = UIAlertAction(title: "Change", style: .Default) { (action: UIAlertAction) in
            let textField = alertController.textFields![0]
            self.players[indexPath.row].name = textField.text!
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField) in
            textField.text = self.players[indexPath.row].name
            NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: textField, queue: NSOperationQueue.mainQueue(), usingBlock: { (note: NSNotification) in
                changeAction.enabled = !(textField.text == "")
            })
        }
        
        alertController.addAction(changeAction)
        
        let defaultAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "pushToGameVC" {
            let gameViewController = segue.destinationViewController as! GameViewController
            gameViewController.players = self.players
        }
    }
    
    
    @IBAction func addPlayer(sender: AnyObject) {
        let alertController = UIAlertController(title: "Add new Player", message: "Please enter a Name", preferredStyle: .Alert)
        
        let addAction = UIAlertAction(title: "Add", style: .Default) { (action: UIAlertAction) in
            let textField = alertController.textFields![0]
            
            let newPlayer = CricketPlayer(name: textField.text!)
            self.players.append(newPlayer)
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Fade)
            
        }
        addAction.enabled = false
        
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField) in
            textField.placeholder = "Name"
            NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: textField, queue: NSOperationQueue.mainQueue(), usingBlock: { (note: NSNotification) in
                addAction.enabled = !(textField.text == "")
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.addAction(addAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    @IBAction func doneButtonPressed(sender: AnyObject) {
        if self.players.count > 1 {
            self.performSegueWithIdentifier("pushToGameVC", sender: sender)
            
        } else {
            let alertController = UIAlertController(title: "Not enough Players", message: "Please add at least two Players.", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Action for Long Press Gesture Recognizer
    func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .Ended {
            if self.tableView.editing {
                self.tableView.setEditing(false, animated: true)
            } else {
                self.tableView.setEditing(true, animated: true)
                if self.tapGestureRecognizer == nil {
                    self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewGameTableViewController.handleTap))
                }
                self.tableView.addGestureRecognizer(self.tapGestureRecognizer!)
            }
        }
    }
    
    // MARK: - Action for Tap Gesture Recognizer
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            if self.tableView.editing {
                self.tableView.setEditing(false, animated: true)
                self.tableView.removeGestureRecognizer(self.tapGestureRecognizer!)
            }
        }
    }
}
