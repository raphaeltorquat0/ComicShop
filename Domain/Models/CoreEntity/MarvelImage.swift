//
//  MarvelImage.swift
//  ComicVerseDomain
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation

public struct MarvelImage: Model {
    public static func == (lhs: MarvelImage, rhs: MarvelImage) -> Bool {
        return (lhs.path == rhs.path) && (lhs._extension == rhs._extension)
    }
    
    private enum CodingKeys: String, CodingKey {
        case path
        case `extension`
    }
    
    public var path: String?
    public var _extension: String?
    
    public init(path: String?, _extension: String?) {
        self.path = path
        self._extension = _extension
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.path = try container.decodeIfPresent(String.self, forKey: .path)
            self._extension = try container.decodeIfPresent(String.self, forKey: .extension)
        } catch {
            print("error:\(error.localizedDescription)")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(path, forKey: .path)
            try container.encode(_extension, forKey: .extension)
        } catch {
            print("error:\(error.localizedDescription)")
        }
    }
}
