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
public enum JSONDataType {
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
    /// 値のデータ型
    var dataType: JSONDataType { get }
    
    /// 整数値
    var intValue: Int { get set }
    
    /// 浮動小数点数
    var doubleValue: Double { get set }
    
    /// 文字列
    var stringValue: String { get set }
    
    /// 真理値
    var boolValue: Bool { get set }
    
    /// 配列データ
    var arrayValue: [JSONValue] { get set }
    
    /// オブジェクト
    var objectValue: [String:JSONValue] { get set }
    
    /// null
    var nullValue: NSNull { get }
    
    /// 配列から指定した要素を取り出す
    /// - parameter index インデックス
    subscript(index: Int) -> JSONValue { get set }
    
    /// オブジェクトから指定したキーの値を取り出す
    /// - parameter key キー名
    subscript(key: String) -> JSONValue { get set }
    
    /// 配列に要素を追加する
    /// - parameter newElement 追加する要素
    mutating func append(newElement: JSONValue)
    
    /// 配列の指定された位置に要素を挿入する
    /// - parameters:
    ///   - parameter newElement 挿入する要素
    ///   - parameter atIndex 要素を挿入する位置
    mutating func insert(newElement: JSONValue, atIndex i: Int)
    
    /// 配列の指定された位置から要素を削除する
    /// - parameter index 削除する要素の位置
    /// - returns: 削除された要素
    mutating func removeAtIndex(index: Int) -> JSONValue
    
    /// 配列、または、オブジェクトのすべての要素を削除する
    mutating func removeAll()
    
    /// 指定されたキーの値を更新する
    /// - parameters:
    ///   - parameter value 新しい値
    ///   - parameter forKey 値を更新するキー
    /// - returns: 更新前の値
    mutating func updateValue(value: JSONValue, forKey key: String) -> JSONValue
    
    /// 指定されたキーの値を削除する
    /// - parameter key 削除するキー
    /// - returns: 削除された値
    mutating func removeValueForKey(key: String) -> JSONValue
    
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
    
    /// 整数値
    var intValue: Int {
        get {
            return Int.min
        }
        set {
            assertionFailure("Type mismatch")
        }
    }
    /// 浮動小数点数
    var doubleValue: Double {
        get {
            return Double.NaN
        }
        set {
            assertionFailure("Type mismatch")
        }
    }
    /// 文字列
    var stringValue: String {
        get {
            return ""
        }
        set {
            assertionFailure("Type mismatch")
        }
    }
    /// 真理値
    var boolValue: Bool {
        get {
            return false
        }
        set {
            assertionFailure("Type mismatch")
        }
    }
    /// 配列
    var arrayValue: [JSONValue]  {
        get {
            return []
        }
        set {
            assertionFailure("Type mismatch")
        }
    }
    /// オブジェクト
    var objectValue: [String:JSONValue] {
        get {
            return [:]
        }
        set {
            assertionFailure("Type mismatch")
        }
    }
    /// null
    var nullValue: NSNull { return NSNull() }
    
    /// 配列から指定した要素を取り出す
    /// - parameter index インデックス
    subscript(index: Int) -> JSONValue {
        get {
            return JSONValueNull()
        }
        set {
            assertionFailure("Type mismatch")
        }
    }
    
    /// オブジェクトから指定したキーの値を取り出す
    /// - parameter key キー名
    subscript(key: String) -> JSONValue {
        get {
            return JSONValueNull()
        }
        set {
            assertionFailure("Type mismatch")
        }
    }
    
    /// 配列に要素を追加する
    /// - parameter newElement 追加する要素
    mutating func append(newElement: JSONValue) {
        assertionFailure("Type mismatch")
    }
    
    /// 配列の指定された位置に要素を挿入する
    /// - parameters:
    ///   - parameter newElement 挿入する要素
    ///   - parameter atIndex 要素を挿入する位置
    mutating func insert(newElement: JSONValue, atIndex i: Int) {
        assertionFailure("Type mismatch")
    }
    
    /// 配列の指定された位置から要素を削除する
    /// - parameter index 削除する要素の位置
    /// - returns: 削除された要素
    mutating func removeAtIndex(index: Int) -> JSONValue {
        assertionFailure("Type mismatch")
        return JSONValueNull()
    }
    
