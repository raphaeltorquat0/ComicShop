import XCTest
import Presentation
import Domain

class CharactersPresenterTests: XCTestCase {
    func test_getCharacters_should_show_loading_before_and_hide_loading_after_getCharactersModel() {
        let (sut, charactersSpy) = makeSut()
        let charactersModel = makeCharactersModel()
        sut.getCharactersModel(charactersModel)
        XCTAssertEqual(charactersSpy.messages, [.showLoading, .hideLoading])
    }
    
    func test_getCharacters_should_show_error_message_if_getCharactersModel_fails() {
        let (sut, charactersSpy) = makeSut()
        sut.getCharactersModel(makeCharactersModel())
        charactersSpy.completeWithError(.unexpected)
        XCTAssertEqual(sut.alertViewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
    }
    
    func test_getCharacters_should_show_characters_if_getCharactersModel_succeeds() {
        let (sut, charactersSpy) = makeSut()
        sut.getCharactersModel(makeCharactersModel())
        charactersSpy.completeWithCharactersModel(makeCharactersModel())
        XCTAssertEqual(sut.charactersViewModel, makeCharactersViewModel())
    }
}

extension CharactersPresenterTests {
    func makeSut() -> (sut: CharactersPresenter, charactersSpy: CharactersSpy) {
        let charactersSpy = CharactersSpy()
        let sut = CharactersPresenter(getCharacters: charactersSpy)
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: charactersSpy)
        return (sut, charactersSpy)
    }
}