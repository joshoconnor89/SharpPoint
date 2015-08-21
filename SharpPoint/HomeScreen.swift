//
//  ViewController.swift
//  SharpPoint
//
//  Created by Joshua O'Connor on 2/3/15.
//  Copyright (c) 2015 Joshua O'Connor. All rights reserved.
//

//Controls home screen, which is loaded when app first starts.


import UIKit

class HomeScreen: UIViewController {

    //Outlet.
    @IBOutlet weak var cricketgame: UIButton!
    var databasePath = NSString()
    
    //On load.
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //Action.
    @IBAction func saveCricket(sender: AnyObject) {
        
}

}