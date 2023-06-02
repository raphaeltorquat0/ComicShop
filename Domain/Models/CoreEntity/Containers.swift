//
//  Containers.swift
//  ComicVerseDomain
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation

public struct ContainerModel: Model {
    public static func == (lhs: ContainerModel, rhs: ContainerModel) -> Bool {
        return (lhs.offset == rhs.offset) && (lhs.limit == rhs.limit) && (lhs.total == rhs.total) && (lhs.count == rhs.count)
    }
    
    private enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count

    }
    
    public var offset: Int?
    public var limit: Int?
    public var total: Int?
    public var count: Int?

    
    public init(offset: Int?, limit: Int?, total: Int?, count: Int?) throws {
        //, results: [any Model]?
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count

    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.offset = try container.decodeIfPresent(Int.self, forKey: .offset)
            self.limit = try container.decodeIfPresent(Int.self, forKey: .limit)
            self.total = try container.decodeIfPresent(Int.self, forKey: .total)
            self.count = try container.decodeIfPresent(Int.self, forKey: .count)

        } catch {
            print("error:\(error.localizedDescription)")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encodeIfPresent(offset, forKey: .offset)
            try container.encodeIfPresent(limit, forKey: .limit)
            try container.encodeIfPresent(total, forKey: .total)
            try container.encodeIfPresent(count, forKey: .count)

        } catch {
            print("error:\(error.localizedDescription)")
        }
    }
}
