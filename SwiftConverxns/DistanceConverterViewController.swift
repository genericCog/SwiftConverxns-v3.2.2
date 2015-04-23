//
//  DistanceConverterViewController.swift
//  UCISwiftConverter
//
//  Created by Adam Cherochak on 2015/01/13.
//  Copyright (c) 2015 Adam Cherochak. All rights reserved.
//  Added to homework project 2015-04-08 Adam Cherochak
//  2015-04-20-1102 wk3
//

import UIKit

class DistanceConverterViewController: UIViewController, UITextFieldDelegate {
    //2.i
    @IBOutlet weak var milesTextField: UITextField!
    @IBOutlet weak var kilometersTextField: UITextField!
    //wk3-Challenge-1
    var conversions: Array<AnyObject> = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //wk3-Challenge-1
    func favoriteButtonPressed(sender: AnyObject) {
        // save the fvorite instance here. get the last fav we prepped & store it
        if let data: NSData = NSUserDefaults.standardUserDefaults().objectForKey("FavoriteConversions") as? NSData {
            var savedFavorites: Array<AnyObject> = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Array
            if conversions.count > 0 {
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
        let favoriteBarButton = UIBarButtonItem(image: UIImage(named: "favoritesButton_60x60"),style: UIBarButtonItemStyle.Plain, target: self, action: "favoriteButtonPressed:")
        self.navigationItem.rightBarButtonItem = favoriteBarButton
    }
    
    //wk3-3.d
    func createConversionObject(inputValue: Double, inputUnits: String, outputValue: Double, outputUnits: String) {
        let favoriteConversion = Favorite(conversionType: "Distance", inputValue: inputValue, inputUnits: inputUnits, outputValue: outputValue, outputUnits: outputUnits)
        conversions += [favoriteConversion]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // convert km to mi
    func calculateMiles(kilometersTemp: Double) -> String {
        var milesTemp = kilometersTemp * 0.62137
        self.createConversionObject(kilometersTemp, inputUnits: "km", outputValue: milesTemp, outputUnits: "mi")
        return "\(milesTemp)"
    }
    // convert mi to km
    func calculateKilometers(milesTemp: Double) -> String {
        var kilometersTemp = milesTemp * 0.62137
        self.createConversionObject(milesTemp, inputUnits: "mi", outputValue: kilometersTemp, outputUnits: "km")
        return "\(kilometersTemp)"
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == kilometersTextField {
            let kilometers: Double = (kilometersTextField.text as NSString).doubleValue
            milesTextField.text = calculateMiles(kilometers)
        }
        else
        if textField == milesTextField {
            let miles: Double = (milesTextField.text as NSString).doubleValue
            kilometersTextField.text = calculateKilometers(miles)
        }
        
        textField.resignFirstResponder()
        return true
    }
}//END class DistanceConverterViewController

