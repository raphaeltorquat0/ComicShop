//
//  CreatorsPresenter.swift
//  Presentation
//
//  Created by Raphael Torquato on 02/06/23.
//

import Foundation
import Domain

public final class CreatorsPresenter {
    private let alertView: AlertView
    private let loadingView: LoadingView
    private let getCreators: GetCreators
    
    public init(alertView: AlertView, loadingView: LoadingView, getCreators: GetCreators) {
        self.alertView = alertView
        self.loadingView = loadingView
        self.getCreators = getCreators
    }
    
    public func loadCreators() {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        getCreators.get { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente mais tarde."))
            case .success(let creators):
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Carregado com sucesso."))
            }
        }
    }
    
}
