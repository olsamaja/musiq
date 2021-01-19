//
//  Data+Extensions.swift
//  MusiqCore
//
//  Created by Olivier Rigault on 22/12/2020.
//

import Foundation

public extension Data {
    
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString
    }
    
    func debugPrintJSONString() {
        if let string = self.prettyPrintedJSONString {
            debugPrint(string)
        }
    }
}
