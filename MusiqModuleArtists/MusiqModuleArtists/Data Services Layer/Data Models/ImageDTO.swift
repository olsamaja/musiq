//
//  ImageDTO.swift
//  MusiqShared
//
//  Created by Olivier Rigault on 26/12/2020.
//

import Foundation

struct ImageDTO {
    let urlString: String
    let size: String
}

extension ImageDTO: Decodable {
    private enum CodingKeys : String, CodingKey {
        case urlString = "#text", size
    }
}

extension Array where Iterator.Element == ImageDTO {
    
    func url(for size: String) -> URL? {
        guard let image = self.filter({ (image) -> Bool in
            image.size == "large"
        }).first?.urlString else {
            return nil
        }
        return URL(string: image)
    }
}
