//
//  Characters.swift
//  ComicVerseDomain
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation

public struct CharactersModel: Model {
    public static func == (lhs: CharactersModel, rhs: CharactersModel) -> Bool {
        return (lhs.id == rhs.id) && (lhs.name == rhs.name) && (lhs.description == rhs.description) && (lhs.modified == rhs.modified) && ((lhs.resourceURI != nil) && (rhs.resourceURI != nil)) && (lhs.urls == rhs.urls) && (lhs.thumbnail == rhs.thumbnail) && (lhs.comics == rhs.comics) && (lhs.stories == rhs.stories) && (lhs.events == rhs.events) && (lhs.series == rhs.series)
    }
    
    public var id: Int?
    public var name: String?
    public var description: String?
    public var modified: Date?
    public var resourceURI: String?
    public var urls: Array<URL>?
    public var thumbnail: MarvelImage?
    public var comics: Array<ComicsModel>?
    public var stories: Array<StoriesModel>?
    public var events: Array<EventsModel>?
    public var series: Array<SeriesModel>?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case modified
        case resourceURI
        case urls
        case thumbnail
        case comics
        case stories
        case events
        case series
    }
    
    public init(id: Int?, name: String?, description: String?, modified: Date?, resourceURI: String?, urls: Array<URL>?, thumbnail: MarvelImage?, comics: Array<ComicsModel>?, stories: Array<StoriesModel>?, events: Array<EventsModel>?, series: Array<SeriesModel>?) {
        self.id = id
        self.name = name
        self.description = description
        self.modified = modified
        self.resourceURI = resourceURI
        self.urls = urls
        self.thumbnail = thumbnail
        self.comics = comics
        self.stories = stories
        self.events = events
        self.series = series
    }
    
    public init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)
        do {
            id = try decoder.decode(Int.self, forKey: .id)
            name = try decoder.decode(String.self, forKey: .name)
            description = try decoder.decode(String.self, forKey: .description)
            modified = try decoder.decode(Date.self, forKey: .modified)
            resourceURI = try decoder.decode(String.self, forKey: .resourceURI)
            urls = try decoder.decode([URL].self, forKey: .urls)
            thumbnail = try decoder.decode(MarvelImage.self, forKey: .thumbnail)
            comics = try decoder.decode([ComicsModel].self, forKey: .comics)
            stories = try decoder.decode([StoriesModel].self, forKey: .stories)
            events = try decoder.decode([EventsModel].self, forKey: .events)
            series = try decoder.decode([SeriesModel].self, forKey: .series)
        } catch {
            print("error:\(error.localizedDescription)")
        }
    }
}
