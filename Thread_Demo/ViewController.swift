//
//  ViewController.swift
//  Thread_Demo
//
//  Created by Ha Nguyen Thai on 2/18/20.
//  Copyright © 2020 D.Ace. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchSemaphoreManager.shared.semaphoreRunning()
        
    }

    

}

