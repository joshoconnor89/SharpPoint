//
//  TwoPlayerOhOne.swift
//  SharpPoint
//
//  Created by Joshua O'Connor on 2/6/15.
//  Copyright (c) 2015 Joshua O'Connor. All rights reserved.
//

//Controls two player Oh One.


import UIKit

class TwoPlayerOhOne: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    //Declaring variables.
    var secondpass301p2:String!
    var secondpass501p2:String!
    var secondpass701p2:String!
    
    //Populate the collection view with 301, 301.
    var tableData: [String] = ["301", "301"]
    
    //Declare database variables.
    var databasePath = NSString()
    var defaults = NSUserDefaults.standardUserDefaults()
    
    //Outlets
    @IBOutlet weak var deletescore2: UIButton!
    @IBOutlet weak var addscore2: UIButton!
    @IBOutlet weak var oogametype2: UILabel!
    @IBOutlet weak var oologo2: UIImageView!
    @IBOutlet weak var scoreboard2: UICollectionView!
    @IBOutlet weak var newScore2: UITextField!
    
    //When add score button is pressed.
    @IBAction func addScore2(sender: AnyObject) {
        
        //If there is no input, println "No score".
        if newScore2.text == "" {
            println("No score")
        }
            
        //Otherwise, append the newScore to the tableData.
        else {
            tableData.append(newScore2.text)
            println(tableData)
            
            //Reload collectionview.
            scoreboard2.reloadData()
            
            //Scroll to bottom of collectionview automatically.
            var item = self.collectionView(self.scoreboard2!, numberOfItemsInSection: 0) - 1
            
            var lastItemIndex = NSIndexPath(forItem: item, inSection: 0)
            self.scoreboard2?.scrollToItemAtIndexPath(lastItemIndex, atScrollPosition: UICollectionViewScrollPosition.Top, animated: false)
            newScore2.text = ""
            self.view.endEditing(true)
            deletescore2.backgroundColor =  UIColorFromRGB("C60000")
            
        }
    }
    
    //When delete score button is pressed.
    @IBAction func deleteScore2(sender: AnyObject) {
        
        //Error handling.
        if tableData.count > 0 {
            tableData.removeLast()
            
            println(tableData)
            
            //Reload Collection View.
            scoreboard2.reloadData()}
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
        println(secondpass301p2)
        println(secondpass501p2)
        println(secondpass701p2)
        
        //Set table data to game selection (301/501/701).
        if secondpass301p2 != nil {
            tableData[0] = secondpass301p2
            tableData[1] = secondpass301p2
        }
        
        if secondpass501p2 != nil {
            tableData[0] = secondpass501p2
            tableData[1] = secondpass501p2
        }
        
        if secondpass701p2 != nil {
            tableData[0] = secondpass701p2
            tableData[1] = secondpass701p2
        }

        //Style buttons.
        addscore2.layer.cornerRadius = 5
        addscore2.layer.borderWidth = 1
        addscore2.layer.borderColor = UIColor.whiteColor().CGColor
        deletescore2.layer.cornerRadius = 5
        
        //Add delegate to newScore.
        newScore2.delegate = self
        
        //Set add score background color to Green, set delete score background color to red.
        addscore2.backgroundColor =  UIColorFromRGB("00C12C")
        deletescore2.backgroundColor =  UIColorFromRGB("C60000")
        
        
        //Database
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask,true)
        println(dirPaths)
        let docsDir = dirPaths[0] as! String
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
            }
            else
            {
                println("Error: \(contactDB.lastErrorMessage())")
            }
            
        }

        
    }
    
    //On begin editing text, change add score button color!
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        //self.textFieldCell.resignFirstResponder()
        
        
        println("Begin Editing")
        //Change background colors of the buttons.
        addscore2.backgroundColor =  UIColorFromRGB("C60000")
        deletescore2.backgroundColor =  UIColorFromRGB("00C12C")
        
        //Change button border.
        deletescore2.layer.borderWidth = 1
        deletescore2.layer.borderColor = UIColor.whiteColor().CGColor
        addscore2.layer.borderColor = UIColor.clearColor().CGColor
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
        addscore2.backgroundColor =  UIColorFromRGB("00C12C")
        deletescore2.backgroundColor =  UIColorFromRGB("C60000")
        newScore2.text = ""
        
        //Change button border.
        addscore2.layer.borderWidth = 1
        addscore2.layer.borderColor = UIColor.whiteColor().CGColor
        deletescore2.layer.borderColor = UIColor.clearColor().CGColor

        return true
        
    }
    
    //How many cells there are is equal to the amount of items in tableImages (.count property).
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableData.count
    }
    
    //Linking cell with CricketCell Class, linking image with tableImages array.
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: OhOneCell1 = collectionView.dequeueReusableCellWithReuseIdentifier("DataCell1", forIndexPath: indexPath) as! OhOneCell1
    
        cell.textFieldCell1.text = tableData[indexPath.row]
        return cell
    }
    
    
    //When cell is selected.
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Cell selected")
    }
    
    //When game is saved.
    @IBAction func oosavegame2(sender: AnyObject) {
        
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
            let insertSql = "Insert into GAME (PLAYERS, GAMETYPE, TABLEDATA, TIME) VALUES ('\(oologo2.tag)','\(oogametype2.text!)','\(tableStuff)','\(gameTime)')"
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