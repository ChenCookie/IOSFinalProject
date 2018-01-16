//
//  Lover.swift
//  AddData
//
//  Created by SHIH-YING PAN on 22/12/2017.
//  Copyright © 2017 SHIH-YING PAN. All rights reserved.
//

import Foundation
import UIKit

struct Picture: Codable {
    var name: String
    var star: String
    var innerBeauty: Bool
    var imageName: String?
    var addDate:String
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func saveToFile(lovers: [Picture]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(lovers) {
            let url = Picture.documentsDirectory.appendingPathComponent("lover")
            try? data.write(to: url)
        }
    }
    
    static func readLoversFromFile() -> [Picture]? {
        let propertyDecoder = PropertyListDecoder()
        let url = Picture.documentsDirectory.appendingPathComponent("lover")
        if let data = try? Data(contentsOf: url), let lovers = try? propertyDecoder.decode([Picture].self, from: data) {
            return lovers
        } else {
            return nil
        }
    }
    
    
    var image: UIImage? {
        if let imageName = imageName {
            let url = Picture.documentsDirectory.appendingPathComponent(imageName)
            return UIImage(contentsOfFile: url.path)
        } else {
            return #imageLiteral(resourceName: "first")
        }
    }
    
}

