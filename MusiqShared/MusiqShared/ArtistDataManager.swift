//
//  ArtistDataManager.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 17/01/2021.
//
// Source: https://medium.com/@nfrugoni19/protocol-oriented-dependency-injection-with-swift-605b3d5b72ce

import Foundation
import Combine
import MusiqConfiguration
import MusiqCore

public class ArtistDataManager {
    
    private var dataFetcher: DataFetcher
    private var cancellable: AnyCancellable?

    var localRepository: ArtistLocalRepository
    var remoteRepository: ArtistRemoteRepository
    
    public init() {
        self.localRepository = ArtistLocalRepository()
        self.remoteRepository = ArtistRemoteRepository()
        self.dataFetcher = DataFetcher()
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    public func search(with term: String) -> AnyPublisher<[Artist], Error> {

        return dataFetcher.searchArtists(term: term)
            .mapError { $0 as Error }
            .map { dto in
                return SearchArtistsDTOMapper.map(dto)
            }
            .eraseToAnyPublisher()
    }
}