    /// 配列、または、オブジェクトのすべての要素を削除する
    mutating func removeAll() {
        assertionFailure("Type mismatch")
    }
    
    /// 指定されたキーの値を更新する
    /// - parameters:
    ///   - parameter value 新しい値
    ///   - parameter forKey 値を更新するキー
    /// - returns: 更新前の値
    mutating func updateValue(value: JSONValue, forKey key: String) -> JSONValue {
        assertionFailure("Type mismatch")
        return JSONValueNull()
    }
    
    /// 指定されたキーの値を削除する
    /// - parameter key 削除するキー
    /// - returns: 削除された値
    mutating func removeValueForKey(key: String) -> JSONValue {
        assertionFailure("Type mismatch")
        return JSONValueNull()
    }
    
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
    let dataType: JSONDataType = .Null
}

extension JSONValueNull : CustomStringConvertible, CustomDebugStringConvertible {
    var description: String { return "(null)" }
    var debugDescription: String { return "(null)" }
}

// MARK: - JSONValueInteger

/// 整数を表すJSONデータ
private struct JSONValueInteger : JSONValue {
    let dataType: JSONDataType = .Integer
    
    var value: Int
    
    var intValue: Int {
        get {
            return value
        }
        set {
            value = newValue
        }
    }
    var doubleValue: Double {
        get {
            return Double(value)
        }
        set {
            value = Int(newValue)
        }
    }
    var stringValue: String {
        get {
            return value.description
        }
        set {
            if let newValue = Int(newValue) {
                value = newValue
            }
        }
    }
    var boolValue: Bool {
        get {
            return Bool(value)
        }
        set {
            value = Int(newValue)
        }
    }
}

extension JSONValueInteger : CustomStringConvertible, CustomDebugStringConvertible {
    var description: String { return stringValue }
    var debugDescription: String { return stringValue }
}

// MARK: - JSONValueFloating

/// 浮動小数点数を表すJSONデータ
private struct JSONValueFloating : JSONValue {
    let dataType: JSONDataType = .Floating
    
    var value: Double
    
    var intValue: Int {
        get {
            return Int(value)
        }
        set {
            value = Double(newValue)
        }
    }
    var doubleValue: Double {
        get {
            return value
        }
        set {
            value = newValue
        }
    }
    var stringValue: String {
        get {
            return value.description
        }
        set {
            if let newValue = Double(newValue) {
                value = newValue
            }
        }
    }
    var boolValue: Bool {
        get {
            return Bool(value)
        }
        set {
            value = Double(newValue)
        }
    }
}

extension JSONValueFloating : CustomStringConvertible, CustomDebugStringConvertible {
    var description: String { return stringValue }
    var debugDescription: String { return stringValue }
}

// MARK: - JSONValueString

/// 文字列を表すJSONデータ
private struct JSONValueString : JSONValue {
    let dataType: JSONDataType = .String
    
    var value: String
    
    var stringValue: String {
        get {
            return value
        }
        set {
            value = newValue
        }
    }
    var boolValue: Bool {
        get {
            return value.lowercaseString == "true" ? true : false
        }
        set {
            value = String(newValue)
        }
    }
}

extension JSONValueString : CustomStringConvertible, CustomDebugStringConvertible {
    var description: String { return stringValue }
    var debugDescription: String { return stringValue }
}

// MARK: - JSONValueBoolean

/// 真理値を表すJSONデータ
private struct JSONValueBoolean : JSONValue {
    let dataType: JSONDataType = .Boolean
    
    var value: Bool
    
    var intValue: Int {
        get {
            return Int(value)
        }
        set {
            value = Bool(newValue)
        }
    }
    var doubleValue: Double {
        get {
            return Double(value)
        }
        set {
            value = Bool(newValue)
        }
    }
    var stringValue: String {
        get {
            return value.description
        }
        set {
            value = newValue.lowercaseString == "true"
        }
    }
    var boolValue: Bool {
        get {
            return value
        }
        set {
            value = newValue
        }
    }
}

extension JSONValueBoolean : CustomStringConvertible, CustomDebugStringConvertible {
    var description: String { return stringValue }
    var debugDescription: String { return stringValue }
}

// MARK: - JSONValueArray

/// 配列を表すJSONデータ
private struct JSONValueArray : JSONValue {
    let dataType: JSONDataType = .Array
    
    var value: [JSONValue]
    
