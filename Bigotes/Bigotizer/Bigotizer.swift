
import Foundation
import Mustache

struct Bigotizer {

    private static let defaultTemplateName = "parseable"
    
    static func bigotize(JSONFile jsonFile: String, mapperName: String, destinationEntity: String) throws {
        do {
            let template = try Template(named: defaultTemplateName)
            let jsonData = try JSONLoader.dictionaryFromFileNamed(jsonFile)
            
            var elements: [Dictionary<String, AnyObject>] = []
            let lastKey = Array(jsonData.keys).last
            
            for (key, _) in jsonData {
                let isLast = (key == lastKey)
                elements.append(
                    [
                        "key": key,
                        "isLast": isLast
                    ]
                )
            }
            
            let data =
                [
                    "elements":elements,
                    "entityName": mapperName,
                    "destinationEntity": destinationEntity
                ]
            let parsedTemplate = try template.render(Box(data))
            
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