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
    
    private func logger(with bundleIdentifier: String?) -> Logger {
        Logger(label: bundleIdentifier ?? "Unknown application")
    }
    
    public static func info(_ message: Logger.Message,
                            with bundleIdentifier: String? = Bundle.main.bundleIdentifier) {
        OLLogger.shared.logger(with: bundleIdentifier).info(message)
    }
}
