//
//  TemperatureConverterViewController.swift
//  UCISwiftConverter
//
//  Created by Adam Cherochak on 2015/01/13.
//  Copyright (c) 2015 Adam Cherochak. All rights reserved.
//  Added to homework project 2015-04-08 Adam Cherochak
//  2015-04-20-1102 wk3
//

import UIKit

class TemperatureConverterViewController: UIViewController, UITextFieldDelegate {
    //2.i
    @IBOutlet weak var fahrenheitTextField: UITextField!
    @IBOutlet weak var celsiusTextField: UITextField!
//    //wk2 Challenge 1 & 2: call graph xib from temperature xib
//    @IBAction func btnShowGraph(sender: AnyObject) {
//        let graphViewController = FCCurvesViewController(nibName: "FCCurves", bundle: nil)
//        self.navigationController?.pushViewController(graphViewController, animated: false)
//    }
    
    //wk3-3.c
    var conversions: Array<AnyObject> = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //wk3-3.e
    func favoriteButtonPressed(sender: AnyObject) {
        // save the favorite instance here get the last favorite we prepped and store it
        if let data: NSData = NSUserDefaults.standardUserDefaults().objectForKey("FavoriteConversions") as? NSData {
            var savedFavorites: Array<AnyObject> = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Array
            if conversions.count > 0
            {
                savedFavorites.append(conversions.last!)
                let updatedFavorites = NSKeyedArchiver.archivedDataWithRootObject(savedFavorites)
                NSUserDefaults.standardUserDefaults().setValue(updatedFavorites, forKey: "FavoriteConversions")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //wk3-3.b create a favorite button
        let favoriteBarButton = UIBarButtonItem(image: UIImage(named: "favoritesButton_60x60"), style:
            UIBarButtonItemStyle.Plain, target: self, action: "favoriteButtonPressed:")
        self.navigationItem.rightBarButtonItem = favoriteBarButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //wk3-3.d
    func createConversionObject(inputValue: Double, inputUnits: String, outputValue: Double, outputUnits: String) {
        let favoriteConversion = Favorite(conversionType: "Temperature", inputValue: inputValue, inputUnits: inputUnits, outputValue: outputValue, outputUnits: outputUnits)
        conversions += [favoriteConversion]
    }
    
    func calculateCelsius(fahrenheitTemp: Double) -> String {
        var celsiusTemp = (fahrenheitTemp - 32) * 5 / 9
        self.createConversionObject(fahrenheitTemp, inputUnits: "ºF", outputValue: celsiusTemp, outputUnits: "ºC")
        return "\(celsiusTemp)"
    }
    
    func calculateFahrenheit(celsiusTemp: Double) -> String{
        var fahrenheitTemp = celsiusTemp * 9 / 5 + 32
        self.createConversionObject(celsiusTemp, inputUnits: "ºC", outputValue: fahrenheitTemp, outputUnits: "ºF")
        return "\(fahrenheitTemp)"
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        if textField == fahrenheitTextField {
            let fahrenheitTemp: Double = (fahrenheitTextField.text as NSString).doubleValue
            celsiusTextField.text = calculateCelsius(fahrenheitTemp)
        }
        else
        if textField == celsiusTextField {
            let celsiusTemp: Double = (celsiusTextField.text as NSString).doubleValue
            fahrenheitTextField.text = calculateFahrenheit(celsiusTemp)
        }
        textField.resignFirstResponder()
        return true
    }
}

