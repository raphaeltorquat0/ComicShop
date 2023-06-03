import XCTest
import Presentation
import Domain

class ComicsPresenterTests: XCTestCase {
    func test_getComics_should_show_loading_before_and_hide_loading_after_getComicsModel() {
        let (sut, comicsSpy) = makeSut()
        let comicsModel = makeComicsModel()
        sut.getComicsModel(comicsModel)
        XCTAssertEqual(comicsSpy.messages, [.showLoading, .hideLoading])
    }
    
    func test_getComics_should_show_error_message_if_getComicsModel_fails() {
        let (sut, comicsSpy) = makeSut()
        sut.getComicsModel(makeComicsModel())
        comicsSpy.completeWithError(.unexpected)
        XCTAssertEqual(sut.alertViewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
    }
    
    func test_getComics_should_show_comics_if_getComicsModel_succeeds() {
        let (sut, comicsSpy) = makeSut()
        sut.getComicsModel(makeComicsModel())
        comicsSpy.completeWithComicsModel(makeComicsModel())
        XCTAssertEqual(sut.comicsViewModel, makeComicsViewModel())
    }
}

extension ComicsPresenterTests {
    func makeSut() -> (sut: ComicsPresenter, comicsSpy: ComicsSpy) {
        let comicsSpy = ComicsSpy()
        let sut = ComicsPresenter(getComics: comicsSpy)
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: comicsSpy)
        return (sut, comicsSpy)
    }
}