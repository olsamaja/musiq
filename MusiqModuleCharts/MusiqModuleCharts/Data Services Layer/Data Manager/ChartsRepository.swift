//
//  ChartsRepository.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 19/04/2021.
//

import Foundation
import Combine
import MusiqNetwork
import MusiqCore

protocol ChartsRepositoryProtocol {
    func getTopTracks() -> AnyPublisher<[ChartTopTrack], DataError>
    func getTopArtists() -> AnyPublisher<[ChartTopArtist], DataError>
}

struct ChartsRemoteRepository: ChartsRepositoryProtocol {
    
    typealias T = ChartTopTrack
    private var dataRequester: DataRequester

    public init() {
        self.dataRequester = DataRequester()
    }

    func getTopTracks() -> AnyPublisher<[ChartTopTrack], DataError> {
        return dataRequester.getTopTracks()
            .mapError { $0 }
            .map {
                ChartTopTracksDTOMapper.map($0)
            }
            .eraseToAnyPublisher()
    }

    func getTopArtists() -> AnyPublisher<[ChartTopArtist], DataError> {
        return dataRequester.getTopArtists()
            .mapError { $0 }
            .map {
                ChartTopArtistsDTOMapper.map($0)
            }
            .eraseToAnyPublisher()
    }
}
