//
//  NewTaskController.swift
//  codeData
//
//  Created by Damon on 19/04/2015.
//  Copyright (c) 2015 damongolding. All rights reserved.
//

import UIKit

class NewTaskController: UITableViewController {
    
    @IBOutlet weak var newTaskTitle: UITextField!
    
    var delegate : TaskListController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }
    
    override func viewWillDisappear(animated: Bool) {
        // If title is not empty send title back to task list
        if !newTaskTitle.text.isEmpty {
            delegate?.addTask(newTaskTitle.text!)
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
