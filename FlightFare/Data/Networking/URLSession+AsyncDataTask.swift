//
//  URLSession+AsyncDataTask.swift
//  FlightFare
//
//  Created by Edwin Peña Sanchez 
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }

extension URLSessionProtocol {
    func asyncDataTask(with url: URL) async -> AsyncResult<Data, Error> {
        do {
            let (data, response) = try await self.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                let error = NSError(domain: NSURLErrorDomain,
                                    code: NSURLErrorBadServerResponse, userInfo: nil)
                return .failure(error)
            }
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
}
