//
//  Comics.swift
//  ComicVerseDomain
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation

public struct CommicsModel: Model {
    public static func == (lhs: CommicsModel, rhs: CommicsModel) -> Bool {
        return (lhs.id == rhs.id) && (lhs.digitalId == rhs.digitalId) && (lhs.title == rhs.title) && (lhs.issueNumber == rhs.issueNumber) && (lhs.variantDescription == rhs.variantDescription) && (lhs.description == rhs.description) && (lhs.modified == rhs.modified) && (lhs.isbn == rhs.isbn) && (lhs.diamondCode == rhs.diamondCode) && (lhs.ean == rhs.ean) && ((lhs.issn != nil) && (rhs.issn != nil)) && (lhs.format == rhs.format) && (lhs.pageCount == rhs.pageCount) && (lhs.textObjects == rhs.textObjects) && (lhs.resourceURI == rhs.resourceURI) && (lhs.urls == rhs.urls) && (lhs.series == rhs.series) && (lhs.variants == rhs.variants) && (lhs.collections == rhs.collections) && (lhs.collectedIssues == rhs.collectedIssues) && (lhs.dates == rhs.dates) && (lhs.prices == rhs.prices) && (lhs.thumbnail == rhs.thumbnail) && (lhs.images == rhs.images) && (lhs.creators == rhs.creators) && (lhs.characters == rhs.characters) && (lhs.stories == rhs.stories) && (lhs.events == rhs.events)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case digitalId
        case title
        case issueNumber
        case variantDescription
        case description
        case modified
        case isbn
        case diamondCode
        case ean
        case issn
        case format
        case pageCount
        case textObjects
        case resourceURI
        case urls
        case series
        case variants
        case collections
        case collectedIssues
        case dates
        case prices
        case thumbnail
        case images
        case creators
        case characters
        case stories
        case events
    }
    
    public var id: Int?
    public var digitalId: Int?
    public var title: String?
    public var issueNumber: Int?
    public var variantDescription: String?
    public var description: String?
    public var modified: Date?
    public var isbn: String?
    public var diamondCode: String?
    public var ean: String?
    public var issn: String?
    public var format: String?
    public var pageCount: Int?
    public var textObjects: Array<TextObject>?
    public var resourceURI: String?
    public var urls: Array<URL>?
    public var series: Array<SeriesModel>?
    public var variants: Array<CommicsModel>?
    public var collections: Array<CommicsModel>?
    public var collectedIssues: Array<CommicsModel>?
    public var dates: Array<Date>?
    public var prices: [Bool]?
    public var thumbnail: MarvelImage?
    public var images: Array<MarvelImage>?
    public var creators: Array<CreatorsModel>?
    public var characters: Array<CharactersModel>?
    public var stories: Array<StoriesModel>?
    public var events: Array<EventsModel>?
    
    public init(id: Int?, digitalId: Int?, title: String?, issueNumber: Int?, variantDescription: String?, description: String?, modified: Date?, isbn: String?, diamondCode: String?, ean: String?, issn: String?, format: String?, pageCount: Int?, textObjects: Array<TextObject>?, resourceURI: String?, urls: Array<URL>?, series: Array<SeriesModel>?, variants: Array<CommicsModel>?, collections: Array<CommicsModel>?, collectedIssues: Array<CommicsModel>?, dates: Array<Date>?, prices: [Bool]?, thumbnail: MarvelImage?, images: Array<MarvelImage>?, creators: Array<CreatorsModel>?, characters: Array<CharactersModel>?, stories: Array<StoriesModel>?, events: Array<EventsModel>?) throws {
        
        self.id = id
        self.digitalId = digitalId
        self.title = title
        self.issueNumber = issueNumber
        self.variantDescription = variantDescription
        self.description = description
        self.modified = modified
        self.isbn = isbn
        self.diamondCode = diamondCode
        self.ean = ean
        self.issn = issn
        self.format = format
        self.pageCount = pageCount
        self.textObjects = textObjects
        self.resourceURI = resourceURI
        self.urls = urls
        self.series = series
        self.variants = variants
        self.collections = collections
        self.collectedIssues = collectedIssues
        self.dates = dates
        self.prices = prices
        self.thumbnail = thumbnail
        self.images = images
        self.creators = creators
        self.characters = characters
        self.stories = stories
        self.events = events
    }
    
     public init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)
         do {
             id = try decoder.decode(Int.self, forKey: .id)
             digitalId = try decoder.decode(Int.self, forKey: .digitalId)
             title = try decoder.decode(String.self, forKey: .title)
             issueNumber = try decoder.decode(Int.self, forKey: .issueNumber)
             variantDescription = try decoder.decode(String.self, forKey: .variantDescription)
             description = try decoder.decode(String.self, forKey: .description)
             modified = try decoder.decode(Date.self, forKey: .modified)
             isbn = try decoder.decode(String.self, forKey: .isbn)
             diamondCode = try decoder.decode(String.self, forKey: .diamondCode)
             ean = try decoder.decode(String.self, forKey: .ean)
             issn = try decoder.decode(String.self, forKey: .issn)
             format = try decoder.decode(String.self, forKey: .format)
             pageCount = try decoder.decode(Int.self, forKey: .pageCount)
             textObjects = try decoder.decode([TextObject].self, forKey: .textObjects)
             resourceURI = try decoder.decode(String.self, forKey: .resourceURI)
             urls = try decoder.decode([URL].self, forKey: .urls)
             series = try decoder.decode([SeriesModel].self, forKey: .series)
             variants = try decoder.decode([CommicsModel].self, forKey: .variants)
             collections = try decoder.decode([CommicsModel].self, forKey: .collections)
             collectedIssues = try decoder.decode([CommicsModel].self, forKey: .collectedIssues)
             dates = try decoder.decode([Date].self, forKey: .dates)
             prices = try decoder.decode([Bool].self, forKey: .prices)
             thumbnail = try decoder.decode(MarvelImage.self, forKey: .thumbnail)
             images = try decoder.decode([MarvelImage].self, forKey: .images)
             creators = try decoder.decode([CreatorsModel].self, forKey: .creators)
             characters = try decoder.decode([CharactersModel].self, forKey: .characters)
             stories = try decoder.decode([StoriesModel].self, forKey: .stories)
             events = try decoder.decode([EventsModel].self, forKey: .events)
         } catch {
             print("error:\(error.localizedDescription)")
         }
    }
}


public struct TextObject: Model {
    
    
    public var type: String?
    public var url: String?
    
    public init(type: String?, url: String) {
        self.type = type
        self.url = url
    }
}
