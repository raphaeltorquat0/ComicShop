//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Raphael Torquato on 02/06/23.
//

import XCTest
@testable import Presentation
import Data

func makeComicsViewModel() -> GetComicsViewModel? {
    do {
        let comicsViewModel = GetComicsViewModel(model: try LoadLocal.loadBundleContentComics()!)
        return comicsViewModel
    } catch {
        print("error..\(error.localizedDescription)")
        return nil
    }
}

func makeCharactersViewModel() -> GetCharactersViewModel? {
    do {
        let charactersViewModel = GetCharactersViewModel(model: try LoadLocal.loadBundleContentCharacters()!)
        return charactersViewModel
    } catch {
        print("error..\(error.localizedDescription)")
        return nil
    }
}

func makeCreatorsToViewModel() -> GetCreatorsViewModel? {
    do {
        let creatorsViewModel = GetCreatorsViewModel(model: try LoadLocal.loadBundleContentCreators()!)
        return creatorsViewModel
    } catch {
        print("error..\(error.localizedDescription)")
        return nil
    }
    
}
