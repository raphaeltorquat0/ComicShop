//
//  Stories.swift
//  ComicVerseDomain
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation

public struct StoriesModel: Model {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case resourceURI
        case type
        case modified
        case thumbnail
        case comics
        case series
        case events
        case characters
        case creators
        case originalIssue
    }
    
    public var id: Int?
    public var title: String?
    public var description: String?
    public var resourceURI: String?
    public var type: String?
    public var modified: Date?
    public var thumbnail: MarvelImage?
    public var comics: Array<CommicsModel>?
    public var series: Array<SeriesModel>?
    public var events: Array<EventsModel>?
    public var characters: Array<CharactersModel>?
    public var creators: Array<CreatorsModel>?
    public var originalIssue: CommicsModel?
    
    public init(id: Int?, title: String?, description: String?, resourceURI: String?, type: String?, modified: Date?, thumbnail: MarvelImage?, comics: Array<CommicsModel>?, series: Array<SeriesModel>?, events: Array<EventsModel>?, characters: Array<CharactersModel>?, creators: Array<CreatorsModel>?, originalIssue: CommicsModel?) throws {
        self.id = id
        self.title = title
        self.description = description
        self.resourceURI = resourceURI
        self.type = type
        self.modified = modified
        self.thumbnail = thumbnail
        self.comics = comics
        self.series = series
        self.events = events
        self.characters = characters
        self.creators = creators
        self.originalIssue = originalIssue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.id = try container.decodeIfPresent(Int.self, forKey: .id)
            self.title = try container.decodeIfPresent(String.self, forKey: .title)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.resourceURI = try container.decodeIfPresent(String.self, forKey: .resourceURI)
            self.type = try container.decodeIfPresent(String.self, forKey: .type)
            self.modified = try container.decodeIfPresent(Date.self, forKey: .modified)
            self.thumbnail = try container.decodeIfPresent(MarvelImage.self, forKey: .thumbnail)
            self.comics = try container.decodeIfPresent([CommicsModel].self, forKey: .comics)
            self.series = try container.decodeIfPresent([SeriesModel].self, forKey: .series)
            self.events = try container.decodeIfPresent([EventsModel].self, forKey: .events)
            self.characters = try container.decodeIfPresent([CharactersModel].self, forKey: .characters)
            self.creators = try container.decodeIfPresent([CreatorsModel].self, forKey: .creators)
            self.originalIssue = try container.decodeIfPresent(CommicsModel.self, forKey: .originalIssue)
        } catch {
            print("error:\(error.localizedDescription)")
        }
    }
}
