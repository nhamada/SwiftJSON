//
//  SwiftJSON.swift
//  SwiftJSON
//
//  Created by Naohiro Hamada on 2016/01/18.
//  Copyright © 2016年 Naohiro Hamada. All rights reserved.
//

import Foundation

public enum JSONDataType {
    case Integer, Floating
    case String
    case Boolean
    case Array
    case Object
    case Null
}

public protocol JSONValue {
    var dataType: JSONDataType { get }
    
    var intValue: Int { get }
    var doubleValue: Double { get }
    var stringValue: String { get }
    var boolValue: Bool { get }
    var arrayValue: [JSONValue] { get }
    var objectValue: [String:JSONValue] { get }
    
    subscript(index: Int) -> JSONValue { get }
    subscript(key: String) -> JSONValue { get }
    
    var isInteger: Bool { get }
    var isFloating: Bool { get }
    var isString: Bool { get }
    var isBoolean: Bool { get }
    var isArray: Bool { get }
    var isObject: Bool { get }
    var isNull: Bool { get }
}

extension JSONValue {
    var dataType: JSONDataType { return .Null }
    
    var intValue: Int { return Int.min }
    var doubleValue: Double { return Double.NaN }
    var stringValue: String { return "" }
    var boolValue: Bool { return false }
    var arrayValue: [JSONValue] { return [] }
    var objectValue: [String:JSONValue] { return [:] }
    
    subscript(index: Int) -> JSONValue { return JSONValueNull() }
    subscript(key: String) -> JSONValue { return JSONValueNull() }
    
    var isInteger: Bool { return dataType == .Integer }
    var isFloating: Bool { return dataType == .Floating }
    var isString: Bool { return dataType == .String }
    var isBoolean: Bool { return dataType == .Boolean }
    var isArray: Bool { return dataType == .Array }
    var isObject: Bool { return dataType == .Object }
    var isNull: Bool { return dataType == .Null }
}

private struct JSONValueNull : JSONValue {
}

private struct JSONValueInteger : JSONValue {
    let dataType: JSONDataType = .Integer
    
    let value: Int
    
    var intValue: Int { return value }
    var doubleValue: Double { return Double(value) }
    var stringValue: String { return value.description }
    var boolValue: Bool { return Bool(value) }
}

extension JSONValueInteger : CustomStringConvertible, CustomDebugStringConvertible {
    var description: String { return stringValue }
    var debugDescription: String { return stringValue }
}

private struct JSONValueFloating : JSONValue {
    let dataType: JSONDataType = .Floating
    
    let value: Double
    
    var intValue: Int { return Int(value) }
    var doubleValue: Double { return value }
    var stringValue: String { return value.description }
    var boolValue: Bool { return Bool(value) }
}

extension JSONValueFloating : CustomStringConvertible, CustomDebugStringConvertible {
    var description: String { return stringValue }
    var debugDescription: String { return stringValue }
}

private struct JSONValueString : JSONValue {
    let dataType: JSONDataType = .String
    
    let value: String
    
    var stringValue: String { return value }
    var boolValue: Bool { return value.lowercaseString == "true" ? true : false }
}

extension JSONValueString : CustomStringConvertible, CustomDebugStringConvertible {
    var description: String { return stringValue }
    var debugDescription: String { return stringValue }
}

private struct JSONValueBoolean : JSONValue {
    let dataType: JSONDataType = .Boolean
    
    let value: Bool
    
    var intValue: Int { return Int(value) }
    var doubleValue: Double { return Double(value) }
    var stringValue: String { return value.description }
    var boolValue: Bool { return value }
}

extension JSONValueBoolean : CustomStringConvertible, CustomDebugStringConvertible {
    var description: String { return stringValue }
    var debugDescription: String { return stringValue }
}

private struct JSONValueArray : JSONValue {
    let dataType: JSONDataType = .Array
    
    let value: [JSONValue]
    
    var stringValue: String { return value.description }
    var arrayValue: [JSONValue] { return value }
    
    subscript(index: Int) -> JSONValue {
        if index >= 0 && index < value.count {
            return value[index]
        }
        return JSONValueNull()
    }
}

