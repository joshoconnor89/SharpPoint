//
//  FourPlayerOhOne.swift
//  SharpPoint
//
//  Created by Joshua O'Connor on 2/6/15.
//  Copyright (c) 2015 Joshua O'Connor. All rights reserved.
//

//Controls four player Oh One.

import UIKit

class FourPlayerOhOne: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    //Declaring variables.
    var secondpass301p4:String!
    var secondpass501p4:String!
    var secondpass701p4:String!
    
    //Populate the collection view with 301.
    var tableData: [String] = ["301", "301", "301", "301"]
    
    //Declare database variables.
    var databasePath = NSString()
    var defaults = NSUserDefaults.standardUserDefaults()
    
    //Outlets
    @IBOutlet weak var oologo4: UIImageView!
    @IBOutlet weak var oogametype4: UILabel!
    @IBOutlet weak var addscore4: UIButton!
    @IBOutlet weak var deletescore4: UIButton!
    @IBOutlet weak var newScore4: UITextField!
    @IBOutlet weak var scoreboard4: UICollectionView!
    

    //When add score button is pressed.
    @IBAction func addScore4(sender: AnyObject) {
        
        //If there is no input, println "No score".
        if newScore4.text == "" {
            println("No score")
        }
            
        //Otherwise, append the newScore to the tableData.
        else {
            
            tableData.append(newScore4.text)
            println(tableData)
            
            //Reload collectionview.
            scoreboard4.reloadData()
            
            //Scroll to bottom of collectionview automatically.
            var item = self.collectionView(self.scoreboard4!, numberOfItemsInSection: 0) - 1
            
            var lastItemIndex = NSIndexPath(forItem: item, inSection: 0)
            self.scoreboard4?.scrollToItemAtIndexPath(lastItemIndex, atScrollPosition: UICollectionViewScrollPosition.Top, animated: false)
            
            newScore4.text = ""
            self.view.endEditing(true)
            
            deletescore4.backgroundColor =  UIColorFromRGB("C60000")
        }
        
    }
    
    //When delete score button is pressed.
    @IBAction func deleteScore4(sender: AnyObject) {
        
        //if statement is error handling
        if tableData.count > 0 {
            tableData.removeLast()
            
            println(tableData)
            
            //NEED TO RELOAD COLLECTIONVIEW
            scoreboard4.reloadData()}
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
        
        //Print the variable being passed.
        println(secondpass301p4)
        println(secondpass501p4)
        println(secondpass701p4)
        
        //Set table data to game selection (301/501/701).
        if secondpass301p4 != nil {
            tableData[0] = secondpass301p4
            tableData[1] = secondpass301p4
            tableData[2] = secondpass301p4
            tableData[3] = secondpass301p4
        }
        
        if secondpass501p4 != nil {
            tableData[0] = secondpass501p4
            tableData[1] = secondpass501p4
            tableData[2] = secondpass501p4
            tableData[3] = secondpass501p4
        }
        
        if secondpass701p4 != nil {
            tableData[0] = secondpass701p4
            tableData[1] = secondpass701p4
            tableData[2] = secondpass701p4
            tableData[3] = secondpass701p4
        }

        //Style buttons.
        addscore4.layer.cornerRadius = 5
        addscore4.layer.borderWidth = 1
        addscore4.layer.borderColor = UIColor.whiteColor().CGColor
        deletescore4.layer.cornerRadius = 5

        //Add delegate to newScore.
        newScore4.delegate = self
        
        //Set add score background color to Green, set delete score background color to red.
        addscore4.backgroundColor =  UIColorFromRGB("00C12C")
        deletescore4.backgroundColor =  UIColorFromRGB("C60000")

        //Database
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask,true)
        println(dirPaths)
        let docsDir = dirPaths[0] as! String
        //Set database to game.db
        databasePath = docsDir.stringByAppendingPathComponent("game.db")
        
        //if there is not a file in the database, create the database!
        if !filemgr.fileExistsAtPath(databasePath as String){
            //if no, we need to create the db
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
            }//closes out the condition if !filemgr
            else
            {
                println("Error: \(contactDB.lastErrorMessage())")
            }
            
        }

    }
    
    
    //On begin editing text, change add score button color!
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {

        
        println("Begin Editing")
        addscore4.backgroundColor =  UIColorFromRGB("C60000")
        deletescore4.backgroundColor =  UIColorFromRGB("00C12C")
        
        //Change button border.
        deletescore4.layer.borderWidth = 1
        deletescore4.layer.borderColor = UIColor.whiteColor().CGColor
        addscore4.layer.borderColor = UIColor.clearColor().CGColor
        
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
        addscore4.backgroundColor =  UIColorFromRGB("00C12C")
        deletescore4.backgroundColor =  UIColorFromRGB("C60000")
        newScore4.text = ""
        
        //Change button border.
        addscore4.layer.borderWidth = 1
        addscore4.layer.borderColor = UIColor.whiteColor().CGColor
        deletescore4.layer.borderColor = UIColor.clearColor().CGColor
        
        return true
        
    }
    
    
    
    
    //How many cells there are is equal to the amount of items in tableImages (.count property).
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableData.count
    }
    
    
    //Linking cell with CricketCell Class, linking image with tableImages array.
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: OhOneCell3 = collectionView.dequeueReusableCellWithReuseIdentifier("DataCell3", forIndexPath: indexPath) as! OhOneCell3
        
        cell.textFieldCell3.text = tableData[indexPath.row]
        
        return cell
    }
    
    
    //When cell is selected.
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Cell selected")
    }
    
    //When game is saved.
    @IBAction func oosavegame4(sender: AnyObject) {
        
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
            let insertSql = "Insert into GAME (PLAYERS, GAMETYPE, TABLEDATA, TIME) VALUES ('\(oologo4.tag)','\(oogametype4.text!)','\(tableStuff)','\(gameTime)')"
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