//
//  CharactersPresenter.swift
//  Presentation
//
//  Created by Raphael Torquato on 02/06/23.
//

import Foundation
import Domain

public final class CharactersPresenter {
    private let alertView: AlertView
    private let loadingView: LoadingView
    private let getCharacters: GetCharacters
    private (set) var characters: CharactersModel?
    
    public init(alertView: AlertView, loadingView: LoadingView, getCharacters: GetCharacters) {
        self.alertView = alertView
        self.loadingView = loadingView
        self.getCharacters = getCharacters
        self.loadCharacters()
    }
    
    public func loadCharacters() {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        getCharacters.getCharactersModel { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente mais tarde."))
                print("Error..\(error.localizedDescription)")
                
            case .success(let characters):
                self.loadingView.display(viewModel: LoadingViewModel.init(isLoading: false))
                self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Carregado com sucesso"))
                self.characters = characters
            }
        }
    }
    public func fetchCharacters() -> CharactersModel? {
        if self.characters != nil {
            return self.characters
        } else {
            return nil
        }
    }
    
}
