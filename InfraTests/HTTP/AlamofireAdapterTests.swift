//
//  AlamofireAdapterTests.swift
//  ComicShop
//
//  Created by Raphael Torquato on 01/06/23.
//

import XCTest
import Alamofire
import Data
import Infra

class AlamofireAdapterTests: XCTestCase {
    func test_get_should_make_request_with_valid_url_and_method() {
        let url = makeURL(theme: "comics")
        testRequest { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("GET", request.httpMethod)
            XCTAssertNotNil(request.url)
        }
    }
    
    func test_get_should_make_request_without_data() {
        testRequest { request in
            XCTAssertNil(request.httpBodyStream)
        }
    }
    
    func test_get_should_complete_with_errror_when_request_completes_with_error() {
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: makeError()))
    }
    
    func test_get_should_complete_with_error_on_all_invalid_cases() {
        expectedResult(.failure(.noConnectivity), when: (data:HTTPClientSpy().getComics() , response: makeHTTPResponse(), error: makeError()))
        expectedResult(.failure(.noConnectivity), when: (data: HTTPClientSpy().getCharacters(), response: nil, error: makeError()))
        expectedResult(.failure(.noConnectivity), when: (data: HTTPClientSpy().getCreators(), response: nil, error: nil))
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: makeHTTPResponse(), error: makeError()))
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: makeHTTPResponse(), error: nil))
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: nil))
    }
    
    func test_get_should_complete_with_data_when_request_completes_with_200() {
        expectedResult(.success(HTTPClientSpy().getComics()), when: (data: HTTPClientSpy().getComics(), response: makeHTTPResponse(), error: nil))
    }
    
    
    func test_get_should_complete_no_data_when_request_completes_with_204() {
        expectedResult(.success(nil), when: (data: nil, response: makeHTTPResponse(statusCode:204), error: nil))
        expectedResult(.success(nil), when: (data: makeEmptyData(), response: makeHTTPResponse(statusCode:204), error: nil))
        expectedResult(.success(nil), when: (data: makeEmptyData(), response: makeHTTPResponse(statusCode:204), error: nil))
    }
    
    func test_post_should_complete_with_error_when_request_completes_with_non_200() {
        expectedResult(.failure(.emptyParameter), when: (data: HTTPClientSpy().getCharacters(), response: makeHTTPResponse(statusCode: 400), error: nil))
        expectedResult(.failure(.emptyParameter), when: (data: HTTPClientSpy().getCharacters(), response: makeHTTPResponse(statusCode: 450), error: nil))
        expectedResult(.failure(.emptyParameter), when: (data: HTTPClientSpy().getCharacters(), response: makeHTTPResponse(statusCode: 499), error: nil))
        expectedResult(.failure(.serverError), when: (data: HTTPClientSpy().getCharacters(), response: makeHTTPResponse(statusCode: 500), error: nil))
        expectedResult(.failure(.serverError), when: (data: HTTPClientSpy().getCharacters(), response: makeHTTPResponse(statusCode: 599), error: nil))
        expectedResult(.failure(.unauthorized), when: (data: HTTPClientSpy().getCharacters(), response: makeHTTPResponse(statusCode: 401), error: nil))
        expectedResult(.failure(.invalidValuePassedToFilter), when: (data: HTTPClientSpy().getCharacters(), response: makeHTTPResponse(statusCode: 403), error: nil))
        expectedResult(.failure(.noConnectivity), when: (data: HTTPClientSpy().getCharacters(), response: makeHTTPResponse(statusCode: 300), error: nil))
        expectedResult(.failure(.noConnectivity), when: (data: HTTPClientSpy().getCharacters(), response: makeHTTPResponse(statusCode: 100), error: nil))
    }
    
}

extension AlamofireAdapterTests {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func testRequest(url: URL = makeURL(theme: "comics"), action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        let exp = expectation(description: "waiting...")
        sut.get(to: url) { _ in exp.fulfill() }
        var request: URLRequest?
        URLProtocolStub.observeRequest { request = $0 }
        wait(for: [exp], timeout: 1)
        action(request!)
    }
    
    func expectedResult(_ expectedResult: Result<Data?, HTTPError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #file, line: UInt = #line) {
        let sut = makeSut()
        URLProtocolStub.simulate(data: stub.data, response: stub.response, error: stub.error)
        let exp = expectation(description: "waiting...")
        sut.get(to: makeURL(theme: "comics")) { receivedResult in
            switch (expectedResult, receivedResult) {
            case(.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedData), .success(let receivedData)):
                XCTAssertEqual(expectedData, receivedData, file: file, line: line)
            default:
                XCTFail("Expected \(expectedResult) got\(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
