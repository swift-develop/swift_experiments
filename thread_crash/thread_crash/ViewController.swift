//
//  ViewController.swift
//  thread_crash
//
//  Created by Tom Grant on 4/11/20.
//  Copyright © 2020 Tom Grant. All rights reserved.
//

import UIKit

class DefaultDict {
    private let serialQueue = DispatchQueue(label: "serialQueue")
    
    public var dict:[String:Any] = [:]
    public static let sharedManager = DefaultDict()
    private init(){ }

    public func set(value:Any,key:String){
//        serialQueue.sync{
            dict[key] = value
//        }
    }

    public func get(key:String) -> Any?{
        var result:Any?
//        serialQueue.sync{
            result = dict[key]
            
//        }
        return result
    }

    public func reset(){
        dict.removeAll()
    }
}

class ViewController: UIViewController {
    
    @IBAction func but(_ sender: Any) {
        threads()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //threads()
    }

    
    private func threads() {

            let count = 4
            
            for index in 0..<count{
                DefaultDict.sharedManager.set(value: index, key: String(index))
            }
        
        print( DefaultDict.sharedManager.dict )
            
            DispatchQueue.concurrentPerform(iterations:count) { (index) in
                if let n = DefaultDict.sharedManager.get(key: String(index)) as? Int{
                    print(n, index )
                }
            }
            
            //DefaultDict.sharedManager.reset()
            
            DispatchQueue.concurrentPerform(iterations:count) { (index) in
                //print("--set")
                DefaultDict.sharedManager.set(value:0,key:String(index))
                
            }
        
        
    }
}

