import XCTest
import Presentation
import Data
import Domain

class ComicsPresenterTests: XCTestCase {
    func test_getComics_should_show_loading_before_and_hide_loading_after_getComicsModel() {
        let sut = makeSut()
        let viewModel = makeComicsViewModel()
        
        
    }
}


extension ComicsPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), comics: GetComicsSpy = GetComicsSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), file: StaticString = #file, line: UInt = #line) -> ComicsPresenter {
        let sut = ComicsPresenter(alertView: alertView, loadingView: loadingView, getComics: comics)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
