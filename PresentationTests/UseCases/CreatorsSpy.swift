import Foundation
import Domain

class CreatorsSpy: GetCreators {
    var creatorsModel: CreatorsModel?
    var completion: ((GetCreators.Result) -> Void)?
    
    func getCreatorsModel(_ creatorsModel: CreatorsModel, completion: @escaping (GetCreators.Result) -> Void) {
        self.creatorsModel = creatorsModel
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainErrors) {
        completion?(.failure(error))
    }
    
    func completeWithCreatorsModel(_ creatorsModel: CreatorsModel) {
        completion?(.success(creatorsModel))
    }
}