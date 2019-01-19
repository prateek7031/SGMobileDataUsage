//
//  API_Mobile_Data_Tests.swift
//  API Mobile Data Tests
//
//  Created by Prateek on 19/1/19.
//  Copyright © 2019 Prateek. All rights reserved.
//

import UIKit
import XCTest
@testable import Mobile_Data_Usage
import Foundation

// Protocol for MOCK
protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

//MARK: HttpClient Implementation
class HttpClient {
    
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
        
    }
    
    func get( url: URL, callback: @escaping completeClosure ) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }
    
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

//MARK: MOCK
class MockURLSession: URLSessionProtocol {
    
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    
    private (set) var lastURL: URL?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        
        completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        return nextDataTask
    }
    
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}

//MARK: Test
class HttpClientTests: XCTestCase {
    
    var httpClient: HttpClient!
    let session = MockURLSession()
    let baseUrl =  "https://data.gov.sg/api"
    let resourceId =  "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
    
    override func setUp() {
        super.setUp()
        httpClient = HttpClient(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetYearlyMobileData() {
        guard let url = URL(string: baseUrl + "/action/datastore_search" + "?resource_id=" + resourceId)
            else {
                fatalError("URL can't be empty")
        }
        
        httpClient.get(url: url) { (success, error) in
            // Return data
        }
        
        XCTAssert(session.lastURL == url)
        
    }
    
    func testGetMobileDataAPIHasNoError() {
        
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        guard let url = URL(string: baseUrl + "/action/datastore_search" + "?resource_id=" + resourceId)
            else {
                fatalError("URL can't be empty")
        }
        
        httpClient.get(url: url) { (data, error) in
            XCTAssertNil(error)
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testGetAPIMobileDataHasData() {
        let expectedData = "{}".data(using: .utf8)
        
        session.nextData = expectedData
        
        var actualData: Data?
        httpClient.get(url: URL(string: baseUrl + "/action/datastore_search" + "?resource_id=" + resourceId)!) { (data, error) in
            actualData = data
            
        }
        
        XCTAssertNotNil(actualData)
    }
    
}

