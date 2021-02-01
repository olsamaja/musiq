//
//  MusiqAppApp.swift
//  MusiqApp
//
//  Created by Olivier Rigault on 21/12/2020.
//

import SwiftUI
import MusiqConfiguration
import MusiqShared
import MusiqCore
import Resolver

@main
struct MusiqAppApp: App {
    
    init() {
        do {
            let configuration = try ConfigurationDataProvider.load(with: Bundle.main)
            Resolver.register { configuration as Configuration }
            let container = DIContainer.shared
            container.register(type: Configuration.self, component: configuration)
        } catch {
            OLLogger.info("\(error) - Unable to load configuration")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ArtistsView(viewModel: ArtistsViewModel())
        }
    }
}
