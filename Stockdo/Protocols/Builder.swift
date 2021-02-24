//
//  Builder.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import Foundation


protocol Builder {}
extension Builder {
    public func with(configure: (inout Self) -> Void) -> Self {
        var this = self
        configure(&this)
        return this
    }
}
extension NSObject: Builder {}
