//
//  SupportsLocalDAta.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import Foundation
import Domain

struct ContentLoader {
    
    let comicMock = """
        {
          "id": 1234,
          "digitalId": 5678,
          "title": "Exemplo de Comic",
          "issueNumber": 1,
          "variantDescription": "Segunda edição",
          "description": "Descrição da comic",
          "modified": "2023-05-30T12:00:00Z",
          "isbn": "978-1-1234-5678-9",
          "upc": "123456789012",
          "diamondCode": "MAR180857",
          "ean": "9781123456789",
          "issn": "1234-5678",
          "format": "comic",
          "pageCount": 32,
          "textObjects": [
            {
              "type": "description",
              "language": "en",
              "text": "This is the description of the comic."
            },
            {
              "type": "summary",
              "language": "en",
              "text": "Summary of the comic."
            }
          ],
          "resourceURI": "http://example.com/comics/1234",
          "urls": [
            {
              "type": "detail",
              "url": "http://example.com/comics/1234/detail"
            },
            {
              "type": "purchase",
              "url": "http://example.com/comics/1234/purchase"
            }
          ],
          "series": {
            "resourceURI": "http://example.com/series/567",
            "name": "Example Series"
          },
          "variants": [
            {
              "resourceURI": "http://example.com/comics/1235",
              "name": "Variant Edition 1"
            },
            {
              "resourceURI": "http://example.com/comics/1236",
              "name": "Variant Edition 2"
            }
          ],
          "collections": [
            {
              "resourceURI": "http://example.com/collections/789",
              "name": "Collection 1"
            },
            {
              "resourceURI": "http://example.com/collections/790",
              "name": "Collection 2"
            }
          ],
          "collectedIssues": [
            {
              "resourceURI": "http://example.com/comics/1237",
              "name": "Collected Issue 1"
            },
            {
              "resourceURI": "http://example.com/comics/1238",
              "name": "Collected Issue 2"
            }
          ],
          "dates": [
            {
              "type": "onsaleDate",
              "date": "2023-06-01T00:00:00Z"
            },
            {
              "type": "focDate",
              "date": "2023-05-15T00:00:00Z"
            }
          ],
          "prices": [
            {
              "type": "printPrice",
              "price": 3.99
            },
            {
              "type": "digitalPrice",
              "price": 1.99
            }
          ],
          "thumbnail": {
            "path": "http://example.com/thumbnails/1234",
            "extension": "jpg"
          },
          "images": [
            {
              "path": "http://example.com/images/1234",
              "extension": "jpg"
            },
            {
              "path": "http://example.com/images/5678",
              "extension": "jpg"
            }
          ],
          "creators": {
            "available": 2,
            "collectionURI": "http://example.com/creators",
            "items": [
              {
                "resourceURI": "http://example.com/creators/123",
                "name": "John Doe",
                "role": "Writer"
              },
              {
                "resourceURI": "http://example.com/creators/456",
                "name": "Jane Smith",
                "role": "Artist"
              }
            ]
          },
          "characters": {
            "available": 3,
            "collectionURI": "http://example.com/characters",
            "items": [
              {
                "resourceURI": "http://example.com/characters/789",
                "name": "Superhero 1"
              },
              {
                "resourceURI": "http://example.com/characters/790",
                "name": "Superhero 2"
              },
              {
                "resourceURI": "http://example.com/characters/791",
                "name": "Superhero 3"
              }
            ]
          },
          "stories": {
            "available": 2,
            "collectionURI": "http://example.com/stories",
            "items": [
              {
                "resourceURI": "http://example.com/stories/123",
                "name": "Story 1",
                "type": "interior"
              },
              {
                "resourceURI": "http://example.com/stories/456",
                "name": "Story 2",
                "type": "cover"
              }
            ]
          },
          "events": {
            "available": 1,
            "collectionURI": "http://example.com/events",
            "items": [
              {
                "resourceURI": "http://example.com/events/123",
                "name": "Event 1"
              }
            ]
          }
        }
        
        """
    
