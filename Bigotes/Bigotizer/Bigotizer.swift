
import Foundation
import Mustache

struct Bigotizer {

    private static let defaultTemplateName = "parseable"
    
    static func bigotize(JSONFile jsonFile: String, mapperName: String, destinationEntity: String) throws {
        do {
            let template = try Template(named: defaultTemplateName)
            let jsonData = try JSONLoader.dictionaryFromFileNamed(jsonFile)
            let jsonKeys = Array(jsonData.keys)
            
            var elements = Array([])
            
            for key in jsonKeys {
                let isLast = (key == jsonKeys.last)
                elements.append(
                    [
                        "key": key,
                        "valueType": "",
                        "isLast": isLast
                    ]
                )
            }
            
            let allKeys =
                [
                    "elements":elements,
                    "entityName": mapperName,
                    "destinationEntity": destinationEntity
                ]
            let parsedTemplate = try template.render(Box(allKeys))
            
            save(parsedTemplate, named: mapperName)
            print(parsedTemplate)
        } catch {
            print("Shit happens 💩")
        }
    }
    
    static func save(bigote: String, named: String) {
        let fileManager = NSFileManager.defaultManager()
        let temp = NSTemporaryDirectory()
        
        let filePath = temp + named + ".swift"
        
        do {
            if fileManager.fileExistsAtPath(filePath) {
                try fileManager.removeItemAtPath(filePath)
            }
            try bigote.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
            print("Successfully generated file at:\n" + temp)
        } catch {
            print("Shit happens 💩")
        }
    }
}