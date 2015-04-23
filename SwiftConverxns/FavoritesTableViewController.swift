//
//  FavoritesTableViewController.swift
//  SwiftConverxns
//
//  Created by Adam Cherochakon 4/20/15.
//  Copyright (c) 2015 Adam Cherochak. All rights reserved.
//  2015-04-20-1126 wk3
//  2015-04-23-1516 wk3 update
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    //wk3-4.c
    var favorites: Array<AnyObject> = []
    //wk3-4.c
    //wk3-4.d prepare cell for re-use
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
         self.title = "Favorites"
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //wk3-4.c wk3-4.d prepare cell for re-use
    override func viewWillAppear(animated: Bool) {
        if let data: NSData = NSUserDefaults.standardUserDefaults().objectForKey("FavoriteConversions") as? NSData {
            if var savedFavorites: Array<AnyObject> = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Array {
                self.favorites = savedFavorites
                self.tableView.reloadData() //wk3 update
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    //wk3-4.e provide datasource & configure cells to display user fav's
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    //wk3-4.e provide datasource & configure cells to display user fav's
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return favorites.count
    }
    //wk3-4.e provide datasource & configure cells to display user fav's
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        // Configure the cell...
        let favorite: Favorite = favorites[indexPath.row]as! Favorite
        cell.textLabel?.text = NSString(format: "%f%@ = %f%@", favorite.inputValue, favorite.inputUnits, favorite.outputValue, favorite.outputUnits) as String //Forced to use "as String" see page 27 of homework guide
        return cell
    }
}//END class FavoritesTableViewController
