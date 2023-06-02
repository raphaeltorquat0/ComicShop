//
//  GetComicsTests.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import Domain
import XCTest

final class GetComicsTests: XCTestCase {
    
    func test_get_comics_should_call_httpClient_with_correct_url() async throws {
        let url = makeURL(theme: "comics")
        let (sut, httpClientSpy) = try await makeSUT(url: url)
        do {
            guard let makeComics = makeCommicsModel() else { return }
            sut.get(getCommicsModel: makeComics) { _ in }
            XCTAssertEqual(httpClientSpy.urls, [url])
        }
    }
    
    func test_get_comics_should_call_httpClient_with_correct_value() async throws {
        let (sut, httpClientSpy) = try await makeSUT()
        do {
            guard let makeComics = makeCommicsModel() else { return }
            sut.get(getCommicsModel: makeComics) { _ in }
            XCTAssertEqual(httpClientSpy.getComics(), makeComics.toData())
        }
    }
    
    func test_get_comics_should_complete_with_error_if_completes_with_wrong_key() async throws {
        let (sut, httpClientSpy) = try await makeSUT()
        do {
             expect(sut, completeWith: .failure(.invalidCredentials), when: {
                httpClientSpy.completeWithError(.emptyParameter)
            })
            
        }
    }
    
    func test_get_character_should_complete_with_error_if_completes_are_missing_key() async throws {
        let (sut, httpClientSpy) = try await makeSUT()
        do {
            expect(sut, completeWith: .failure(.invalidCredentials), when: {
                httpClientSpy.completeWithError(.emptyParameter)
            })
        }
    }
    
    func test_get_comics_should_not_complete_if_sut_has_been_deallocated() async throws {
        let httpClientSpy = HTTPClientSpy()
        var sut: RemoteGetCommics? = RemoteGetCommics(url: makeURL(theme: "comics"), httpClient: httpClientSpy)
        var result: RemoteGetCommics.Result?
        do {
            guard let comicsModel = makeCommicsModel() else { return }
            sut?.get(getCommicsModel: comicsModel) { result = $0 }
            sut = nil
            httpClientSpy.completeWithError(.limitInvalidOrBellow1)
            XCTAssertNil(result)
        }
    }
}

extension GetComicsTests {
    
    func makeSUT(url: URL = URL(string: "https://any-url.com")!, file: StaticString = #file, line: UInt = #line) async throws -> (sut: RemoteGetCommics, httpClientSpy: HTTPClientSpy) {
        let httpClientSpy = HTTPClientSpy()
        let sut = RemoteGetCommics(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteGetCommics, completeWith expectedResult: GetCommics.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "waiting...")
        guard let comicsModel = makeCommicsModel() else { return }
        sut.get(getCommicsModel: comicsModel) { receivedResult in
            switch(expectedResult, receivedResult) {
            case(.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case(.success(let expectedCreators), .success(let receivedCreators)):
                XCTAssertEqual(expectedCreators, receivedCreators)
            default:
                XCTFail("-> Expected: \(expectedResult) \n -> -> Received: \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}
