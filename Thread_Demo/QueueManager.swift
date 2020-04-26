//
//  QueueManager.swift
//  Thread_Demo
//
//  Created by Ha Nguyen Thai on 2/18/20.
//  Copyright © 2020 D.Ace. All rights reserved.
//

import Foundation

class QueueManager: NSObject {
    
    static let shared = QueueManager()
    
    // Concurrent queue with async task
    func concurrentQueue1() {
        let queue = DispatchQueue.init(label: "concurrent", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)
        
        for i in 1...100 {
            queue.async {
                print("concurrent" + "\(i)")
                sleep(1)
            }
        }
    }
    
    // Concurrent queue with sync task
    func concurrentQueue2() {
        let queue = DispatchQueue.init(label: "concurrent", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)
        
        for i in 1...100 {
            queue.sync {
                print(i)
                sleep(1)
            }
        }
    }
    
    // Concurrent queue with priority QOS
    func concurrentQueue3() {
        let queue1 = DispatchQueue.init(label: "concurrent1", qos: .unspecified, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)
        
        for i in 1...100 {
            queue1.async {
                print("unspecified" + "\(i)")
                sleep(1)
            }
        }
        
        let queue2 = DispatchQueue.init(label: "concurrent2", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)
        
        for i in 1...100 {
            queue2.async {
                print("userInteractive" + "\(i)")
                sleep(1)
            }
        }
        
        let queue3 = DispatchQueue.init(label: "concurrent3", qos: .userInitiated, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)
        
        for i in 1...100 {
            queue3.async {
                print("userInitiated" + "\(i)")
                sleep(1)
            }
        }
        
        let queue5 = DispatchQueue.init(label: "concurrent2", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)
        
        for i in 1...100 {
            queue5.async {
                print("default" + "\(i)")
                sleep(1)
            }
        }
        
        let queue6 = DispatchQueue.init(label: "concurrent2", qos: .utility, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)
        
        for i in 1...100 {
            queue6.async {
                print("utility" + "\(i)")
                sleep(1)
            }
        }
        
        let queue7 = DispatchQueue.init(label: "concurrent2", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .none)
        
        for i in 1...100 {
            queue7.async {
                print("background" + "\(i)")
                sleep(1)
            }
        }
    }
    
    // Serial queue with async task
    func serialQueue1() {
        let queue = DispatchQueue.init(label: "serial")
        for i in 1...100 {
            queue.async {
                print("serial" + "\(i)")
                sleep(1)
            }
        }
    }
    
    // Serial queue with sync task
    func serialQueue2() {
        let queue = DispatchQueue.init(label: "serial")
        for i in 1...100 {
            queue.sync {
                print(i)
                sleep(1)
            }
        }
    }
    
    func normalQueue() {
        // Main queue is same the serial queue
        for i in 1...100 {
            print(i)
            sleep(1)
        }
    }
    
    func globalQueue() {
        // Global queue is same the concurrent queue
        let queue = DispatchQueue.global()
        for i in 1...100 {
            queue.async {
                print(i)
                sleep(1)
            }
        }
    }
    
    func mainQueue() {
        // Global queue is same the concurrent queue
        let queue = DispatchQueue.main
        for i in 1...100 {
            
            // Make deadlock if call sync on main thread
            queue.sync {
                print(i)
                sleep(1)
            }
        }
    }
    
    func concurrentPerform() {
        DispatchQueue.concurrentPerform(iterations: 111) { (i) in
            print(i)
        }
    }
}
