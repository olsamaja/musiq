//
//  OLLogger.swift
//  MusiqCore
//
//  Created by Olivier Rigault on 21/12/2020.
//

import Foundation
import Logging

public struct OLLogger {
    
    private static var shared = OLLogger()
    private lazy var logger = {
        Logger(label: Bundle.main.bundleIdentifier ?? "Unknown application")
    }()
    
    public static func info(_ message: Logger.Message) {
        OLLogger.shared.logger.info(message)
    }
}
