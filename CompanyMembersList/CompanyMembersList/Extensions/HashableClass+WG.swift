//
//  HashableClass+WG.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 21/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import Foundation

open class HashableClass {
    public init() {}
}

// MARK: - <Hashable>
extension HashableClass: Hashable {

    public func hash(into hasher: inout Hasher) {
         hasher.combine(ObjectIdentifier(self).hashValue)
    }

    // `hashValue` is deprecated starting Swift 4.2, but if you use
    // earlier versions, then just override `hashValue`.
    //
    // public var hashValue: Int {
    //    return ObjectIdentifier(self).hashValue
    // }
}

// MARK: - <Equatable>
extension HashableClass: Equatable {

    public static func ==(lhs: HashableClass, rhs: HashableClass) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}
