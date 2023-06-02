//
//  GetCharactersModelFactory.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import Foundation
import Domain


func makeCharactersModel() async throws -> CharactersModel? {
    
    do {
        guard let characters = try  LoadLocal.loadBundleContentCharacters() else { return nil }
        return characters
    } catch {
        print("error: \(error.localizedDescription)")
    }
    return nil
}

func getCharactersModel() -> GetCharactersModel {
    return GetCharactersModel(hash: "hash_string", ts: Date(), apikey: "api_key")
}