    var arrayValue: [JSONValue] {
        get {
            return value
        }
        set {
            value = newValue
        }
    }
    
    subscript(index: Int) -> JSONValue {
        get {
            if index >= 0 && index < value.count {
                return value[index]
            }
            return JSONValueNull()
        }
        set {
            if index >= 0 && index < value.count {
                value[index] = newValue
            }
        }
    }
    
    mutating func append(newElement: JSONValue) {
        self.value.append(newElement)
    }
    mutating func insert(newElement: JSONValue, atIndex i: Int) {
        value.insert(newElement, atIndex: i)
    }
    mutating func removeAtIndex(index: Int) -> JSONValue {
        return value.removeAtIndex(index)
    }
    mutating func removeAll() {
        value.removeAll()
    }
}

extension JSONValueArray : CustomStringConvertible, CustomDebugStringConvertible {
    var description: String { return value.description }
    var debugDescription: String { return value.debugDescription }
}

// MARK: - JSONValueObject

/// オブジェクトを表すJSONデータ
private struct JSONValueObject : JSONValue {
    let dataType: JSONDataType = .Object
    
    var value: [String:JSONValue]
    
    var objectValue: [String:JSONValue] {
        get {
            return value
        }
        set {
            value = newValue
        }
    }
    
    subscript(key: String) -> JSONValue {
        get {
            if value.keys.contains(key) {
                return value[key]!
            }
            return JSONValueNull()
        }
        set {
            value[key] = newValue
        }
    }
    
    mutating func removeAll() {
        value.removeAll()
    }
    mutating func updateValue(value: JSONValue, forKey key: String) -> JSONValue {
        if self.value.keys.contains(key) {
            return self.value.updateValue(value, forKey: key)!
        } else {
            return JSONValueNull()
        }
    }
    mutating func removeValueForKey(key: String) -> JSONValue {
        if self.value.keys.contains(key) {
            return value.removeValueForKey(key)!
        } else {
            return JSONValueNull()
        }
    }
}

extension JSONValueObject : CustomStringConvertible, CustomDebugStringConvertible {
    var description: String { return value.description }
    var debugDescription: String { return value.debugDescription }
}

// MARK: - Extensions for Swift Standard Library

/// JSONValueを得るプロトコル
public protocol JSONValueConvertible {
    /// JSONValueとしての値
    var jsonValue: JSONValue { get }
}

/// IntからJSONValueを得るプロトコル
extension Int : JSONValueConvertible {
    /// JSONValueとしての値
    public var jsonValue: JSONValue {
        return JSONValueInteger(value: self)
    }
}

/// FloatからJSONValueを得るプロトコル
extension Float : JSONValueConvertible {
    /// JSONValueとしての値
    public var jsonValue: JSONValue {
        return JSONValueFloating(value: Double(self))
    }
}

/// DoubleからJSONValueを得るプロトコル
extension Double : JSONValueConvertible {
    /// JSONValueとしての値
    public var jsonValue: JSONValue {
        return JSONValueFloating(value: Double(self))
    }
}

/// StringからJSONValueを得るプロトコル
extension String : JSONValueConvertible{
    /// JSONValueとしての値
    public var jsonValue: JSONValue {
        return JSONValueString(value: self)
    }
}

/// BoolからJSONValueを得るプロトコル
extension Bool : JSONValueConvertible{
    /// JSONValueとしての値
    public var jsonValue: JSONValue {
        return JSONValueBoolean(value: self)
    }
}

/// DictionaryからJSONValueを得るプロトコル
extension Dictionary : JSONValueConvertible {
    /// JSONValueとしての値
    public var jsonValue: JSONValue {
        var dic = [String:JSONValue]()
        for (k, v) in self {
            let key = String(k)
            if let value = v as? AnyObject {
                dic[key] = JSONDeserializer.deserializeValue(value)
            } else {
                dic[key] = JSONValueNull()
            }
        }
        return JSONValueObject(value: dic)
    }
}

/// ArrayからJSONValueを得るプロトコル
extension Array : JSONValueConvertible {
    /// JSONValueとしての値
    public var jsonValue: JSONValue {
        let mappedArray = self.map(elementToJSONValue)
        return JSONValueArray(value: mappedArray)
    }
    
