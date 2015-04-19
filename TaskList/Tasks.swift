//
//  tasks.swift
//  codeData
//
//  Created by Damon on 19/04/2015.
//  Copyright (c) 2015 damongolding. All rights reserved.
//

import Foundation


struct Tasks {
    var taskList : [String]
    
    init(tasks:[String]) {
        self.taskList = tasks
    }
    
    mutating func addTask(newTask:String) {
        self.taskList.append(newTask)
    }
}
