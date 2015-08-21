//
//  ThreePlayerOhOne.swift
//  SharpPoint
//
//  Created by Joshua O'Connor on 2/6/15.
//  Copyright (c) 2015 Joshua O'Connor. All rights reserved.
//

//Controls three player Oh One.


import UIKit

class ThreePlayerOhOne: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    //Declaring variables.
    var secondpass301p3:String!
    var secondpass501p3:String!
    var secondpass701p3:String!
    
    //Populate the collection view with 301, 301.
    var tableData: [String] = ["301", "301", "301" ]
    
    //Declare database variables.
    var databasePath = NSString()
    var defaults = NSUserDefaults.standardUserDefaults()

    //Outlets
    @IBOutlet weak var addscore3: UIButton!
    @IBOutlet weak var deletescore3: UIButton!
    @IBOutlet weak var oologo3: UIImageView!
    @IBOutlet weak var oogametype3: UILabel!
    @IBOutlet weak var newScore3: UITextField!
    @IBOutlet weak var scoreboard3: UICollectionView!
    
    //When add score button is pressed.
    @IBAction func addScore3(sender: AnyObject) {
        
        //If there is no input, println "No score".
        if newScore3.text == "" {
            println("No score")
        }
            
        //Otherwise, append the newScore to the tableData.
        else {
            tableData.append(newScore3.text)
            println(tableData)
            
            //Reload collectionview.
            scoreboard3.reloadData()
            
            //Scroll to bottom of collectionview automatically.
            var item = self.collectionView(self.scoreboard3!, numberOfItemsInSection: 0) - 1
            
            var lastItemIndex = NSIndexPath(forItem: item, inSection: 0)
            self.scoreboard3?.scrollToItemAtIndexPath(lastItemIndex, atScrollPosition: UICollectionViewScrollPosition.Top, animated: false)
            newScore3.text = ""
            
            self.view.endEditing(true)
            
            deletescore3.backgroundColor =  UIColorFromRGB("C60000")
            
        }
    }
    
    //When delete score button is pressed.
    @IBAction func deleteScore3(sender: AnyObject) {
        
        //Error handling.
        if tableData.count > 0 {
            tableData.removeLast()
            
            println(tableData)
            
            //Reload Collection View.
            scoreboard3.reloadData()}
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
        println(secondpass301p3)
        println(secondpass501p3)
        println(secondpass701p3)
        
        //Set table data to game selection (301/501/701).
        if secondpass301p3 != nil {
            tableData[0] = secondpass301p3
            tableData[1] = secondpass301p3
            tableData[2] = secondpass301p3
        }
        
        if secondpass501p3 != nil {
            tableData[0] = secondpass501p3
            tableData[1] = secondpass501p3
            tableData[2] = secondpass501p3
        }
        
        if secondpass701p3 != nil {
            tableData[0] = secondpass701p3
            tableData[1] = secondpass701p3
            tableData[2] = secondpass701p3
        }

        //Style buttons.
        addscore3.layer.cornerRadius = 5
        addscore3.layer.borderWidth = 1
        addscore3.layer.borderColor = UIColor.whiteColor().CGColor
        deletescore3.layer.cornerRadius = 5
        
        //Add delegate to newScore.
        newScore3.delegate = self
        
        //Set add score background color to Green, set delete score background color to red.
        addscore3.backgroundColor =  UIColorFromRGB("00C12C")
        deletescore3.backgroundColor =  UIColorFromRGB("C60000")
        

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

        println("Begin Editing")
        addscore3.backgroundColor =  UIColorFromRGB("C60000")
        deletescore3.backgroundColor =  UIColorFromRGB("00C12C")
        
        //Change button border.
        deletescore3.layer.borderWidth = 1
        deletescore3.layer.borderColor = UIColor.whiteColor().CGColor
        addscore3.layer.borderColor = UIColor.clearColor().CGColor

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
        
        
        
        println("OOOH YEAH")
        addscore3.backgroundColor =  UIColorFromRGB("00C12C")
        deletescore3.backgroundColor =  UIColorFromRGB("C60000")
        newScore3.text = ""
        addscore3.layer.borderWidth = 1
        addscore3.layer.borderColor = UIColor.whiteColor().CGColor
        deletescore3.layer.borderColor = UIColor.clearColor().CGColor
        
        return true
        
    }
    
    
    
    //How many cells there are is equal to the amount of items in tableImages (.count property).
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableData.count
    }
    
    
    //Linking cell with CricketCell Class, linking image with tableImages array.
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: OhOneCell2 = collectionView.dequeueReusableCellWithReuseIdentifier("DataCell2", forIndexPath: indexPath) as! OhOneCell2
        
        cell.textFieldCell2.text = tableData[indexPath.row]
        
        return cell
    }
    
    
    //When cell is selected.
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Cell selected")
    }
    
    //When game is saved.
    @IBAction func oosavegame3(sender: AnyObject) {
        
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
            let insertSql = "Insert into GAME (PLAYERS, GAMETYPE, TABLEDATA, TIME) VALUES ('\(oologo3.tag)','\(oogametype3.text!)','\(tableStuff)','\(gameTime)')"
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