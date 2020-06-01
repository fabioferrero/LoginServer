//
//  LoginServerTests.swift
//  LoginServerTests
//
//  Created by Fabio Ferrero on 01/06/2020.
//  Copyright © 2020 iriscube-reply. All rights reserved.
//

import XCTest
import LoginServer

class LoginServerTests: XCTestCase {

    func test_login_withEmptyDatabase_returnsUserNotRegisteredError() {
        let sut = createSUT(database: [:])
        
        var result: Result<LoginStatus, LoginError>?
        sut.login(username: "dummy", password: "dummy") { result = $0 }
        
        XCTAssertEqual(result, .failure(.userNotRegistered))
    }
    
    func test_login_withNotRegisteredUser_returnsUserNotRegisteredError() {
        let sut = createSUT(database: ["U1":"P1"])
        
        var result: Result<LoginStatus, LoginError>?
        sut.login(username: "U2", password: "dummy") { result = $0 }
        
        XCTAssertEqual(result, .failure(.userNotRegistered))
    }
    
    func test_login_withCorrectCredentials_succesfullyLogin() {
        let sut = createSUT(database: ["U1":"P1"])
        
        var result: Result<LoginStatus, LoginError>?
        sut.login(username: "U1", password: "P1") { result = $0 }
        
        XCTAssertEqual(result, .success(.logged))
    }
    
    func test_login_withWrongCredentials_returnsWrongUserPasswordError() {
        let sut = createSUT(database: ["U1":"P1"])
        
        var result: Result<LoginStatus, LoginError>?
        sut.login(username: "U1", password: "dummy") { result = $0 }
        
        XCTAssertEqual(result, .failure(.wrongUserPassword))
    }
    
    // MARK: Utility
    private func createSUT(database: [String: String]) -> LoginServer {
        // Mock the LoginServer with a zero-delay networking function
        let zeroDelayFunction: LoginServer.Networking = {$0()}
        return LoginServer(database: database, networking: zeroDelayFunction)
    }
}

