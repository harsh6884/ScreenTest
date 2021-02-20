//
//  CodingUserInfoKey.swift
//  ScreenTest
//
//  Created by Harshad Medisage on 20/02/21.
//

import Foundation

public extension CodingUserInfoKey {
    // Helper property to retrieve the Core Data managed object context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
