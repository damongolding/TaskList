//
//  TaskListController.swift
//  codeData
//
//  Created by Damon on 19/04/2015.
//  Copyright (c) 2015 damongolding. All rights reserved.
//

import UIKit
import CoreData

protocol updateData{
    func addTask(task:String)
}

class TaskListController: UITableViewController, updateData {
    
    var tasks : Tasks
    var items : [NSManagedObject]?
    
    required init!(coder aDecoder: NSCoder!) {
        // We will be grabbing our data from CoreData here (at some point)
        self.tasks = Tasks(tasks: ["Get eggs"])
        
        // call super init
        super.init(coder: aDecoder)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // grab data deom CoreData
        getData()
        
        // Display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }


    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.tasks.taskList.count
    }
    
    // Configure each cell using task info
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // grab our prototype cell using its name "task"
        let cell = tableView.dequeueReusableCellWithIdentifier("task", forIndexPath: indexPath) as! TaskListCell
        
        // Set title using task data(title)
        cell.configureCell(self.tasks.taskList[indexPath.row])
        
        // return configured cell to view
        return cell
    }

    // set delegate so we can send info/data back
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var AddNewTask : NewTaskController = NewTaskController()
        AddNewTask = segue.destinationViewController as! NewTaskController
        AddNewTask.delegate = self
    }
    
    
    // called via delegate
    func addTask(task: String) {
        
        // add task to task list
        self.tasks.addTask(task) // add task to task list
        
        // insert into codedata here?
        saveData(task)

        
        // Reload view
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData() // reload view
        })
    }
    
    // func were we will save data to CoreData
    func saveData(title:String){
        // Retrieve the managed object context in the app delegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        // Add an item to the managed object context
        let entity = NSEntityDescription.entityForName("Task", inManagedObjectContext: managedContext)
        let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        // set the value for the item
        item.setValue(title, forKey: "taskTitle")
        
        // Save the managed object context back
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        // Add the new item to local items data source
        self.items!.append(item)
        println(self.items)
    }
    
    // where we will grab data(tasks) from CoreData
    func getData() {
        
        // Get the managed object context
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext!
        
        // Create a fetch request into Core Data
        let fetchRequest = NSFetchRequest(entityName: "Task")
        
        // Execute the fetch request
        var error: NSError?
        
        if let fetchedResults = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]?
        {
            // fetchedResults is not nil. update self.items
            self.items = fetchedResults
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
