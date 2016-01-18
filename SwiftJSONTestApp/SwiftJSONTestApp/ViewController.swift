//
//  ViewController.swift
//  SwiftJSONTestApp
//
//  Created by Naohiro Hamada on 2016/01/18.
//  Copyright © 2016年 Naohiro Hamada. All rights reserved.
//

import UIKit
import SwiftJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let bundlePath = NSString(string: NSBundle.mainBundle().bundlePath)
        let jsonData1Path = bundlePath.stringByAppendingPathComponent("TestData1.json")
        let jsonData1 = JSONDeserializer.deserializeWith(filepath: jsonData1Path)
        print(jsonData1)
        let jsonData2Path = bundlePath.stringByAppendingPathComponent("TestData2.json")
        let jsonData2 = JSONDeserializer.deserializeWith(filepath: jsonData2Path)
        print(jsonData2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

