//
//  Observable.swift
//  OpenMarket
//
//  Created by Erika Russi on 2024-01-19.
//

import Foundation

class Observable<T>{
    
    private var listener: ((T?) -> Void)?
    
    var value: T? {
        didSet{
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(value: T? = nil) {
        self.value = value
    }
    
    func bind(listener: @escaping ((T?) -> Void)){
        listener(value)
        self.listener = listener
    }
}
