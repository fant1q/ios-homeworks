//
//  NetworkService.swift
//  Navigation
//
//  Created by Денис Штоколов on 25.08.2022.
//

import Foundation

struct NetworkService {
    
    static func request(for configuration: AppConfiguration) {
        let myURL: URL
        
        switch configuration {
        case .starships:
            myURL = AppConfiguration.starships.url!
        case .people:
            myURL = AppConfiguration.people.url!
        case .planets:
            myURL = AppConfiguration.planets.url!
        }
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = 10
        sessionConfiguration.allowsCellularAccess = false
        
        let session = URLSession(configuration: sessionConfiguration)
        
        let task = session.dataTask(with: myURL) { data, response, error in
            if let data = data {
                print("🍒\(data) \(String(data: data, encoding: .windowsCP1250)!)")
            }
            if let response = response as? HTTPURLResponse {
                print("🥑 \(response.allHeaderFields)")
                print("🥦 \(response.statusCode)")
            }
            if let error = error {
                print("🌽 \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

enum AppConfiguration: CaseIterable {
    
    case starships
    case people
    case planets
    
    var url: URL? {
        switch self {
        case .starships:
            return URL(string: "https://swapi.dev/api/starships/3")
        case.people:
            return URL(string: "https://swapi.dev/api/people/8")
        case .planets:
            return URL(string: "https://swapi.dev/api/planets/5")
        }
    }
}
