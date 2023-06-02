//
//  Events.swift
//  ComicVerseDomain
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation

public struct EventsModel: Model {
    public static func == (lhs: EventsModel, rhs: EventsModel) -> Bool {
        return (lhs.id == rhs.id) && (lhs.title == rhs.title) && (lhs.description == rhs.description) && (lhs.resourceURI == rhs.resourceURI) && (lhs.urls == rhs.urls) && (lhs.modified == rhs.modified) && (lhs.start == rhs.start) && (lhs.end == rhs.end) && (lhs.thumbnail == rhs.thumbnail) && (lhs.comics == rhs.comics) && (lhs.stories == rhs.stories) && (lhs.series == rhs.series) && (lhs.characters == rhs.characters) && (lhs.creators == rhs.creators) && (lhs.next == rhs.next) && (lhs.previous == rhs.previous)
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case resourceURI
        case urls
        case modified
        case start
        case end
        case thumbnail
        case comics
        case stories
        case series
        case characters
        case creators
        case next
        case previous
    }
    
    public var id: Int?
    public var title: String?
    public var description: String?
    public var resourceURI: String?
    public var urls: Array<URL>?
    public var modified: Date?
    public var start: Date?
    public var end: Date?
    public var thumbnail: MarvelImage?
    public var comics: Array<CommicsModel>?
    public var stories: Array<StoriesModel>?
    public var series: Array<SeriesModel>?
    public var characters: Array<CharactersModel>?
    public var creators: Array<CreatorsModel>?
    public var next: Array<EventsModel>?
    public var previous: Array<EventsModel>?
    
    public init(id: Int?, title: String?, description: String?, resourceURI: String?, urls: Array<URL>?, modified: Date?, start: Date?, end: Date?, thumbnail: MarvelImage?, comics: Array<CommicsModel>?, stories: Array<StoriesModel>?, series: Array<SeriesModel>?, characters: Array<CharactersModel>?, creators: Array<CreatorsModel>?, next: Array<EventsModel>?, previous: Array<EventsModel>?) throws {
        self.id = id
        self.title = title
        self.description = description
        self.resourceURI = resourceURI
        self.urls = urls
        self.modified = modified
        self.start = start
        self.end = end
        self.thumbnail = thumbnail
        self.comics = comics
        self.stories = stories
        self.series = series
        self.characters = characters
        self.creators = creators
        self.next = next
        self.previous = previous
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.resourceURI = try container.decodeIfPresent(String.self, forKey: .resourceURI)
        self.urls = try container.decodeIfPresent([URL].self, forKey: .urls)
        self.modified = try container.decodeIfPresent(Date.self, forKey: .modified)
        self.start = try container.decodeIfPresent(Date.self, forKey: .start)
        self.end = try container.decodeIfPresent(Date.self, forKey: .end)
        self.thumbnail = try container.decodeIfPresent(MarvelImage.self, forKey: .thumbnail)
        self.comics = try container.decodeIfPresent([CommicsModel].self, forKey: .comics)
        self.stories = try container.decodeIfPresent([StoriesModel].self, forKey: .stories)
        self.series = try container.decodeIfPresent([SeriesModel].self, forKey: .series)
        self.characters = try container.decodeIfPresent([CharactersModel].self, forKey: .characters)
        self.creators = try container.decodeIfPresent([CreatorsModel].self, forKey: .creators)
        self.next = try container.decodeIfPresent([EventsModel].self, forKey: .next)
        self.previous = try container.decodeIfPresent([EventsModel].self, forKey: .previous)
    }
    
    public func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(self.id, forKey: .id)
            try container.encodeIfPresent(self.title, forKey: .title)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.resourceURI, forKey: .resourceURI)
            try container.encodeIfPresent(self.urls, forKey: .urls)
            try container.encodeIfPresent(self.modified, forKey: .modified)
            try container.encodeIfPresent(self.start, forKey: .start)
            try container.encodeIfPresent(self.end, forKey: .end)
            try container.encodeIfPresent(self.thumbnail, forKey: .thumbnail)
            try container.encodeIfPresent(self.comics, forKey: .comics)
            try container.encodeIfPresent(self.stories, forKey: .stories)
            try container.encodeIfPresent(self.series, forKey: .series)
            try container.encodeIfPresent(self.characters, forKey: .characters)
            try container.encodeIfPresent(self.creators, forKey: .creators)
            try container.encodeIfPresent(self.next, forKey: .next)
            try container.encodeIfPresent(self.previous, forKey: .previous)
        } catch {
            print("error:\(error.localizedDescription)")
        }
    }
}
