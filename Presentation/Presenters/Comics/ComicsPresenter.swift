//
//  ComicsPresenter.swift
//  Presentation
//
//  Created by Raphael Torquato on 02/06/23.
//

import Foundation
import Domain

public final class ComicsPresenter {
    private let alertView: AlertView
    private let loadingView: LoadingView
    private let getComics: GetComics
    
    public init(alertView: AlertView, loadingView: LoadingView, getComics: GetComics) {
        self.alertView = alertView
        self.loadingView = loadingView
        self.getComics = getComics
    }
    
    public func loadComics() {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        getComics.get { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente mais tarde."))
            case .success(let comics):
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Carregado com sucesso."))
            }
        }
    }
}