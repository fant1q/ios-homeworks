//
//  NetworkServiceInfo.swift
//  Navigation
//
//  Created by Денис Штоколов on 29.08.2022.
//

import Foundation

enum NetworkError: Error {
    case `default`
    case serverError
    case parseError(reason: String)
    case unknownError
}

protocol NetworkServiceInfoProtocol {
    func request(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

final class NetworkServiceInfo {
    
    private let mainQueue = DispatchQueue.main
}

extension NetworkServiceInfo: NetworkServiceInfoProtocol {
    
    func request(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else {
                self.mainQueue.async { completion(.failure(.default)) }
                return
            }
            
            guard let data = data else {
                self.mainQueue.async { completion(.failure(.unknownError)) }
                return
            }
            
            self.mainQueue.async { completion(.success(data)) }
        })
        
        task.resume()
    }
}
