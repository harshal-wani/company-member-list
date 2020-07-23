//
//  Observable.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 23/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import Foundation

class Observable<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
