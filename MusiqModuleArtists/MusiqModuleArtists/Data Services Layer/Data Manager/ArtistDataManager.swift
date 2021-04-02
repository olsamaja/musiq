//
//  ArtistDataManager.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 17/01/2021.
//

import Combine
import MusiqShared

public class ArtistDataManager {
    
    var localRepository: ArtistLocalRepository
    var remoteRepository: ArtistRemoteRepository
    
    public init() {
        self.localRepository = ArtistLocalRepository()
        self.remoteRepository = ArtistRemoteRepository()
    }
    
    public func search(with term: String) -> AnyPublisher<[Artist], Error> {
        
        return remoteRepository.search(with: term)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
