//
//  ChartsDataManager.swift
//  MusiqModuleCharts
//
//  Created by Olivier Rigault on 19/04/2021.
//

import Combine
import MusiqNetwork

public class ChartsDataManager {
    
    var remoteRepository: ChartsRemoteRepository
    
    public init() {
        self.remoteRepository = ChartsRemoteRepository()
    }
    
    public func getTopTracks() -> AnyPublisher<[ChartTopTrack], Error> {
        
        return remoteRepository.getTopTracks()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
