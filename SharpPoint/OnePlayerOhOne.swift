//
//  OnePlayerOhOne.swift
//  SharpPoint
//
//  Created by Joshua O'Connor on 2/6/15.
//  Copyright (c) 2015 Joshua O'Connor. All rights reserved.
//

//Controls one player Oh One.

import UIKit

class OnePlayerOhOne: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    //Declaring variables.
    var secondpass301p1:String!
    var secondpass501p1:String!
    var secondpass701p1:String!
    
    //Populate the collection view with 301.
    var tableData: [String] = ["301" ]
    
    //Declare database variables.
    var databasePath = NSString()
    var defaults = NSUserDefaults.standardUserDefaults()
    
    
    //Outlets
    @IBOutlet weak var oologo: UIImageView!
    @IBOutlet weak var oogametype: UILabel!
    @IBOutlet weak var addscore: UIButton!
    @IBOutlet weak var deletescore: UIButton!
    @IBOutlet weak var newScore: UITextField!
    @IBOutlet weak var scoreboard: UICollectionView!
    
    
    //When add score button is pressed.
    @IBAction func addScore(sender: AnyObject) {
        
        //If there is no input, println "No score".
        if newScore.text == "" {
            println("No score")
        }
        //Otherwise, append the newScore to the tableData.
        else {
            tableData.append(newScore.text)
            println(tableData)
        
            //Reload collectionview.
            scoreboard.reloadData()
        
            //Scroll to bottom of collectionview automatically.
            var item = self.collectionView(self.scoreboard!, numberOfItemsInSection: 0) - 1
        
            var lastItemIndex = NSIndexPath(forItem: item, inSection: 0)
            self.scoreboard?.scrollToItemAtIndexPath(lastItemIndex, atScrollPosition: UICollectionViewScrollPosition.Top, animated: false)
        
            newScore.text = ""
            self.view.endEditing(true)
            
            deletescore.backgroundColor =  UIColorFromRGB("C60000")
            
    }
    }
    
    //When delete score button is pressed.
    @IBAction func deleteScore(sender: AnyObject) {
        
        //Error handling.
        if tableData.count > 0 {
        tableData.removeLast()
       
        println(tableData)
        
        //Reload Collection View.
            scoreboard.reloadData()}
        else{
            println("No more objects in this array!")
        }
        
    }
    
    
    //Hex color method.
    func UIColorFromRGB(colorCode: String, alpha: Float = 1.0) -> UIColor {
        var scanner = NSScanner(string:colorCode)
        var color:UInt32 = 0;
        scanner.scanHexInt(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
        let b = CGFloat(Float(Int(color) & mask)/255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }

    
    //When app is loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        //Set table data to game selection (301/501/701).
        if secondpass301p1 != nil {
        tableData[0] = secondpass301p1
        }
        
        if secondpass501p1 != nil {
        tableData[0] = secondpass501p1
        }
        
        if secondpass701p1 != nil {
        tableData[0] = secondpass701p1
        }

        //Print the variable being passed.
        println(secondpass301p1)
        println(secondpass501p1)
        println(secondpass701p1)
        
        //Add delegate to newScore.
        newScore.delegate = self
        
        //Set add score background color to Green, set delete score background color to red.
        addscore.backgroundColor =  UIColorFromRGB("00C12C")
        deletescore.backgroundColor =  UIColorFromRGB("C60000")
        
        //Style buttons.
        addscore.layer.cornerRadius = 5
        addscore.layer.borderWidth = 1
        addscore.layer.borderColor = UIColor.whiteColor().CGColor
        deletescore.layer.cornerRadius = 5


        
        //Database
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask,true)
        println(dirPaths)
        let docsDir = dirPaths[0] as! String
        //Set database to game.db
        databasePath = docsDir.stringByAppendingPathComponent("game.db")
        
        //If there is not a file in the database, create the database!
        if !filemgr.fileExistsAtPath(databasePath as String){
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
    
    
    //On begin editing text, change add score button color!
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        println("Begin Editing")
        //Change background colors of the buttons.
        addscore.backgroundColor =  UIColorFromRGB("C60000")
        deletescore.backgroundColor =  UIColorFromRGB("00C12C")
        
        //Change button border.
        deletescore.layer.borderWidth = 1
        deletescore.layer.borderColor = UIColor.whiteColor().CGColor
        addscore.layer.borderColor = UIColor.clearColor().CGColor
        
        return true
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
    //Resign responder.
    override func touchesBegan(touches: Set<NSObject>, withEvent event:UIEvent) {
        self.view.endEditing(true)
    }
    
    
    
    //End editing textfield.
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
        println("Done editing textfield!")
        addscore.backgroundColor =  UIColorFromRGB("00C12C")
        deletescore.backgroundColor =  UIColorFromRGB("C60000")
        newScore.text = ""

        //Change button border.
        addscore.layer.borderWidth = 1
        addscore.layer.borderColor = UIColor.whiteColor().CGColor
        deletescore.layer.borderColor = UIColor.clearColor().CGColor

        return true
        
    }
    
    //How many cells there are is equal to the amount of items in tableImages (.count property).
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableData.count
    }
    
    //Linking cell with CricketCell Class, linking image with tableImages array.
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: OhOneCell = collectionView.dequeueReusableCellWithReuseIdentifier("DataCell", forIndexPath: indexPath) as! OhOneCell
        
        cell.textFieldCell.text = tableData[indexPath.row]
        return cell
    }
    
    
    //When cell is selected.
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Cell selected")
    }
    
    //When game is saved.
    @IBAction func oosavegame(sender: AnyObject) {
        
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
            let insertSql = "Insert into GAME (PLAYERS, GAMETYPE, TABLEDATA, TIME) VALUES ('\(oologo.tag)','\(oogametype.text!)','\(tableStuff)','\(gameTime)')"
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

        }//Closed if contact open.
        else
        {
            println("Error: \(contactDB.lastErrorMessage())")
        }
    }
}