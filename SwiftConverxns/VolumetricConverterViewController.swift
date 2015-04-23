//
//  VolumetricConverterViewController.swift
//  UCISwiftConverter
//
//  Created by Adam Cherochak on 2015/01/13.
//  Copyright (c) 2015 Adam Cherochak. All rights reserved.
//
//  Added to homework project 2015-04-09 Adam Cherochak
//  2015-04-20-1102 wk3
//

import UIKit

class VolumetricConverterViewController: UIViewController, UITextFieldDelegate {
    //2.i
    @IBOutlet weak var litersTextField: UITextField!
    @IBOutlet weak var gallonsTextField: UITextField!
    //wk3-Challenge-1
    var conversions: Array<AnyObject> = []
    // 2.e, 2.f
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
        let favoriteConversion = Favorite(conversionType: "Volumetric", inputValue: inputValue, inputUnits: inputUnits, outputValue: outputValue, outputUnits: outputUnits)
        conversions += [favoriteConversion]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func calculateLiters(gallonsTemp: Double) -> String {
        var litersTemp = gallonsTemp / 0.264
        self.createConversionObject(gallonsTemp, inputUnits: "gal", outputValue: litersTemp, outputUnits: "L")
        return "\(litersTemp)"
    }
    
    func calculateGallons(litersTemp: Double) -> String {
        var gallonsTemp = litersTemp / 0.264
        self.createConversionObject(litersTemp, inputUnits: "gal", outputValue: gallonsTemp, outputUnits: "L")
        return "\(gallonsTemp)"
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == gallonsTextField {
            let gallons: Double = (gallonsTextField.text as NSString).doubleValue
            litersTextField.text = calculateLiters(gallons)
        }
        else
        if textField == litersTextField {
            let liters: Double = (litersTextField.text as NSString).doubleValue
            gallonsTextField.text = calculateGallons(liters)
        }
        textField.resignFirstResponder()
        return true
    }
}//END class VolumetricConverterViewController

