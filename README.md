# SwiftJSON
JSON Framework with Swift

## 概要
JSONを読み込んだり、書き込んだりするフレームワーク。

* `JSONDeserializer`
  * JSONを読み込むクラス
* `JSONSerializer`
  * JSONを書き込むクラス
* `JSONValue`
  * JSON

## `JSONDeserializer`
JSONを読み込みます。

* `deserializeWith(filepath:)`
  * `filepath`で指定されたファイルパスからJSONファイルを読み込みます。
* `deserializeWith(url:)`
  * `url`で指定されたURLからJSONファイルを読み込みます。

## `JSONDeserializer`

JSONをファイルに書き込みます。

* `serialize(json:toFilePath:withOption)`
  * `json`に渡されたJSONデータを`toFilePath`で指定されたファイルへ書き込みます。
  * JSONを書き込む際のオプションは、`withOption`で指定します。
    * 指定可能なオプションは、`NSJSONWritingOptions`です。デフォルトでは、`NSJSONWritingOptions.PrettyPrinted`を指定して書き込みを行います。

## `JSONValue`

Frameworkで使用するJSONデータです。
定義は、以下のようになっています。

```swift
/// JSONで表現可能なデータ型
public enum JSONDataType {
    case Integer
    case Floating
    case String
    case Boolean
    case Array
    case Object
    case Null
}

/// JSONに格納されている値
public protocol JSONValue {
    /// 値のデータ型
    public var dataType: SwiftJSON.JSONDataType { get }
    /// 整数値
    public var intValue: Int { get }
    /// 浮動小数点数
    public var doubleValue: Double { get }
    /// 文字列
    public var stringValue: String { get }
    /// 真理値
    public var boolValue: Bool { get }
    /// 配列データ
    public var arrayValue: [JSONValue] { get }
    /// オブジェクト
    public var objectValue: [String : JSONValue] { get }
    public subscript (index: Int) -> JSONValue { get }
    public subscript (key: String) -> JSONValue { get }
    /// 整数かどうか
    public var isInteger: Bool { get }
    /// 浮動小数点数かどうか
    public var isFloating: Bool { get }
    /// 文字列かどうか
    public var isString: Bool { get }
    /// 真理値かどうか
    public var isBoolean: Bool { get }
    /// 配列かどうか
    public var isArray: Bool { get }
    /// オブジェクトかどうか
    public var isObject: Bool { get }
    /// 不定の値かどうか
    public var isNull: Bool { get }
}
```

プロパティ`###Value`となっているものは、それぞれ、Swiftでのデータを取得するものになります。
プロパティ`is###`は、JSONデータの種類の判定をするためのプロパティです。

整数を表すデータの場合、`isInteger`は`true`が返り、データは、`intValue`で得ることができます。

## コード例

```swift
let bundlePath = NSString(string: NSBundle.mainBundle().bundlePath)
let jsonDataPath = bundlePath.stringByAppendingPathComponent("TestData.json")
let jsonData = JSONDeserializer.deserializeWith(filepath: jsonDataPath)
print(jsonData)
let jsonDataOutPath = bundlePath.stringByAppendingPathComponent("TestData-Out.json")
JSONSerializer.serialize(json: jsonData, toFilePath: jsonDataOutPath)
```
