//
//  Copyright (C) DB Systel GmbH.
//
//  Permission is hereby granted, free of charge, to any person obtaining a 
//  copy of this software and associated documentation files (the "Software"), 
//  to deal in the Software without restriction, including without limitation 
//  the rights to use, copy, modify, merge, publish, distribute, sublicense, 
//  and/or sell copies of the Software, and to permit persons to whom the 
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in 
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
//  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
//  DEALINGS IN THE SOFTWARE.
//

import UIKit

#if os(iOS) || os(tvOS)
    // The reusable view configuration can decide if it can configure a given view with an object or not.
    /// If matching, it is able to configure the view with the object. A configuration can be registered at the collection view or table view
    /// with the configurations nib, reuse identifier and element kind for later dequeuing.
    ///
    /// - Note: Dequeuing a view is not part of configuration.
    /// - SeeAlso: `StaticReuseableViewConfiguring`
    /// - SeeAlso: `ReuseableViewConfiguration`
    public protocol ReuseableViewConfiguring {
        
        /// The reuse identifier which will be used to register and deque the view.
        var reuseIdentifier: String { get }
        /// the type of theview.
        var type: ReuseableViewType { get }
        
        /// The nib which visualy represents view.
        var nib: UINib? { get }
        
        /// Configures the given view with at the index path with the given object.
        ///
        /// - Parameters:
        ///   - view: the view to configure
        ///   - indexPath: index path of the view
        ///   - object: the object which relates to the view
        func configure(_ view: AnyObject, at indexPath: IndexPath, with object: Any)
        
        /// Decide if `Self` can configure a view with a given object and a kind.
        ///
        /// - Parameters:
        ///   - ofKind: the kind.
        ///   - object: the object.
        /// - Returns: if `Self` can configure the view.
        func canConfigureView(ofKind: String?, with object: Any) -> Bool
    }
#endif