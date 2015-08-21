//
//  TwoPlayerCricket.swift
//  SharpPoint
//
//  Created by Joshua O'Connor on 2/7/15.
//  Copyright (c) 2015 Joshua O'Connor. All rights reserved.
//


//Controls two player Cricket.

import UIKit

class TwoPlayerCricket: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //Database variables.
    var databasePath = NSString()
    var defaults = NSUserDefaults.standardUserDefaults()
    
    //Segue variable.
    var segueNumberId:Int = 0
    
    //Populate the collection view with images.
    var tableData: [String] = ["cricket1.png", "cricket1.png", "cricket1.png", "cricket1.png", "cricket1.png", "cricket1.png", "cricket1.png", "cricket1.png", "cricket1.png", "cricket1.png", "cricket1.png", "cricket1.png", "cricket1.png", "cricket1.png"]
    
    //Outlets.
    @IBOutlet weak var logo2: UIImageView!
    @IBOutlet weak var gametype2: UILabel!
    @IBOutlet weak var AddDelete2: UIImageView!
    
    //Gesture recognizer.
    let tap = UITapGestureRecognizer()
    
    //On load.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the image in the top right to a +.
        AddDelete2.image = UIImage(named: "plus.png")
        
        //Add gesture recognizer to image.
        tap.addTarget(self, action: "tappedView")
        AddDelete2.userInteractionEnabled = true
        AddDelete2.addGestureRecognizer(tap)
        
        //Database.
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask,true)
        println(dirPaths)
        let docsDir = dirPaths[0] as! String
        
        //Set database to game.db
        databasePath = docsDir.stringByAppendingPathComponent("game.db")
        if !filemgr.fileExistsAtPath(databasePath as String){
            //If there is not a file in the database, create the database!
            let contactDB = FMDatabase(path:databasePath as String)
            if contactDB == nil  {
                println("Error: \(contactDB.lastErrorMessage())")
            }
            if contactDB.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS GAME (ID INTEGER PRIMARY KEY AUTOINCREMENT, PLAYERS TEXT, GAMETYPE TEXT, TABLEDATA TEXT, TIME TEXT)"
                if !contactDB.executeStatements(sql_stmt) {
                    println("Error: \(contactDB.lastErrorMessage())")
                }
                contactDB.close()
            }
            else
            {
                println("Error: \(contactDB.lastErrorMessage())")
            }
        }
    }
    
    //When the Add/Minus image is selected (when action: "tappedView").
    func tappedView() {
        println("Add/Minus button selected")
        if AddDelete2.image == UIImage(named: "plus.png") {
            AddDelete2.image = UIImage (named: "minus.png")
        }
        else {
            AddDelete2.image = UIImage(named: "plus.png")
        }
    }
    
    //How many cells there are is equal to the amount of items in tableData (.count property).
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableData.count
    }
    
    
    //Linking cell with CricketCell Class, linking image with tableData array.
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CricketCell2 = collectionView.dequeueReusableCellWithReuseIdentifier("Cell2", forIndexPath: indexPath) as! CricketCell2
        cell.imgCell2.image = UIImage(named: tableData[indexPath.row])
        return cell
    }

    //When cell is selected.
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Cell selected")
        var cell = collectionView.cellForItemAtIndexPath(indexPath) as! CricketCell2
        
        //If the image is a plus (adding to scoreboard).
        if AddDelete2.image == UIImage(named: "plus.png") {
            
            let index = indexPath.row
            let firstImage = "cricket1.png"
            let secondImage = "cricket2.png"
            let thirdImage = "cricket3.png"
            let fourthImage = "cricket4.png"
            
            //cricket1.png -> cricket2.png
            if self.tableData[index] == firstImage  {
                var cell = collectionView.cellForItemAtIndexPath(indexPath) as! CricketCell2
                
                self.tableData[index] = secondImage
                cell.imgCell2.image = UIImage(named: secondImage)
                println(tableData)
                
            }
                
                //cricket2.png -> cricket3.png
            else if self.tableData[index] == secondImage  {
                var cell = collectionView.cellForItemAtIndexPath(indexPath) as! CricketCell2
                
                self.tableData[index] = thirdImage
                cell.imgCell2.image = UIImage(named: thirdImage)
                println(tableData)
                
            }
                
                //cricket3.png -> cricket4.png
            else {
                var cell = collectionView.cellForItemAtIndexPath(indexPath) as! CricketCell2
                
                self.tableData[index] = fourthImage
                cell.imgCell2.image = UIImage(named: fourthImage)
                println(tableData)
            }
        }
            
        //If the image is a minus (subtracting from scoreboard).
        else {
            
            let index = indexPath.row
            let firstImage = "cricket1.png"
            let secondImage = "cricket2.png"
            let thirdImage = "cricket3.png"
            let fourthImage = "cricket4.png"
            
            //cricket4.png -> cricket3.png
            if self.tableData[index] == fourthImage  {
                var cell = collectionView.cellForItemAtIndexPath(indexPath) as! CricketCell2
                
                self.tableData[index] = thirdImage
                cell.imgCell2.image = UIImage(named: thirdImage)
                println(tableData)
                
            }
                
                //cricket3.png -> cricket2.png
            else if self.tableData[index] == thirdImage  {
                var cell = collectionView.cellForItemAtIndexPath(indexPath) as! CricketCell2
                
                self.tableData[index] = secondImage
                cell.imgCell2.image = UIImage(named: secondImage)
                println(tableData)
                
            }
                
                //cricket2.png -> cricket1.png
            else {
                var cell = collectionView.cellForItemAtIndexPath(indexPath) as! CricketCell2
                
                self.tableData[index] = firstImage
                cell.imgCell2.image = UIImage(named: firstImage)
                println(tableData)
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //When game is saved.
    @IBAction func saveGame2(sender: AnyObject) {
        //For capturing the time.
        let now = NSDate()
        //Create date formatter, set to hours:minutes AM/PM.
        var formatter =  NSDateFormatter()
        formatter.dateFormat = "MM-dd-yyy HH:mm a"
        println(now);
        
        //Time is the variable in which we store.
        var gameTime = formatter.stringFromDate(now)
        println(gameTime)
        
        //Serializing the SQL data.
        let tableStuff = join(",", tableData)
        
        //Save information into game.db!
        let contactDB = FMDatabase(path:databasePath as String)
        if  contactDB.open() {
            let insertSql = "Insert into GAME (PLAYERS, GAMETYPE, TABLEDATA, TIME) VALUES ('\(logo2.tag)','\(gametype2.text!)','\(tableStuff)','\(gameTime)')"
            let result = contactDB.executeUpdate(insertSql, withArgumentsInArray:nil)
            if !result {
                
            }
               
            //When game is saved, create alert to let the user know it was saved!
            else
            {
                let alertView = UIAlertController(title: "Game Saved!", message: "Your game has been saved.", preferredStyle: .Alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                presentViewController(alertView, animated: true, completion: nil)
            }
            
        }
            
        //Closed if contact open.
        else
        {
            println("Error: \(contactDB.lastErrorMessage())")
        }
    }
}