//
//  SavedGames.swift
//  SharpPoint
//
//  Created by Joshua O'Connor on 2/6/15.
//  Copyright (c) 2015 Joshua O'Connor. All rights reserved.
//

// This class handles the saved games screen, which will have a list of all the games that have been saved.  When the user clicks the saved game, it will bring up their game and where they left off.

import UIKit

class SavedGames: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Declaring variables.
    var gameGAMEID:[String] = []
    var gameGAMETYPE:[String] = []
    var gameGAMEPLAYERS:[String] = []
    var gameGAMETABLEDATA: [String] = []
    var gameGAMETIME: [String] = []
    
    //On load.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Database.
        var databasePath = NSString()
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask,true)
        let docsDir = dirPaths[0] as! String
        
        //Set database to game.db
        databasePath = docsDir.stringByAppendingPathComponent("game.db")
        let gamesDB = FMDatabase(path:databasePath as! String)
        
        //Read database if gameDB is open
        if  gamesDB.open() {
            var savedGames = "select PLAYERS, GAMETYPE, ID, TABLEDATA, TIME from GAME ORDER BY TIME DESC"
            let results:FMResultSet? = gamesDB.executeQuery(savedGames, withArgumentsInArray:nil)
            
            while results?.next() == true {
                gameGAMEPLAYERS.append(results!.stringForColumn("PLAYERS"))
                gameGAMETYPE.append(results!.stringForColumn("GAMETYPE"))
                gameGAMEID.append(results!.stringForColumn("ID"))
                gameGAMETABLEDATA.append(results!.stringForColumn("TABLEDATA"))
                gameGAMETIME.append(results!.stringForColumn("TIME"))
                println(gameGAMETABLEDATA)
            }
        }
        
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameGAMEPLAYERS.count
    }
    
    //Setting up the table cell with reusable identifier, "GameCell".
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath) as! SavedGameCell
        
        // Configure the cell...
        //Game ID Cell = gameGAMEID array
        let gameIDcell = gameGAMETIME[indexPath.row]
        cell.gameid.text = gameIDcell
        
        //Game GAMETYPE Cell = gameGAMETYPE array
        let gameGAMETYPEcell = gameGAMETYPE[indexPath.row]
        cell.gametype.text = gameGAMETYPEcell
        
        //Game PLAYERS Cell = gamePLAYERS array
        let gamePLAYERScell = gameGAMEPLAYERS[indexPath.row]
        cell.gameplayers.text = gamePLAYERScell
        
        return cell
    }
    

    //Delete Row, uncomment if you want to add this feature.  Also need to uncomment edit button above (line 55)
    /*
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
        if editingStyle == UITableViewCellEditingStyle.Delete {
    
            gameGAMEID.removeAtIndex(indexPath.row)
            gameGAMETYPE.removeAtIndex(indexPath.row)
            gameGAMEPLAYERS.removeAtIndex(indexPath.row)
            gameGAMETABLEDATA.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    */
    
    //Go back button (top left corner).
    func goBack() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //When row is selected.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("TAPPED")
        // Handle social cell selection to toggle checkmark
        //if(indexPath.section == 1 && indexPath.row == 0) {
        
        let index = indexPath.row
        
        println("ID = " + gameGAMEID[index])
        println("GAMETYPE = " + gameGAMETYPE[index])
        println("PLAYERS = " + gameGAMEPLAYERS[index])
        println("TABLEDATA = " + gameGAMETABLEDATA[index])
        

        
    //Load Cricket games!
        
        //Load OnePlayerCricket.swift view controller.
        if gameGAMETYPE[index] == "Cricket" && gameGAMEPLAYERS[index] == "1" {
            
            println("LOAD ONE PLAYER CRICKET")

            //Instantiate view controller using Storyboard Identifier.
            if let resultController = storyboard!.instantiateViewControllerWithIdentifier("OnePlayerCricketVC") as? OnePlayerCricket {
                
                //Creating a navigation controller with resultController at the root of the navigation stack.
                let navController = UINavigationController(rootViewController: resultController)
                self.presentViewController(navController, animated:true, completion: nil)
                
                //Serialize.
                let tableStuff1 = split(gameGAMETABLEDATA[index]) { $0 == "," }
                
                //Print SQL value to console.
                println(tableStuff1)
                
                //Replace tableData (default data when loaded) with TABLEDATA (from SQL database).
                resultController.tableData = tableStuff1
                
            }
        }
        
        //Load TwoPlayerCricket.swift view controller.
        if gameGAMETYPE[index] == "Cricket" && gameGAMEPLAYERS[index] == "2" {
            
            println("LOAD TWO PLAYER CRICKET")
            
            //Instantiate view controller using Storyboard Identifier.
            if let resultController = storyboard!.instantiateViewControllerWithIdentifier("TwoPlayerCricketVC") as? TwoPlayerCricket {
                
                //Go back button.
                resultController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "goBack")
                
                //Creating a navigation controller with resultController at the root of the navigation stack.
                let navController = UINavigationController(rootViewController: resultController)
                self.presentViewController(navController, animated:true, completion: nil)
                
                //Serialize.
                let tableStuff = split(gameGAMETABLEDATA[index]) { $0 == "," }
                
                //Print SQL value to console.
                println(tableStuff)
                
                //Replace tableData (default data when loaded) with TABLEDATA (from SQL database).
                resultController.tableData = tableStuff
            }
        }
        
        //Load ThreePlayerCricket.swift view controller.
        if gameGAMETYPE[index] == "Cricket" && gameGAMEPLAYERS[index] == "3" {
            
            println("LOAD THREE PLAYER CRICKET")
            
            //Instantiate view controller using Storyboard Identifier.
            if let resultController = storyboard!.instantiateViewControllerWithIdentifier("ThreePlayerCricketVC") as? ThreePlayerCricket {
                
                //Go back button.
                resultController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "goBack")
                
                //Creating a navigation controller with resultController at the root of the navigation stack.
                let navController = UINavigationController(rootViewController: resultController)
                self.presentViewController(navController, animated:true, completion: nil)
                
                //Serialize.
                let tableStuff = split(gameGAMETABLEDATA[index]) { $0 == "," }
                
                //Print SQL value to console.
                println(tableStuff)
                
                //Replace tableData (default data when loaded) with TABLEDATA (from SQL database).
                resultController.tableData = tableStuff
            }
        }
        
        //Load FourPlayerCricket.swift view controller.
        if gameGAMETYPE[index] == "Cricket" && gameGAMEPLAYERS[index] == "4" {
            
            println("LOAD FOUR PLAYER CRICKET")
            
            //Instantiate view controller using Storyboard Identifier.
            if let resultController = storyboard!.instantiateViewControllerWithIdentifier("FourPlayerCricketVC") as? FourPlayerCricket {
                
                //Go back button.
                resultController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "goBack")
                
                //Creating a navigation controller with resultController at the root of the navigation stack.
                let navController = UINavigationController(rootViewController: resultController)
                self.presentViewController(navController, animated:true, completion: nil)
                
                //Serialize.
                let tableStuff = split(gameGAMETABLEDATA[index]) { $0 == "," }
                
                //Print SQL value to console.
                println(tableStuff)
                
                //Replace tableData (default data when loaded) with TABLEDATA (from SQL database).
                resultController.tableData = tableStuff
            }
        }
        
        
    //Load Oh One Games!
        
        //Load OnePlayerOhOne.swift view controller.
        if gameGAMETYPE[index] == "Oh One" && gameGAMEPLAYERS[index] == "1" {
            
            println("LOAD ONE PLAYER OH ONE")
            
            //Instantiate view controller using Storyboard Identifier.
            if let resultController = storyboard!.instantiateViewControllerWithIdentifier("OnePlayerOhOneVC") as? OnePlayerOhOne {
                
                //Go back button.
                resultController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "goBack")
                
                //Creating a navigation controller with resultController at the root of the navigation stack.
                let navController = UINavigationController(rootViewController: resultController)
                self.presentViewController(navController, animated:true, completion: nil)
                
                //Serialize.
                let tableStuff = split(gameGAMETABLEDATA[index]) { $0 == "," }
                
                //Print SQL value to console.
                println(tableStuff)
                
                //Replace tableData (default data when loaded) with TABLEDATA (from SQL database).
                resultController.tableData = tableStuff
            }
        }
        
        //Load TwoPlayerOhOne.swift view controller.
        if gameGAMETYPE[index] == "Oh One" && gameGAMEPLAYERS[index] == "2" {
            
            println("LOAD TWO PLAYER OH ONE")
            
            //Instantiate view controller using Storyboard Identifier.
            if let resultController = storyboard!.instantiateViewControllerWithIdentifier("TwoPlayerOhOneVC") as? TwoPlayerOhOne {
                
                //Go back button.
                resultController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "goBack")
                
                //Creating a navigation controller with resultController at the root of the navigation stack.
                let navController = UINavigationController(rootViewController: resultController)
                self.presentViewController(navController, animated:true, completion: nil)
                
                //Serialize.
                let tableStuff = split(gameGAMETABLEDATA[index]) { $0 == "," }
                
                //Print SQL value to console.
                println(tableStuff)
                
                //Replace tableData (default data when loaded) with TABLEDATA (from SQL database).
                resultController.tableData = tableStuff
            }
        }
        
        //Load ThreePlayerOhOne.swift view controller.
        if gameGAMETYPE[index] == "Oh One" && gameGAMEPLAYERS[index] == "3" {
            
            println("LOAD THREE PLAYER OH ONE")
            
            //Instantiate view controller using Storyboard Identifier.
            if let resultController = storyboard!.instantiateViewControllerWithIdentifier("ThreePlayerOhOneVC") as? ThreePlayerOhOne {
                
                //Go back button.
                resultController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "goBack")
                
                //Creating a navigation controller with resultController at the root of the navigation stack.
                let navController = UINavigationController(rootViewController: resultController)
                self.presentViewController(navController, animated:true, completion: nil)
                
                //Serialize.
                let tableStuff = split(gameGAMETABLEDATA[index]) { $0 == "," }
                
                //Print SQL value to console.
                println(tableStuff)
                
                //Replace tableData (default data when loaded) with TABLEDATA (from SQL database).
                resultController.tableData = tableStuff
                
                
                
            }
        }
        
        //Load FourPlayerOhOne.swift view controller.
        if gameGAMETYPE[index] == "Oh One" && gameGAMEPLAYERS[index] == "4" {
            
            println("LOAD FOUR PLAYER OH ONE")
           
            //Instantiate view controller using Storyboard Identifier.
            if let resultController = storyboard!.instantiateViewControllerWithIdentifier("FourPlayerOhOneVC") as? FourPlayerOhOne {
                
                //Go back button.
                resultController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "goBack")
                
                // Creating a navigation controller with resultController at the root of the navigation stack.
                let navController = UINavigationController(rootViewController: resultController)
                self.presentViewController(navController, animated:true, completion: nil)
                
                //Serialize.
                let tableStuff = split(gameGAMETABLEDATA[index]) { $0 == "," }
                
                //Print SQL value to console.
                println(tableStuff)
                
                //Replace tableData (default data when loaded) with TABLEDATA (from SQL database).
                resultController.tableData = tableStuff
            }
        }
        
    }
}