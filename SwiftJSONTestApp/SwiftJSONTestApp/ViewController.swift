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
        let jsonData1OutPath = bundlePath.stringByAppendingPathComponent("TestData1-Out.json")
        JSONSerializer.serialize(json: jsonData1, toFilePath: jsonData1OutPath)
        
        let jsonData2Path = bundlePath.stringByAppendingPathComponent("TestData2.json")
        let jsonData2 = JSONDeserializer.deserializeWith(filepath: jsonData2Path)
        print(jsonData2)
        let jsonData2OutPath = bundlePath.stringByAppendingPathComponent("TestData2-Out.json")
        JSONSerializer.serialize(json: jsonData2, toFilePath: jsonData2OutPath)
        
        let jsonData3Path = bundlePath.stringByAppendingPathComponent("TestData3.json")
        var jsonData3 = JSONDeserializer.deserializeWith(filepath: jsonData3Path)
        print(jsonData3)
        if jsonData3.isObject {
            jsonData3["new-data"] = 1.jsonValue
            jsonData3["new-array"] = ["dd", "asf", 3].jsonValue
            jsonData3["new-array"].append(10.jsonValue)
            jsonData3["new-dic"] = ["test0": 13.0, "test1": true, "test2": ["sub"]].jsonValue
            jsonData3["new-dic"]["append-data"] = 20.jsonValue
            print("Updated: \(jsonData3)")
        }
        let jsonData3OutPath = bundlePath.stringByAppendingPathComponent("TestData3-Out.json")
        JSONSerializer.serialize(json: jsonData3, toFilePath: jsonData3OutPath)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

