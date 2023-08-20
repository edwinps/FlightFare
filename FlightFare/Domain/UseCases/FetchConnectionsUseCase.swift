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
       static let connectionsPath = "TuiMobilityHub/ios-code-challenge/master/connections.json"
    }
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchConnections() async -> AsyncResult<[Connection], Error> {
        do {
            let data = try await urlSession.asyncDataTask(with: self.connectionsUrl).getData()
            let connectionsDTO = try JSONDecoder().decode(ConnectionsListDTO.self, from: data)
            let connections = connectionsDTO.connections.map(transformDTOsToConnections)
            return .success(connections)
        } catch {
            return .failure(error)
        }
    }
}

private extension FetchConnectionsUseCase {
    var connectionsUrl: URL {
        return Environment.apiUrl.appendingPathComponent(constants.connectionsPath)
    }
    
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