    let characterMock = """
    {
      "id": 123,
      "name": "Iron Man",
      "description": "Billionaire genius, industrialist, and consummate playboy Tony Stark is the armored superhero known as Iron Man.",
      "modified": "2023-05-30T12:00:00Z",
      "resourceURI": "http://example.com/characters/123",
      "urls": [
        {
          "type": "detail",
          "url": "http://example.com/characters/123/detail"
        },
        {
          "type": "wiki",
          "url": "http://example.com/characters/123/wiki"
        }
      ],
      "thumbnail": {
        "path": "http://example.com/thumbnails/123",
        "extension": "jpg"
      },
      "comics": {
        "available": 10,
        "collectionURI": "http://example.com/characters/123/comics",
        "items": [
          {
            "resourceURI": "http://example.com/comics/1",
            "name": "Iron Man #1"
          },
          {
            "resourceURI": "http://example.com/comics/2",
            "name": "Iron Man #2"
          }
        ]
      },
      "stories": {
        "available": 5,
        "collectionURI": "http://example.com/characters/123/stories",
        "items": [
          {
            "resourceURI": "http://example.com/stories/1",
            "name": "Iron Man Origin"
          },
          {
            "resourceURI": "http://example.com/stories/2",
            "name": "Armor Wars"
          }
        ]
      },
      "events": {
        "available": 3,
        "collectionURI": "http://example.com/characters/123/events",
        "items": [
          {
            "resourceURI": "http://example.com/events/1",
            "name": "Avengers Disassembled"
          },
          {
            "resourceURI": "http://example.com/events/2",
            "name": "Civil War"
          }
        ]
      },
      "series": {
        "available": 2,
        "collectionURI": "http://example.com/characters/123/series",
        "items": [
          {
            "resourceURI": "http://example.com/series/1",
            "name": "Iron Man Vol. 1"
          },
          {
            "resourceURI": "http://example.com/series/2",
            "name": "Iron Man Vol. 2"
          }
        ]
      }
    }
    
    """
    
    let creatorsMock = """
        {
          "id": 123,
          "firstName": "John",
          "middleName": "M.",
          "lastName": "Doe",
          "suffix": "Jr.",
          "fullName": "John M. Doe Jr.",
          "modified": "2023-05-30T12:00:00Z",
          "resourceURI": "http://example.com/creators/123",
          "urls": [
            {
              "type": "detail",
              "url": "http://example.com/creators/123/detail"
            },
            {
              "type": "wiki",
              "url": "http://example.com/creators/123/wiki"
            }
          ],
          "thumbnail": {
            "path": "http://example.com/thumbnails/123",
            "extension": "jpg"
          },
          "series": {
            "available": 5,
            "collectionURI": "http://example.com/creators/123/series",
            "items": [
              {
                "resourceURI": "http://example.com/series/1",
                "name": "Series 1"
              },
              {
                "resourceURI": "http://example.com/series/2",
                "name": "Series 2"
              }
            ]
          },
          "stories": {
            "available": 10,
            "collectionURI": "http://example.com/creators/123/stories",
            "items": [
              {
                "resourceURI": "http://example.com/stories/1",
                "name": "Story 1"
              },
              {
                "resourceURI": "http://example.com/stories/2",
                "name": "Story 2"
              }
            ]
          },
          "comics": {
            "available": 15,
            "collectionURI": "http://example.com/creators/123/comics",
            "items": [
              {
                "resourceURI": "http://example.com/comics/1",
                "name": "Comic 1"
              },
              {
                "resourceURI": "http://example.com/comics/2",
                "name": "Comic 2"
              }
            ]
          },
          "events": {
            "available": 3,
            "collectionURI": "http://example.com/creators/123/events",
            "items": [
              {
                "resourceURI": "http://example.com/events/1",
                "name": "Event 1"
              },
              {
                "resourceURI": "http://example.com/events/2",
                "name": "Event 2"
              }
            ]
          }
        }
    """
}
 

struct LoadLocal {
    enum Error: Swift.Error {
            case fileNotFound(name: String)
            case fileDecodingFailed(name: String, Swift.Error)
        }
        
        static func loadBundleContentComics() throws -> ComicsModel? {
            
            do {
                let data = ContentLoader.init().comicMock.data(using: .utf8)!
                let decoder = try JSONDecoder().decode(ComicsModel.self, from: data)
                return  decoder
            } catch {
                throw Error.fileDecodingFailed(name: ContentLoader.init().comicMock, error)
            }
        }
        
        static func loadBundleContentCharacters() throws -> CharactersModel? {
            do {
                let data = ContentLoader.init().characterMock.data(using: .utf8)!
                let decoder = try JSONDecoder().decode(CharactersModel.self, from: data)
                return  decoder
            } catch {
                throw Error.fileDecodingFailed(name: type(of: ContentLoader()).init().characterMock, error)
            }
        }
    
    static func loadBundleContentCreators() throws -> CreatorsModel? {
        do {
            let data = ContentLoader.init().creatorsMock.data(using: .utf8)!
            let decoder = try JSONDecoder().decode(CreatorsModel.self, from: data)
            return decoder
        } catch {
            throw Error.fileDecodingFailed(name: type(of: ContentLoader()).init().creatorsMock, error)
        }
    }
}


