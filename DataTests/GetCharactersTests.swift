//
//  GetCharactersTests.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import XCTest
import Domain

final class GetCharactersTests: XCTestCase {

    func test_get_character_should_call_httpClient_with_correct_url() async throws {
        let url = makeURL(theme: "characters")
        let (sut, httpClientSpy) = try await makeSUT(url: url)
        do {
            guard let makeCharacters = try await makeCharactersModel() else { return }
            sut.getCharactersModel(makeCharacters) { _ in }
            XCTAssertEqual(httpClientSpy.urls, [url])
        } catch {
            print("error..\(error.localizedDescription)")
        }
        
    }
    
    func test_get_character_should_call_httpClient_with_correct_value() async throws {
        let (sut, httpClientSpy) = try await makeSUT()
        do {
            guard let charactersModel = try await makeCharactersModel() else { return }
            
            sut.getCharactersModel(charactersModel) { _ in }
            XCTAssertEqual(httpClientSpy.getCharacters(), charactersModel.toData())
        } catch {
            print("error..\(error.localizedDescription)")
        }
    }
    
    func test_get_characte_should_complete_with_error_if_completes_with_wrong_key() async throws {
        let (sut, httpClientSpy) = try await makeSUT()
//        let httpClientSpy = HTTPClientSpy()
        do {
            try? await expect(sut, completeWith: .failure(.invalidCredentials), when: {
                httpClientSpy.completeWithError(.emptyParameter)
            })
        }
    }
    
    func test_get_character_should_complete_with_error_if_completes_are_missing_key() async throws {
        let (sut, httpClientSpy) = try await makeSUT()
        
        do {
            try await expect(sut, completeWith: .failure(.invalidCredentials)) {
                httpClientSpy.completeWithError(.emptyParameter)
            }
        } catch {
            print("error..\(error.localizedDescription)")
        }
    }
    
    func test_get_character_should_not_complete_if_sut_has_been_deallocated() async throws {
        let httpClientSpy = HTTPClientSpy()
        var sut: RemoteGetCharacters? = RemoteGetCharacters(url: makeURL(theme: "characters"), httpClient: httpClientSpy)
        var result: RemoteGetCharacters.Result?
        do {
            guard let charactersModel = try await makeCharactersModel() else { return }
            sut?.getCharactersModel(charactersModel) { result = $0 }
            sut = nil
            httpClientSpy.completeWithError(.unexpected)
            XCTAssertNil(result)
        }
    }
}


extension GetCharactersTests {
    
    func makeSUT(url: URL = URL(string: "https://any-uyrl.com")!, file: StaticString = #file, line: UInt = #line) async throws -> (sut: RemoteGetCharacters, httpClientSpy: HTTPClientSpy) {
        let httpClientSpy = HTTPClientSpy()
        let sut = RemoteGetCharacters(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteGetCharacters, completeWith expectedResult: GetCharacters.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) async throws {
        let exp = expectation(description: "waiting...")
        do {
            try await sut.getCharactersModel(makeCharactersModel()!) { receivedResult in
            switch(expectedResult, receivedResult) {
            case(.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedCharacters), .success(let receivedCharacters)):
                XCTAssertEqual(expectedCharacters, receivedCharacters, file:  file, line:  line)
            default:
                XCTFail("-> Expected: \(expectedResult) \n -> -> Received: \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
            action()
//            wait(for: [exp], timeout: 1)
            await fulfillment(of: [exp], timeout: 1)
        } catch {
            print("error...\(error.localizedDescription)")
        }
    }
}
