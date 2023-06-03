import XCTest
import Presentation
import Domain

class CreatorsPresenterTests: XCTestCase {
    func test_getCreators_should_show_loading_before_and_hide_loading_after_getCreatorsModel() {
        let (sut, creatorsSpy) = makeSut()
        let creatorsModel = makeCreatorsModel()
        sut.getCreatorsModel(creatorsModel)
        XCTAssertEqual(creatorsSpy.messages, [.showLoading, .hideLoading])
    }
    
    func test_getCreators_should_show_error_message_if_getCreatorsModel_fails() {
        let (sut, creatorsSpy) = makeSut()
        sut.getCreatorsModel(makeCreatorsModel())
        creatorsSpy.completeWithError(.unexpected)
        XCTAssertEqual(sut.alertViewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
    }
    
    func test_getCreators_should_show_creators_if_getCreatorsModel_succeeds() {
        let (sut, creatorsSpy) = makeSut()
        sut.getCreatorsModel(makeCreatorsModel())
        creatorsSpy.completeWithCreatorsModel(makeCreatorsModel())
        XCTAssertEqual(sut.creatorsViewModel, makeCreatorsViewModel())
    }
}

extension CreatorsPresenterTests {
    func makeSut() -> (sut: CreatorsPresenter, creatorsSpy: CreatorsSpy) {
        let creatorsSpy = CreatorsSpy()
        let sut = CreatorsPresenter(getCreators: creatorsSpy)
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: creatorsSpy)
        return (sut, creatorsSpy)
    }
}