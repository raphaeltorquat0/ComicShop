import Foundation
import Domain

class ComicsSpy: GetComics {
    var comicsModel: ComicsModel?
    var completion: ((GetComics.Result) -> Void)?
    
    func getComicsModel(_ comicsModel: ComicsModel, completion: @escaping (GetComics.Result) -> Void) {
        self.comicsModel = comicsModel
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainErrors) {
        completion?(.failure(error))
    }
    
    func completeWithComicsModel(_ comicsModel: ComicsModel) {
        completion?(.success(comicsModel))
    }
}