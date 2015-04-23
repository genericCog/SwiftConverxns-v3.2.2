//
//  TemperatureConverterViewController.swift
//  UCISwiftConverter
//
//  Created by justin on 2015/01/13.
//  Copyright (c) 2015年 Justin. All rights reserved.
//

import UIKit

class TemperatureConverterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var fahrenheitTextField: UITextField!
    
    @IBOutlet weak var celsiusTextField: UITextField!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func calculateCelsius(fahrenheitTemp: Double) -> String
    {
        
        return "\((fahrenheitTemp - 32) * 5 / 9)"
        
    }
    
    func calculateFahrenheit(celsiusTemp: Double) -> String
    {
        
        return "\(celsiusTemp * 9 / 5 + 32)"
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        
        if textField == fahrenheitTextField
        {
            
            let fahrenheitTemp: Double = (fahrenheitTextField.text as NSString).doubleValue
            
            celsiusTextField.text = calculateCelsius(fahrenheitTemp)
            
        }
        else
        if textField == celsiusTextField
        {
            
            let celsiusTemp: Double = (celsiusTextField.text as NSString).doubleValue
            
            fahrenheitTextField.text = calculateFahrenheit(celsiusTemp)
            
        }
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
}

