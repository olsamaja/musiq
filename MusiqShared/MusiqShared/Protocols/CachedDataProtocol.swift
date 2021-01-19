//
//  CachedDataProtocol.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 17/01/2021.
//

import Foundation

protocol CachedDataProtocol {
    
    associatedtype T
    
    var cachedData: [T] { get set }
}
