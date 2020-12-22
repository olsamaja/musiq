//
//  String+Extensions.swift
//  MusiqCore
//
//  Created by Olivier Rigault on 21/12/2020.
//

import Foundation

extension String {
    func trimmed() -> String { trimmingCharacters(in: .whitespacesAndNewlines) }
}
