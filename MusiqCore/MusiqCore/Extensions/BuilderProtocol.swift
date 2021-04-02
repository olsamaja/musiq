//
//  BuilderProtocol.swift
//  MusiqCore
//
//  Created by Olivier Rigault on 02/04/2021.
//

import Foundation

public protocol BuilderProtocol {
    
    associatedtype T
    
    func build() -> T
}
