
import Foundation

enum JSONLoaderError: ErrorType {
    case FileNotFound
    case ParsingFailed
}

class JSONLoader: NSObject {
    
    static func dictionaryFromFileNamed(fileName: String) throws -> Dictionary<String, AnyObject> {
        do {
            let JSONData = try self.loadJSONDataFromFileNamed(fileName)
            let JSON = try NSJSONSerialization.JSONObjectWithData(JSONData, options: .AllowFragments) as! Dictionary<String, AnyObject>
            return JSON
        } catch {
            throw JSONLoaderError.ParsingFailed
        }
    }
    
    static func arrayFromFileNamed(fileName: String) throws ->[Dictionary<String, AnyObject>] {
        do {
            let JSONData = try self.loadJSONDataFromFileNamed(fileName)
            let JSON = try NSJSONSerialization.JSONObjectWithData(JSONData, options: .AllowFragments) as! [Dictionary<String, AnyObject>]
            return JSON
        } catch {
            throw JSONLoaderError.ParsingFailed
        }
    }
    
    static func loadJSONDataFromFileNamed(fileName: String) throws -> NSData {
        if let JSONFilePath = NSBundle(forClass: self.classForCoder()).pathForResource(fileName, ofType: "json") {
            if let JSONFileData = NSData(contentsOfFile: JSONFilePath) {
                return JSONFileData
            } else {
                throw JSONLoaderError.ParsingFailed
            }
        } else {
            throw JSONLoaderError.FileNotFound
        }
    }
    
}