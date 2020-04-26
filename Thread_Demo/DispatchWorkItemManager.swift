//
//  DispatchWorkItem.swift
//  Thread_Demo
//
//  Created by Ha Nguyen Thai on 2/18/20.
//  Copyright © 2020 D.Ace. All rights reserved.
//

import Foundation

class DispatchWorkItemManager: NSObject {
    static let shared = DispatchWorkItemManager()
    
    
    // Submit and cancel DWI on concurrent queue
    func dispatchWorkItemRunning1() {
        var dwi:DispatchWorkItem?
        dwi = DispatchWorkItem { [weak self] in
            self?.concurrentQueue2(dwi)
        }
        
        //submit the work item to the default global queue
        DispatchQueue.global().async(execute: dwi!)
        
        //cancelling the task after 3 seconds
        DispatchQueue.global().async {
            sleep(2)
            dwi?.cancel()
        }
    }
    
    // Submit and cancel DWI on serial or main queue
    func dispatchWorkItemRunning2() {
        var dwi:DispatchWorkItem?
        dwi = DispatchWorkItem { [weak self] in
            self?.mainQueue(dwi)
        }
        
        let queue = DispatchQueue.init(label: "serial")
        queue.async(execute: dwi!)
        
        queue.asyncAfter(deadline: .now() + 2) {
            dwi?.cancel()
        }
    }
    
    // Submit and cancel DWI on serial or main queue
    func dispatchWorkItemRunning3() {
        var dwi:DispatchWorkItem?
        dwi = DispatchWorkItem { [weak self] in
            self?.mainQueue(dwi)
        }
        
        let queue = DispatchQueue.init(label: "serial",attributes: .concurrent)
        queue.async(execute: dwi!)
        
        queue.asyncAfter(deadline: .now() + 2) {
            dwi?.cancel()
        }
    }
    
    // Concurrent queue with async task
    func concurrentQueue1(_ dwi: DispatchWorkItem?) {
        let queue = DispatchQueue.init(label: "concurrent", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)
        
        for i in 1...100 {
            queue.async {
                print("\(dwi!.isCancelled)")
                if (dwi?.isCancelled)!{
                  return
                }
                print("concurrentQueue" + "\(i)")
                sleep(1)
            }
        }
    }
    
    // Concurrent queue with async task
    func concurrentQueue2(_ dwi: DispatchWorkItem?) {
        DispatchQueue.concurrentPerform(iterations: 3) { (i) in
            switch i {
            case 0:
                self.mainQueue(dwi)
            case 1:
                self.mainQueue1(dwi)
            case 2:
                self.mainQueue2(dwi)
            default:
                break
            }
        }
    }
    
    func mainQueue(_ dwi: DispatchWorkItem?) {
        for i in 1...10 {
            print("\(dwi!.isCancelled)")
            if (dwi?.isCancelled)! {
                break
            }
            sleep(1)
            print("mainQueue : \(i)")
        }
    }
    
    func mainQueue1(_ dwi: DispatchWorkItem?) {
        for i in 1...10 {
            print("\(dwi!.isCancelled)")
            if (dwi?.isCancelled)! {
                break
            }
            sleep(1)
            print("mainQueue1 : \(i)")
        }
    }
    
    func mainQueue2(_ dwi: DispatchWorkItem?) {
        for i in 1...10 {
            print("\(dwi!.isCancelled)")
            if (dwi?.isCancelled)! {
                break
            }
            sleep(1)
            print("mainQueue2 : \(i)")
        }
    }
    
}
