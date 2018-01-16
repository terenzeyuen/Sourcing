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

#if os(iOS) || os(tvOS)
    import UIKit

    public extension UITableView {
        
        /**
         Registers a nib object containing a cell with the table view under a specified identifier.
        
         Before dequeueing any cells, call this method to tell the table
         view how to create new cells. If a cell of the specified type is not currently in a reuse queue,
         the table view uses the provided information to create a new cell object automatically.
         
         - parameter cellConfiguration: the cell configuration which to register.
         */
        func register<Cell: StaticReusableViewConfiguring>(cellConfiguration: Cell) where Cell.View: UITableViewCell {
            register(cellConfigurations: [cellConfiguration])
        }
        
        /**
         Registers a nib object containing a cell with the table view under a specified identifier.
         
         Before dequeueing any cells, call this method to tell the table
         view how to create new cells. If a cell of the specified type is not currently in a reuse queue,
         the table view uses the provided information to create a new cell object automatically.
         
         - parameter cellConfigurations: the cell configurations which to register.
         */
        func register<Cell: StaticReusableViewConfiguring>(cellConfigurations: [Cell]) where Cell.View: UITableViewCell {
            for cell in cellConfigurations where cell.nib != nil {
                register(cell.nib, forCellReuseIdentifier: cell.reuseIdentifier)
            }
        }
        
    }
#endif
