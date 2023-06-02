//
//  Series.swift
//  ComicVerseDomain
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation

public struct SeriesModel: Model {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case resourceURI
        case urls
        case startYear
        case endYear
        case ratting
        case modified
        case thumbnail
        case comics
        case stories
        case events
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
    public var startYear: Int?
    public var endYear: Int?
    public var rating: String?
    public var modified: Date?
    public var thumbnail: MarvelImage?
    public var comics: Array<CommicsModel>?
    public var stories: Array<StoriesModel>?
    public var events: Array<EventsModel>?
    public var characters: Array<CharactersModel>?
    public var creators: Array<CreatorsModel>?
    public var next: Array<SeriesModel>?
    public var previous: Array<SeriesModel>?
    
    public init(id: Int?, title: String?, description: String?, resourceURI: String?, urls: Array<URL>?, startYear: Int?, endYear: Int?, rating: String?, modified: Date?, thumbnail: MarvelImage?, comics: Array<CommicsModel>?, stories: Array<StoriesModel>?, events: Array<EventsModel>?, characters: Array<CharactersModel>?, next: Array<SeriesModel>?, previous: Array<SeriesModel>?) {
        
        self.id = id
        self.title = title
        self.description = description
        self.resourceURI = resourceURI
        self.urls = urls
        self.startYear = startYear
        self.endYear = endYear
        self.rating = rating
        self.modified = modified
        self.thumbnail = thumbnail
        self.comics = comics
        self.stories = stories
        self.events = events
        self.characters = characters
        self.next = next
        self.previous = previous
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.id = try container.decodeIfPresent(Int.self, forKey: .id)
            self.title = try container.decodeIfPresent(String.self, forKey: .title)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.resourceURI = try container.decodeIfPresent(String.self, forKey: .resourceURI)
            self.urls = try container.decodeIfPresent([URL].self, forKey: .urls)
            self.startYear = try container.decodeIfPresent(Int.self, forKey: .startYear)
            self.endYear = try container.decodeIfPresent(Int.self, forKey: .endYear)
            self.rating = try container.decodeIfPresent(String.self, forKey: .ratting)
            self.modified = try container.decodeIfPresent(Date.self, forKey: .modified)
            self.thumbnail = try container.decodeIfPresent(MarvelImage.self, forKey: .thumbnail)
            self.comics = try container.decodeIfPresent([CommicsModel].self, forKey: .comics)
            self.stories = try container.decodeIfPresent([StoriesModel].self, forKey: .stories)
            self.events = try container.decodeIfPresent([EventsModel].self, forKey: .events)
            self.characters = try container.decodeIfPresent([CharactersModel].self, forKey: .characters)
            self.next = try container.decodeIfPresent([SeriesModel].self, forKey: .next)
            self.previous = try container.decodeIfPresent([SeriesModel].self, forKey: .previous)
        } catch {
            print("error:\(error.localizedDescription)")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encodeIfPresent(id, forKey: .id)
            try container.encodeIfPresent(title, forKey: .title)
            try container.encodeIfPresent(description, forKey: .description)
            try container.encodeIfPresent(resourceURI, forKey: .resourceURI)
            try container.encodeIfPresent(urls, forKey: .urls)
            try container.encodeIfPresent(startYear, forKey: .startYear)
            try container.encodeIfPresent(endYear, forKey: .endYear)
            try container.encodeIfPresent(rating, forKey: .ratting)
            try container.encodeIfPresent(modified, forKey: .modified)
            try container.encodeIfPresent(thumbnail, forKey: .thumbnail)
            try container.encodeIfPresent(comics, forKey: .comics)
            try container.encodeIfPresent(stories, forKey: .stories)
            try container.encodeIfPresent(events, forKey: .events)
            try container.encodeIfPresent(characters, forKey: .characters)
            try container.encodeIfPresent(next, forKey: .next)
            try container.encodeIfPresent(previous, forKey: .previous)
        } catch {
            print("error:\(error.localizedDescription)")
        }
    }
}
