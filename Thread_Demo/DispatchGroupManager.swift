//
//  DispatchGroupManager.swift
//  Thread_Demo
//
//  Created by Ha Nguyen Thai on 2/20/20.
//  Copyright © 2020 D.Ace. All rights reserved.
//

import Foundation

class DispatchGroupManager: NSObject {
    static let shared = DispatchGroupManager()
    let group = DispatchGroup()
    
    func dispatchGroupRunning() {
        DispatchQueue.concurrentPerform(iterations: 3) { (i) in
            switch i {
            case 0:
                globalQueue1()
            case 1:
                globalQueue2()
            case 2:
                globalQueue3()
            default:
                break
            }
            
        }
        
        group.notify(queue: .main) {
            print(" Get data finished")
        }
    }
    
    func globalQueue1() {
        group.enter()
        for i in 1...100 {
            print("globalQueue1-" + "\(i)")
            if i == 100 {
                group.leave()
            }
        }
    }
    
    func globalQueue2() {
        group.enter()
        for i in 1...100 {
            print("globalQueue2-" + "\(i)")
            if i == 100 {
                group.leave()
            }
        }
    }
    
    func globalQueue3() {
        group.enter()
        for i in 1...100 {
            print("globalQueue3-" + "\(i)")
            if i == 100 {
                group.leave()
            }
        }
    }
    
}
