//
//  SwiftJSON.swift
//  SwiftJSON
//
//  Created by Naohiro Hamada on 2016/01/18.
//  Copyright © 2016年 Naohiro Hamada. All rights reserved.
//

import Foundation

// MARK: - JSONDataType

/// JSONで表現可能なデータ型
internal enum JSONDataType {
    case Integer, Floating
    case String
    case Boolean
    case Array
    case Object
    case Null
}

// MARK: - JSONValue

/// JSONに格納されている値
public protocol JSONValue {
    /// 整数値
    var intValue: Int { get }
    
    /// 浮動小数点数
    var doubleValue: Double { get }
    
    /// 文字列
    var stringValue: String { get }
    
    /// 真理値
    var boolValue: Bool { get }
    
    /// 配列データ
    var arrayValue: [JSONValue] { get }
    
    /// オブジェクト
    var objectValue: [String:JSONValue] { get }
    
    /// 配列から指定した要素を取り出す
    /// - parameter index インデックス
    subscript(index: Int) -> JSONValue { get }
    
    /// オブジェクトから指定したキーの値を取り出す
    /// - parameter key キー名
    subscript(key: String) -> JSONValue { get }
    
    /// 整数かどうか
    var isInteger: Bool { get }
    
    /// 浮動小数点数かどうか
    var isFloating: Bool { get }
    
    /// 文字列かどうか
    var isString: Bool { get }
    
    /// 真理値かどうか
    var isBoolean: Bool { get }
    
    /// 配列かどうか
    var isArray: Bool { get }
    
    /// オブジェクトかどうか
    var isObject: Bool { get }
    
    /// 不定の値かどうか
    var isNull: Bool { get }
}

// MARK: - JSONValue default implementation

extension JSONValue {
    /// 値のデータ型
    var dataType: JSONDataType { return .Null }
    
    /// 整数値
    var intValue: Int { return Int.min }
    /// 浮動小数点数
    var doubleValue: Double { return Double.NaN }
    /// 文字列
    var stringValue: String { return "" }
    /// 真理値
    var boolValue: Bool { return false }
    /// 配列
    var arrayValue: [JSONValue] { return [] }
    /// オブジェクト
    var objectValue: [String:JSONValue] { return [:] }
    
    /// 配列から指定した要素を取り出す
    /// - parameter index インデックス
    subscript(index: Int) -> JSONValue { return JSONValueNull() }
    
    /// オブジェクトから指定したキーの値を取り出す
    /// - parameter key キー名
    subscript(key: String) -> JSONValue { return JSONValueNull() }
    
    /// 整数かどうか
    var isInteger: Bool { return dataType == .Integer }
    /// 浮動小数点数かどうか
    var isFloating: Bool { return dataType == .Floating }
    /// 文字列かどうか
    var isString: Bool { return dataType == .String }
    /// 真理値かどうか
    var isBoolean: Bool { return dataType == .Boolean }
    /// 配列かどうか
    var isArray: Bool { return dataType == .Array }
    /// オブジェクトかどうか
    var isObject: Bool { return dataType == .Object }
    /// 不定の値かどうか
    var isNull: Bool { return dataType == .Null }
}

// MARK: - JSONValueNull

/// 不定値を表すJSONデータ
private struct JSONValueNull : JSONValue {
}

// MARK: - JSONValueInteger

/// 整数を表すJSONデータ
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

// MARK: - JSONValueFloating

/// 浮動小数点数を表すJSONデータ
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

// MARK: - JSONValueString

/// 文字列を表すJSONデータ
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

// MARK: - JSONValueBoolean

/// 真理値を表すJSONデータ
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

// MARK: - JSONValueArray

/// 配列を表すJSONデータ
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

// MARK: - JSONValueObject

/// オブジェクトを表すJSONデータ
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

// MARK: - JSONDeserializer

/// JSONを読み込むクラス
public final class JSONDeserializer {
    private init() { }
    
    /// 指定されたファイルパスからJSONを読み込む
    /// - parameter filepath 読み込むファイル
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
    
    /// 指定されたURLからJSONを読み込む
    /// - parameter url 読み込むURL
    public class func deserializeWith(url url: NSURL) -> JSONValue {
        guard let data = NSData(contentsOfURL: url) else {
            return JSONValueNull()
        }
        return deserializeWith(data: data)
    }
    
    /// シリアライズされたデータからJSONを読み込む
    /// - parameter data シリアライズされたJSONデータ
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
    
    /// ディクショナリーからJSONデータを読み込む
    /// - parameter dictionary ディクショナリー
    /// - returns: ディクショナリーを表すJSONデータ
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
    
    /// 配列からJSONデータを読み込む
    /// - parameter array 配列
    /// - returns: 配列を表すJSONデータ
    private class func deserializeArray(array: Array<AnyObject>) -> JSONValue {
        var deserializedArray = [JSONValue]()
        for element in array {
            deserializedArray.append(deserializeValue(element))
        }
        return JSONValueArray(value: deserializedArray)
    }
    
    /// 値からJSONデータを読み込む
    /// - parameter value 読み込む値
    /// - returns: JSONデータ
    ///   読み込む値に応じたデータを格納する
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
    
    /// 文字列からJSONデータを読み込む
    /// - parameter string 読み込む文字列
    /// - returns: 文字列を表すJSONデータ
    private class func deserializeString(string: NSString) -> JSONValue {
        return JSONValueString(value: String(string))
    }
    
    /// 値からJSONデータを読み込む
    /// - parameter number 読み込む値
    /// - returns: 値を表すJSONデータ
    ///   読み込む値に応じて、整数、浮動小数点数、真理値を格納する
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
