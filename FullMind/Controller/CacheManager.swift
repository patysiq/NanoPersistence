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
    static var indexSelect = Int()
    static var categorySelect = Category()
    static var notesEdit = [Note]()
    static func setCache(_ data: String,_ imageView: String,_ isNewCell: Bool,_ index: Int,_ category: Category?,_ notes: [Note]) {
        // Set the data and use
        notesEdit = notes
        text = data
        image = imageView
        isNew = isNewCell
        indexSelect = index
        guard let categoryCell = category else {return}
        categorySelect = categoryCell
    }
    static func getCache() -> String? {
        return text
    }
    static func getNotes() -> [Note] {
        return notesEdit
    }
    static func getImage() -> String? {
        return image
    }

    static func getNew() -> Bool? {
        return isNew
    }
    static func getIndex() -> Int? {
        return indexSelect
    }
    static func getCategory() -> Category? {
        return categorySelect
    }
}
struct CacheManagerDone {
    static var dataNote = [Note]()
    static func setCacheDone(_ data: [Note]) {
        // Set the data and use
        dataNote = data
    }
    static func getNotes() -> [Note]? {
        // Try to get the data
        return dataNote
    }

}
