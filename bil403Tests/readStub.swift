//
//  readStub.swift
//  bil403Tests
//
//  Created by Gürhan Kuraş on 12/21/21.
//

import Foundation

/// https://praveenkommuri.medium.com/how-to-read-parse-local-json-file-in-swift-28f6cec747cf

/*
func readLocalJSONFile(forName name: String) -> Data? {
    do {
        if let filePath = Bundle(for: Cart_Tests.self).path(forResource: name, ofType: ".json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
}


func parse<T: Decodable>(jsonData: Data, returnType: T.Type) -> T? {
    do {
        let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
        return decodedData
    } catch {
        print("error: \(error)")
    }
    return nil
}

struct ReadFileError: Error {}
struct ParsingError: Error {}

func readStub<T: Decodable>(forName: String, returnType: T.Type) throws -> T {
    guard let data = readLocalJSONFile(forName: forName) else {
        throw ReadFileError()
    }

    guard let person = parse(jsonData: data, returnType: returnType) else {
        throw ParsingError()
    }
    
    return person
}



*/
