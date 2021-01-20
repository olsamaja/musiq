//
//  ArtistsViewModel.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 05/01/2021.
//

import Foundation
import Combine
import MusiqCore

final class ArtistsViewModel: ObservableObject {
    
    @Published var searchTerm = ""
    
    init() {
        OLLogger.info("ArtistsViewModel - init()")
    }

}
