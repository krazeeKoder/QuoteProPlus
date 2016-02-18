//
//  MasterViewController.swift
//  QuoteProPlus
//
//  Created by Anthony Tulai on 2016-02-18.
//  Copyright © 2016 Anthony Tulai. All rights reserved.
//

import UIKit
import CoreData
import Graph

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    
    override func viewDidAppear(animated: Bool) {
        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserverForName("addQuote", object: nil, queue:
            NSOperationQueue.mainQueue()) { (NSNotification) -> Void in
                self.tableView.reloadData()
        }
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        self.presentViewController(NewQuotPicViewController(), animated: true, completion: nil)
    }
    
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let graph: Graph = Graph()
            let collection: Array<Entity> = graph.searchForEntity(types: ["Quote"])
            let currentQuote = collection[self.tableView.indexPathForSelectedRow!.row]
            let destinationViewController = segue.destinationViewController as! DetailViewController
            
            destinationViewController.mainImage = currentQuote["image"] as! UIImage
        }
    }
    
    // MARK: - Table View
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let graph: Graph = Graph()
        let collection: Array<Entity> = graph.searchForEntity(types: ["Quote"])
        return collection.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let graph: Graph = Graph()
        let collection: Array<Entity> = graph.searchForEntity(types: ["Quote"])
        let tableNewQuote = collection[indexPath.row]
        cell.imageView!.image = tableNewQuote["image"] as? UIImage
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let graph: Graph = Graph()
            let collection: Array<Entity> = graph.searchForEntity(types: ["Quote"])
            let quoteEntity = collection[indexPath.row]
            quoteEntity.delete()
            Graph().save()
            self.tableView.reloadData()
            
        }
        
    }
    
    
    /*
    // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
    // In the simplest, most efficient, case, reload the table view.
    self.tableView.reloadData()
    }
    */
    
}

