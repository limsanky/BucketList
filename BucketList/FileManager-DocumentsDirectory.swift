//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Sankarshana V on 2022/02/08.
//

import Foundation

extension FileManager {
    static func getDocumentURL(of: String) -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(of)
    }
}
