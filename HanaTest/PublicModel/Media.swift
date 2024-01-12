//
//  Media.swift
//  HanaTest
//
//  Created by Arif Rahman Sidik on 12/01/24.
//

import UIKit

class Media {
    var key: String
    var fileName: String
    var data: Data
    var mimeType: String

    init?(withImage image: UIImage, forKey key: String) {
        self.key = "File"
        self.mimeType = "image/jpg"
        self.fileName = "\(arc4random()).jpeg"

        guard let data = image.jpegData(compressionQuality: 0.5) else { return nil }
        self.data = data
    }
    
    init?(key: String, mimeType: String, fileName: String, data: Data){
        self.key = key
        self.mimeType = mimeType
        self.fileName = fileName
        self.data = data
    }
}
