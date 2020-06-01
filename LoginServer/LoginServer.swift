//
//  LoginServer.swift
//  LoginServer
//
//  Created by Fabio Ferrero on 01/06/2020.
//  Copyright © 2020 iriscube-reply. All rights reserved.
//

import Foundation

public enum LoginStatus: Equatable {
    case logged
}

public enum LoginError: Error {
    case userNotRegistered
    case wrongUserPassword
}

public class LoginServer {
    
    public typealias Username = String
    public typealias Password = String
    
    private var database: [Username: Password]
    
    public typealias Networking = (@escaping () -> Void) -> Void
    private var networking: Networking
    
    public init(database: [Username: Password],
                networking: @escaping Networking = randomDelay()) {
        self.database = database
        self.networking = networking
    }
    
    public typealias Handler = (Result<LoginStatus, LoginError>) -> Void
    
    public func login(username: String, password: String, completion: @escaping Handler) {
        networking { [weak self] in
            guard let dbPassword = self?.database[username] else {
                completion(.failure(.userNotRegistered)); return
            }
            
            guard password == dbPassword else {
                completion(.failure(.wrongUserPassword)); return
            }
            
            completion(.success(.logged))
        }
    }
}

// MARK: Utility

extension LoginServer {
    
    /// Creates a networking function that execute a given closure after a random
    /// number of seconds taken from the given range
    /// - Parameter range: The range that will be used to take the random delay
    public static func randomDelay(_ range: Range<Int> = 1..<4) -> Networking {
        return { function in
            guard let delay: Int = range.randomElement() else { function(); return }
            delayClosure(by: delay, closure: function)
        }
    }
    
    /// Delay a given closure by a given number of seconds, on given queue
    static func delayClosure(by seconds: Int,
                             on queue: DispatchQueue = .main,
                             closure: @escaping () -> Void) {
        let delayInSeconds: DispatchTime = .now() + .seconds(seconds)
        queue.asyncAfter(deadline: delayInSeconds, execute: closure)
    }
}
