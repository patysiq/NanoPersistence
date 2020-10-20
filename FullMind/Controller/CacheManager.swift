//
//  CacheManager.swift
//  FullMind
//
//  Created by PATRICIA S SIQUEIRA on 20/10/20.
//

import Foundation

struct CacheManager {
    static var text = String()
    static var image = String()
    static var isNew = Bool()
    static var dataNotes = [Note]()
    static var indexSelect = Int()
    static func setCache(_ data: String,_ imageView: String,_ isNewCell: Bool,_ notesData: [Note],_ index: Int) {
        // Set the data and use
        text = data
        image = imageView
        isNew = isNewCell
        dataNotes = notesData
        indexSelect = index
        
    }
    static func getCache() -> String? {
        // Try to get the data
        return text
    }
    static func getImage() -> String? {
        return image
    }

    static func getNew() -> Bool? {
        return isNew
    }
    
    static func getNotes() -> [Note]? {
        return dataNotes
    }
    
    static func getIndex() -> Int? {
        return indexSelect
    }
}
struct CacheManagerDone {
    static var text = String()
    static var image = String()
    static func setCacheDone(_ data: String,_ imageView: String) {
        // Set the data and use
        text = data
        image = imageView
    }
    static func setImageNew(_ imageView: String) {
        image = imageView
    }
    static func getCache() -> String? {
        // Try to get the data
        return text
    }
    static func getImage() -> String? {
        return image
    }
}