    /// 配列の要素をJSONValueへ変換するヘルパー関数
    private func elementToJSONValue(value: Any?) -> JSONValue {
        if value == nil {
            return JSONValueNull()
        }
        let v = Mirror(reflecting: value!)
        if v.children.count == 0 {
            return JSONValueNull()
        }
        let (_, some) = v.children.first!
        switch some {
        case is Int:
            return JSONValueInteger(value: some as! Int)
        case is Float:
            return JSONValueFloating(value: Double(some as! Float))
        case is Double:
            return JSONValueFloating(value: some as! Double)
        case is String:
            return JSONValueString(value: some as! String)
        case is Bool:
            return JSONValueBoolean(value: some as! Bool)
        case is Array:
            return (some as! Array<Any?>).jsonValue
        case is Dictionary<String, JSONValueConvertible>:
            return (some as! Dictionary<String, JSONValueConvertible>).jsonValue
        default:
            return JSONValueNull()
        }
    }
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
    internal class func deserializeDictionary(dictionary: Dictionary<String, AnyObject>) -> JSONValue {
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
    internal class func deserializeArray(array: Array<AnyObject>) -> JSONValue {
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
    internal class func deserializeValue(value: AnyObject) -> JSONValue {
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

// MARK: - JSONSerializer

/// JSONを書き込むクラス
public final class JSONSerializer {
    private init() { }
    
    /// 指定されたJSONオブジェクトを指定されたファイルパスに書き込む
    /// - parameters:
    ///   - json 書き込むJSONデータ
    ///   - toFilePath 書き込み先のファイル
    ///   - withOption 書き込み時のオプション
    ///                デフォルト値は `NSJSONWritingOptions.PrettyPrinted`
    /// - returns: ファイルが正しく書き出せた場合は`true`を返し、それ以外の場合は、`false`を返す
    public class func serialize(json json: JSONValue, toFilePath filepath: String, withOption options: NSJSONWritingOptions = NSJSONWritingOptions.PrettyPrinted) -> Bool {
        if json.isObject {
            let data = serializeObject(json)
            guard let serializedData = try? NSJSONSerialization.dataWithJSONObject(data, options: options) else {
                return false
            }
            return writeData(serializedData, filepath: filepath)
        } else if json.isArray {
            let data = serializeArray(json)
            guard let serializedData = try? NSJSONSerialization.dataWithJSONObject(data, options: options) else {
                return false
            }
            return writeData(serializedData, filepath: filepath)
        }
        return false
    }
    
    /// JSONオブジェクトからDictionaryに変換を行う
    /// - parameter jsonObject 変換を行うJSONオブジェクト
    /// - returns: 変換済みのDictionary
    private class func serializeObject(jsonObject: JSONValue) -> [NSObject:AnyObject] {
        var data = [NSObject:AnyObject]()
        for (key, value) in jsonObject.objectValue {
            switch value.dataType {
            case .Integer:
                data[key] = value.intValue
            case .Floating:
                data[key] = value.doubleValue
            case .String:
                data[key] = value.stringValue
            case .Boolean:
                data[key] = value.boolValue
            case .Null:
                data[key] = value.nullValue
            case .Object:
                data[key] = serializeObject(value)
            case .Array:
                data[key] = serializeArray(value)
            }
        }
        return data
    }
    
    /// JSONの配列データからArrayに変換を行う
    /// - parameter jsonArray 変換を行うJSONの配列データ
    /// - returns: 変換済みのArray
    private class func serializeArray(jsonArray: JSONValue) -> [NSObject] {
        var data = [NSObject]()
        for value in jsonArray.arrayValue {
            switch value.dataType {
            case .Integer:
                data.append(value.intValue)
            case .Floating:
                data.append(value.doubleValue)
            case .String:
                data.append(value.stringValue)
            case .Boolean:
                data.append(value.boolValue)
            case .Null:
                data.append(value.nullValue)
            case .Object:
                data.append(serializeObject(value))
            case .Array:
                data.append(serializeArray(value))
            }
        }
        return data
    }
    
    /// シリアライズされたデータをファイルへ書き出す
    /// - parameters:
    ///   - parameter data シリアライズしたJSONデータ
    ///   - parameter filepath 書き出し先のファイル
    /// - returns: ファイルが書き出せたかどうか
    private class func writeData(data: NSData, filepath: String) -> Bool {
        let url = NSURL(fileURLWithPath: filepath)
        return data.writeToURL(url, atomically: true)
    }
}