//
//  Dispatch SemaphoreManager.swift
//  Thread_Demo
//
//  Created by Ha Nguyen Thai on 2/20/20.
//  Copyright © 2020 D.Ace. All rights reserved.
//

import Foundation
class DispatchSemaphoreManager: NSObject {
    
    static let shared = DispatchSemaphoreManager()
    
    let firstExecution = DispatchQueue.global(qos: .userInteractive)
    let secondExecution = DispatchQueue.global(qos: .userInteractive)
    let thirdExecution = DispatchQueue.global(qos: .userInteractive)
    let fourthExecution = DispatchQueue.global(qos: .userInteractive)
    let semaphore = DispatchSemaphore(value: 3)

    func concurrentRunning(queue: DispatchQueue, symbol: String) {
        queue.async {
            self.semaphore.wait()
            for i in 0...20 {
                print(symbol, i)
                sleep(1)
            }
            self.semaphore.signal()
        }
    }
    
    func semaphoreRunning() {
        self.concurrentRunning(queue: firstExecution, symbol: "firstExecution  -")
        self.concurrentRunning(queue: secondExecution, symbol: "secondExecution  -")
        self.concurrentRunning(queue: thirdExecution, symbol: "thirdExecution  -")
        self.concurrentRunning(queue: fourthExecution, symbol: "fourthExecution  -")
    }
    
}
