//
//  DIContainer.swift
//  MusiqCore
//
//  Created by Olivier Rigault on 17/01/2021.
//

import Foundation

public protocol DIContainerProtocol {
    func register<Component>(type: Component.Type, component: Any)
    func resolve<Component>(type: Component.Type) -> Component?
}

public final class DIContainer: DIContainerProtocol {
    
    public static let shared = DIContainer()
    
    private init() {}
    
    var components: [String: Any] = [:]

    public func register<Component>(type: Component.Type, component: Any) {
        components["\(type)"] = component
    }

    public func resolve<Component>(type: Component.Type) -> Component? {
        return components["\(type)"] as? Component
    }
}
