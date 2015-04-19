//
//  TaskListCell.swift
//  codeData
//
//  Created by Damon on 19/04/2015.
//  Copyright (c) 2015 damongolding. All rights reserved.
//

import UIKit

class TaskListCell: UITableViewCell {

    @IBOutlet weak var taskTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(taskTitle:String){
        self.taskTitle.text = taskTitle
    }

}
