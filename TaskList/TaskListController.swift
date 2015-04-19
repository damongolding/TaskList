//
//  TaskListController.swift
//  codeData
//
//  Created by Damon on 19/04/2015.
//  Copyright (c) 2015 damongolding. All rights reserved.
//

import UIKit

protocol updateData{
    func addTask(task:String)
}

class TaskListController: UITableViewController, updateData {
    
    var tasks : Tasks
    
    required init!(coder aDecoder: NSCoder!) {
        self.tasks = Tasks(tasks: ["Get eggs"])
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }


    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.tasks.taskList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("task", forIndexPath: indexPath) as! TaskListCell
        
        cell.configureCell(self.tasks.taskList[indexPath.row])
        
        return cell
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var AddNewTask : NewTaskController = NewTaskController()
        AddNewTask = segue.destinationViewController as! NewTaskController
        AddNewTask.delegate = self
    }
    
    func addTask(task: String) {
        
        self.tasks.addTask(task)
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData() // reload view
        })
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
