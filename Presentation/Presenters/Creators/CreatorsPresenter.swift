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
    private (set) var creators: CreatorsModel?
    
    public init(alertView: AlertView, loadingView: LoadingView, getCreators: GetCreators) {
        self.alertView = alertView
        self.loadingView = loadingView
        self.getCreators = getCreators
        self.loadCreators()
    }
    
    private func loadCreators() {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        getCreators.getCreators { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente mais tarde."))
                print("Error..\(error.localizedDescription)")
                break
            case .success(let creators):
                self.loadingView.display(viewModel: LoadingViewModel.init(isLoading: false))
                self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Carregado com sucesso"))
                self.creators = creators
                break
            }
        }
    }
    
    public func fetchCreators() -> CreatorsModel? {
        if self.creators != nil {
            return self.creators
        } else {
            return nil
        }
    }
    
}
