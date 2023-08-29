//
//  FetchConnectionsUseCase.swift
//  FlightFare
//
//  Created by Edwin Peña Sanchez 
//

import Foundation

protocol FetchConnectionsUseCaseProtocol {
    func fetchConnections() async -> AsyncResult<[Connection], Error>
}

struct FetchConnectionsUseCase: FetchConnectionsUseCaseProtocol {
    private enum constants {
       static let connectionsPath = "/connections"
    }
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchConnections() async -> AsyncResult<[Connection], Error> {
        do {
            let connectionsUrl = try Environment.apiUrl().appendingPathComponent(constants.connectionsPath)
            let data = try await urlSession.asyncDataTask(with: connectionsUrl).getData()
            let connectionsDTO = try JSONDecoder().decode([ConnectionDTO].self, from: data)
            let connections = connectionsDTO.map(transformDTOsToConnections)
            return .success(connections)
        } catch {
            return .failure(error)
        }
    }
}

private extension FetchConnectionsUseCase {
    func transformDTOsToConnections(_ connectionDTO: ConnectionDTO) -> Connection {
        let fromCity = City(name: connectionDTO.from,
                            coordinates: Coordinates(lat: connectionDTO.coordinates.from.lat,
                                                     long: connectionDTO.coordinates.from.long))
        
        let toCity = City(name: connectionDTO.to,
                          coordinates: Coordinates(lat: connectionDTO.coordinates.to.lat,
                                                   long: connectionDTO.coordinates.to.long))
        
        return Connection(from: fromCity, to: toCity, price: connectionDTO.price)
    }
}
