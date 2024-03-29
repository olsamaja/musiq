//
//  DataRequester+Tracks.swift
//  MusiqModuleTopTracks
//
//  Created by Olivier Rigault on 18/04/2021.
//

import Combine
import MusiqNetwork
import MusiqCore

extension DataRequester {
    
    func getTopTracks() -> AnyPublisher<ChartTopTracksDTO, DataError> {
        
        let urlComponents = URLComponentsBuilder()
            .with(key: "method", value: "chart.gettoptracks")
            .build()
        
        return loadData(with: urlComponents)
    }
    
    func getTopArtists() -> AnyPublisher<ChartTopArtistsDTO, DataError> {
        
        let urlComponents = URLComponentsBuilder()
            .with(key: "method", value: "chart.gettopartists")
            .build()
        
        return loadData(with: urlComponents)
    }
    
    func getTopTags() -> AnyPublisher<ChartTopTagsDTO, DataError> {
        
        let urlComponents = URLComponentsBuilder()
            .with(key: "method", value: "chart.gettoptags")
            .build()
        
        return loadData(with: urlComponents)
    }
}
