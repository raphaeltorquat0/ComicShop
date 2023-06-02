//
//  Creators.swift
//  ComicVerseDomain
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation

public struct CreatorsModel: Model {
    public static func == (lhs: CreatorsModel, rhs: CreatorsModel) -> Bool {
        return (lhs.id == rhs.id) && (lhs.firstName == rhs.firstName) && ((lhs.lastName != nil) && (rhs.lastName != nil)) && ((lhs.suffix != nil) && (rhs.suffix != nil)) && (lhs.fullName == rhs.fullName) && (lhs.modified == rhs.modified) && (lhs.resourceURI == rhs.resourceURI) && (lhs.urls == rhs.urls) && (lhs.thumbnail == rhs.thumbnail) && (lhs.series == rhs.series) && (lhs.stories == rhs.stories)
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case suffix
        case fullName
        case modified
        case resourceURI
        case urls
        case thumbnail
        case series
        case stories
        case commics
        case events
    }
    
    public var id: Int?
    public var firstName: String?
    public var middleName: String?
    public var lastName: String?
    public var suffix: String?
    public var fullName: String?
    public var modified: Date?
    public var resourceURI: String?
    public var urls: Array<URL>?
    public var thumbnail: MarvelImage?
    public var series: Array<SeriesModel>?
    public var stories: Array<StoriesModel>?
    public var commics: Array<CommicsModel>?
    public var events: Array<EventsModel>?
    
    public init(id: Int?, firstName: String?, middleName: String?, lastName: String?, suffix: String?, fullName: String?, modified: Date?, resourceURI: String?, urls: Array<URL>?, thumbnail: MarvelImage?, series: Array<SeriesModel>?, stories: Array<StoriesModel>?, commics: Array<CommicsModel>?, events: Array<EventsModel>?) throws {
        self.id = id
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.suffix = suffix
        self.fullName = fullName
        self.modified = modified
        self.resourceURI = resourceURI
        self.urls = urls
        self.thumbnail = thumbnail
        self.series = series
        self.commics = commics
        self.events = events
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.id = try container.decodeIfPresent(Int.self, forKey: .id)
            self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
            self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
            self.suffix = try container.decodeIfPresent(String.self, forKey: .suffix)
            self.fullName = try container.decodeIfPresent(String.self, forKey: .fullName)
            self.modified = try container.decodeIfPresent(Date.self, forKey: .modified)
            self.resourceURI = try container.decodeIfPresent(String.self, forKey: .resourceURI)
            self.urls = try container.decodeIfPresent([URL].self, forKey: .urls)
            self.thumbnail = try container.decodeIfPresent(MarvelImage.self, forKey: .thumbnail)
            self.series = try container.decodeIfPresent([SeriesModel].self, forKey: .series)
            self.stories = try container.decodeIfPresent([StoriesModel].self, forKey: .stories)
            self.commics = try container.decodeIfPresent([CommicsModel].self, forKey: .commics)
            self.events = try container.decodeIfPresent([EventsModel].self, forKey: .events)
        } catch {
            print("error:\(error.localizedDescription)")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encodeIfPresent(self.id, forKey: .id)
            try container.encodeIfPresent(self.firstName, forKey: .firstName)
            try container.encodeIfPresent(self.lastName, forKey: .lastName)
            try container.encodeIfPresent(self.suffix, forKey: .suffix)
            try container.encodeIfPresent(self.fullName, forKey: .fullName)
            try container.encodeIfPresent(self.modified, forKey: .modified)
            try container.encodeIfPresent(self.resourceURI, forKey: .resourceURI)
            try container.encodeIfPresent(self.urls, forKey: .urls)
            try container.encodeIfPresent(self.thumbnail, forKey: .thumbnail)
            try container.encodeIfPresent(self.series, forKey: .series)
            try container.encodeIfPresent(self.stories, forKey: .stories)
            try container.encodeIfPresent(self.commics, forKey: .commics)
            try container.encodeIfPresent(self.events, forKey: .events)
        } catch {
            print("error:\(error.localizedDescription)")
        }
    }
}
