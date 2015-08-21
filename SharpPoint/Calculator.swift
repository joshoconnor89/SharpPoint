//
//  Calculator.swift
//  SharpPoint
//
//  Created by Joshua O'Connor on 2/3/15.
//  Copyright (c) 2015 Joshua O'Connor. All rights reserved.
//

//Calculator used to perform arithmetric in oh one games. 

import UIKit

class Calculator: UIViewController {
    
    //Outlet: Display Number (Calculator Screen)
    @IBOutlet weak var DisplayNumber: UILabel!
    
    //Store Variables
    var firstNumber: Double = 0
    var secondNumber: Double  = 0.0
    var operationsymbol = ""
    
    //Actions:
    
    //Number Tapped
    @IBAction func NumberTapped(sender: AnyObject) {
        
        var number = sender.currentTitle
        if DisplayNumber.text != "0" {
            DisplayNumber.text = DisplayNumber.text! + number!!
        }
        else
        {
            DisplayNumber.text = number!
        }
    }
    
    //All Clear
    @IBAction func AC(sender: AnyObject) {
        firstNumber = 0
        DisplayNumber.text = "0"
    }
    
    //Operations
    @IBAction func Operation(sender: AnyObject) {
        
        firstNumber = Double((DisplayNumber.text! as NSString).doubleValue)
        operationsymbol = sender.currentTitle!!
        DisplayNumber.text = "";
    }
    
    //PlusMinus
    @IBAction func PlusMinus(sender: AnyObject) {
        
        if DisplayNumber.text != "0" {
            firstNumber = Double((DisplayNumber.text! as NSString).doubleValue)
            var result = firstNumber * (-1)
            DisplayNumber.text =  "\(result)"
        }
        else
        {
            var result = firstNumber
            DisplayNumber.text =  "\(result)"
        }
    }
    
    //Percent
    @IBAction func Percentage(sender: AnyObject) {
        
        firstNumber = Double((DisplayNumber.text! as NSString).doubleValue)
        var result = firstNumber/100
        DisplayNumber.text =  "\(result)"
    }
    
    //Calculate (=)
    @IBAction func Calculate(sender: AnyObject) {
        
        secondNumber = Double((DisplayNumber.text! as NSString).doubleValue)
        var result:Double = 0
        
        //Divide
        if operationsymbol == "/" {
            
            result = firstNumber/secondNumber
            //way to make text a string
            DisplayNumber.text =  "\(result)"
        }
        
        
        //Add
        if operationsymbol == "+" {
            
            result = firstNumber+secondNumber
            //way to make text a string
            DisplayNumber.text =  "\(result)"
        }
        
        
        //Subtract
        if operationsymbol == "-" {
            
            result = firstNumber-secondNumber
            //way to make text a string
            DisplayNumber.text =  "\(result)"
        }
        
        //Multiply
        if operationsymbol == "x" {
            
            result = firstNumber*secondNumber
            //way to make text a string
            DisplayNumber.text =  "\(result)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
