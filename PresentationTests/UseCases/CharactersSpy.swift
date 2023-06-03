import Foundation
import Domain

class CharactersSpy: GetCharacters {
    var charactersModel: CharactersModel?
    var completion: ((GetCharacters.Result) -> Void)?
    
    func getCharactersModel(_ charactersModel: CharactersModel, completion: @escaping (GetCharacters.Result) -> Void) {
        self.charactersModel = charactersModel
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainErrors) {
        completion?(.failure(error))
    }
    
    func completeWithCharactersModel(_ charactersModel: CharactersModel) {
        completion?(.success(charactersModel))
    }
}