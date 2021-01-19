//
//  ArtistDataManager.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 17/01/2021.
//

import Foundation
import Combine

struct ArtistDataManager {
    
    var localRepository: ArtistLocalRepository
    var remoteRepository: ArtistRemoteRepository
    
    init() {
        self.localRepository = ArtistLocalRepository()
        self.remoteRepository = ArtistRemoteRepository()
    }
}
