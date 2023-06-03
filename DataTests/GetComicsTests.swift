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
            sut.getCommicsModel() {_ in }
            XCTAssertEqual(httpClientSpy.urls, [url])
        }
    }
    
    func test_get_comics_should_call_httpClient_with_correct_value() async throws {
        let (sut, httpClientSpy) = try await makeSUT()
        guard let makeComics = makeCommicsModel() else {
            XCTFail("Failed to create makeComicsModel")
            return
        }
        
            sut.getCommicsModel { [weak self] result in
            guard let self = self else {
                XCTFail("Self is deallocated")
                return
            }
            
            switch result {
            case .success(let comicsModel):
                do {
                    let comicsModelData = try JSONEncoder().encode(comicsModel)
                    let mockupValue = try JSONDecoder().decode(ComicsModel.self, from: comicsModelData)
                    XCTAssertEqual(mockupValue, comicsModel, "Expected comicsModel to be equal to mockupValue")
                } catch {
                    XCTFail("Failed to encode/decode comicsModel: \(error)")
                }
            case .failure(let error):
                XCTFail("Failed to get comicsModel: \(error)")
            }
        }
        
        XCTAssertEqual(httpClientSpy.getComics(), makeComics.toData(), "Expected httpClientSpy.getComics() to be equal to makeComics.toData()")
    }

    func test_get_comics_should_complete_with_error_if_completes_with_wrong_key() async throws {
        let (sut, httpClientSpy) = try await makeSUT()
        
        await expect(sut: sut, completeWith: .failure(.invalidCredentials), when: {
            httpClientSpy.completeWithError(.emptyParameter)
        })
    }
    
    func test_get_character_should_complete_with_error_if_completes_are_missing_key() async throws {
        let (sut, httpClientSpy) = try await makeSUT()
        
        await expect(sut: sut, completeWith: .failure(.invalidCredentials), when: {
            httpClientSpy.completeWithError(.emptyParameter)
        })
    }
    
    func test_get_comics_should_not_complete_if_sut_has_been_deallocated() async throws {
        let httpClientSpy = HTTPClientSpy()
        var sut: RemoteGetComics? = RemoteGetComics(url: makeURL(theme: "comics"), httpClient: httpClientSpy)
        var result: GetComics.Result?
        
        do {
            guard let comicsModel = makeCommicsModel() else {
                XCTFail("Failed to create makeCommicsModel")
                return
            }
            
            sut?.getCommicsModel { receivedResult in
                result = receivedResult
            }
            sut = nil
            
            // Delay the completion check to ensure the closure is not called immediately
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                httpClientSpy.completeWithError(.limitInvalidOrBellow1)
            }
            
            try await Task.sleep(nanoseconds: 10000) // Give enough time for potential completion
            
            XCTAssertNil(result, "Expected result to be nil")
        }
    }

}

extension GetComicsTests {
    
    func makeSUT(url: URL = URL(string: "https://any-url.com")!, file: StaticString = #file, line: UInt = #line) async throws -> (sut: RemoteGetComics, httpClientSpy: HTTPClientSpy) {
        let httpClientSpy = HTTPClientSpy()
        let sut = RemoteGetComics(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func expect(sut: RemoteGetComics, completeWith expectedResult: GetComics.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) async {
        let exp = expectation(description: "waiting...")
        guard let comicsModel = makeCommicsModel() else { return }
        
        sut.getCommicsModel { receivedResult in
            switch(expectedResult, receivedResult) {
            case(.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case(.success(let expectedComics), .success(let receivedComics)):
                XCTAssertEqual(expectedComics, receivedComics, file: file, line: line)
            default:
                XCTFail("-> Expected: \(expectedResult) \n -> -> Received: \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        await fulfillment(of: [exp], timeout: 1)
    }
}
