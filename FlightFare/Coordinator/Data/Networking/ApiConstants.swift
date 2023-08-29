//
//  ApiConstants.swift
//  FlightFare
//
//  Created by Edwin Peña Sanchez 
//

import Foundation

enum EnvironmentError: Error {
    case plistFileNotFound
    case apiUrlNotSet
}

enum Environment {
    private static let defaultBundle = Bundle.main
    
    static func apiUrl(bundle: Bundle = defaultBundle) throws -> URL {
        guard let dict = bundle.infoDictionary else {
            throw EnvironmentError.plistFileNotFound
        }
        
        guard let apiUrlString = dict["API_URL"] as? String,
              let url = URL(string: "http://\(apiUrlString)") else {
            throw EnvironmentError.apiUrlNotSet
        }
        
        return url
    }
}
