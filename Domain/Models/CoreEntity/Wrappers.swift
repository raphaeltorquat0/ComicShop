//
//  Wrappers.swift
//  ComicVerseDomain
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation

public struct WrappersModel: Model {
    
    private enum CodingKeys: String, CodingKey {
        case code
        case status
        case data
        case etag
        case copyright
        case attributionText
        case attributionHTML
    }
    
    public var code: Int?
    public var status: String?
    public var data: ContainerModel?
    public var etag: String?
    public var copyright: String?
    public var attributionText: String?
    public var attributionHTML: String?
    
    public init(code: Int?, status: String?, data: ContainerModel?, etag: String?, copyright: String?, attributionText: String?, attributionHTML: String?) throws {
        self.code = code
        self.status = status
        self.data = data
        self.etag = etag
        self.copyright = copyright
        self.attributionText = attributionText
        self.attributionHTML = attributionHTML
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.code = try container.decodeIfPresent(Int.self, forKey: .code)
            self.status = try container.decodeIfPresent(String.self, forKey: .status)
            self.data = try container.decodeIfPresent(ContainerModel.self, forKey: .data)
            self.etag = try container.decodeIfPresent(String.self, forKey: .etag)
            self.copyright = try container.decodeIfPresent(String.self, forKey: .copyright)
            self.attributionText = try container.decodeIfPresent(String.self, forKey: .attributionText)
            self.attributionHTML = try container.decodeIfPresent(String.self, forKey: .attributionHTML)
        } catch {
            print("error:\(error.localizedDescription)")
        }
    }
}