extension JSONValueArray : CustomStringConvertible, CustomDebugStringConvertible {
    var description: String { return stringValue }
    var debugDescription: String { return stringValue }
}

private struct JSONValueObject : JSONValue {
    let dataType: JSONDataType = .Object
    
    let value: [String:JSONValue]
    
    var stringValue: String { return value.description }
    var objectValue: [String:JSONValue] { return value }
    
    subscript(key: String) -> JSONValue {
        if value.keys.contains(key) {
            return value[key]!
        }
        return JSONValueNull()
    }
}

extension JSONValueObject : CustomStringConvertible, CustomDebugStringConvertible {
    var description: String { return stringValue }
    var debugDescription: String { return stringValue }
}

public final class JSONDeserializer {
    private init() { }
    
    public class func deserializeWith(filepath filepath: String) -> JSONValue {
        let fileManager = NSFileManager.defaultManager()
        var isDirectory = ObjCBool(false)
        let isExist = fileManager.fileExistsAtPath(filepath, isDirectory: &isDirectory)
        if !isExist || isDirectory.boolValue {
            return JSONValueNull()
        }
        guard let data = NSData(contentsOfFile: filepath) else {
            return JSONValueNull()
        }
        return deserializeWith(data: data)
    }
    
    public class func deserializeWith(url url: NSURL) -> JSONValue {
        guard let data = NSData(contentsOfURL: url) else {
            return JSONValueNull()
        }
        return deserializeWith(data: data)
    }
    
    private class func deserializeWith(data data: NSData) -> JSONValue {
        guard let jsonObject = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) else {
            return JSONValueNull()
        }
        if jsonObject.isKindOfClass(NSDictionary) {
            guard let dic = jsonObject as? Dictionary<String, AnyObject> else {
                return JSONValueNull()
            }
            return deserializeDictionary(dic)
        } else if jsonObject.isKindOfClass(NSArray) {
            guard let array = jsonObject as? Array<AnyObject> else {
                return JSONValueNull()
            }
            return deserializeArray(array)
        } else {
            return JSONValueNull()
        }
    }
    
    private class func deserializeDictionary(dictionary: Dictionary<String, AnyObject>) -> JSONValue {
        var deserializedDictionary = [String:JSONValue]()
        for (k, v) in dictionary {
            let value = deserializeValue(v)
            let key = String(k)
            if !key.isEmpty {
                deserializedDictionary[key] = value
            }
        }
        return JSONValueObject(value: deserializedDictionary)
    }
    
    private class func deserializeArray(array: Array<AnyObject>) -> JSONValue {
        var deserializedArray = [JSONValue]()
        for element in array {
            deserializedArray.append(deserializeValue(element))
        }
        return JSONValueArray(value: deserializedArray)
    }
    
    private class func deserializeValue(value: AnyObject) -> JSONValue {
        if value.isKindOfClass(NSString) {
            return deserializeString(value as! NSString)
        }
        if value.isKindOfClass(NSNumber) {
            return deserializeNumber(value as! NSNumber)
        }
        if value.isKindOfClass(NSDictionary) {
            guard let dic = value as? Dictionary<String, AnyObject> else {
                return JSONValueNull()
            }
            return deserializeDictionary(dic)
        }
        if value.isKindOfClass(NSArray) {
            guard let array = value as? Array<AnyObject> else {
                return JSONValueNull()
            }
            return deserializeArray(array)
        }
        return JSONValueNull()
    }
    
    private class func deserializeString(string: NSString) -> JSONValue {
        return JSONValueString(value: String(string))
    }
    
    private class func deserializeNumber(number: NSNumber) -> JSONValue {
        guard let objcType = String.fromCString(number.objCType) else {
            return JSONValueNull()
        }
        switch objcType {
        case "c", "C", "B":
            return JSONValueBoolean(value: number.boolValue)
        case "i", "s", "l", "q", "I", "S", "L", "Q":
            return JSONValueInteger(value: number.integerValue)
        case "f", "d":
            return JSONValueFloating(value: number.doubleValue)
        default:
            return JSONValueNull()
        }
    }
    
}
