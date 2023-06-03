import Foundation
import Presentation 


func makeCharactersViewModel(hash: String? = "any_hash", ts: Date? = Date(), apiKey: String? = "any_apiKey")  ->  GetCharactersRequest {
    return GetCharactersRequest(hash: hash, ts: ts, apiKey: apiKey)
}

func makeCreatorsViewModel(hash: String? = "any_hash", ts: Date? = Date(), apiKey: String? = "any_apiKey") -> GetCreatorsRequest {
    return GetCreatorsRequest(hash: hash, ts: ts, apiKey: apiKey)
}

func makeComics(hash: String? = "any_hash", ts: Date? = Date(), apiKey: String? = "any_apiKey") -> GetComicsRequest {
    return GetComicsRequest(hash: hash, ts: ts, apiKey: apiKey)
}