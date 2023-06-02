//
//  GetCreatorsModelFactory.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import Foundation
import Domain

func makeCreatorsModel() async throws -> CreatorsModel? {
    do {
        guard let creators = try LoadLocal.loadBundleContentCreators()  else { return nil }
        return creators
    } catch {
        print("error:\(error.localizedDescription)")
    }
    return nil
}

func getCreatorsModel() -> GetCreatorsModel {
    return GetCreatorsModel(hash: "hash_string", ts: Date(), apikey: "api_key")
}
