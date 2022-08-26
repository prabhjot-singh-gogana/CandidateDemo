//
//  PSJsonEncDec.swift
//  ArticleDemo
//
//  Created by Prabhjot Singh Gogana on 14/7/2022.
//

import Foundation

// Json decoding for converting object to json and json to object  throgh Codable
public protocol PSJsonDecoding {
    associatedtype PSMapperModel
    static func decode(object: Any) -> PSMapperModel?
    static func arrayDecoding(object: Any) -> [PSMapperModel]?
    static func decode(with data: Data) -> PSMapperModel?
}

public extension PSJsonDecoding where PSMapperModel: Codable {
//    decodes Any Object into data and change into array of mapable object
    static func arrayDecoding(object: Any) -> [PSMapperModel]? {
        do {
            let json = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedObject = try? decoder.decode([PSMapperModel].self, from: json)
            return decodedObject
        } catch {
            return nil
        }
    }

//    decodes Any Object into data and change into mapable object
    static func decode(object: Any) -> PSMapperModel? {
        do {
            let json = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedObject = try? decoder.decode(PSMapperModel.self, from: json)
            return decodedObject
        } catch {
            return nil
        }
    }
//    decodes the data  into mapable object
    static func decode(with data: Data) -> PSMapperModel? {
        return try? JSONDecoder().decode(PSMapperModel.self, from: data)
    }
}

extension Encodable {
/// Converting object to postable dictionary
    func toJSON(_ encoder: JSONEncoder = JSONEncoder()) -> [String: Any]? {
        guard let data = try? encoder.encode(self) else { return nil }
        let object = try? JSONSerialization.jsonObject(with: data)
        guard let json = object as? [String: Any] else {
            return nil
        }
        return json
    }
}

