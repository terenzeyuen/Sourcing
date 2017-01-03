//
//  Copyright (C) 2016 Lukas Schmidt.
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
//
//  MultiCellTableViewDataSource.swift
//  Sourcing
//
//  Created by Lukas Schmidt on 02.08.16.
//

import UIKit

final public class MultiCellTableViewDataSource<DataProvider: DataProviding>: NSObject, TableViewDataSourcing {
    
    public var tableView: TableViewRepresenting {
        didSet {
            tableView.dataSource = self
            tableView.reloadData()
        }
    }
    public let dataProvider: DataProvider
    private let cellDequeables: Array<CellDequeable>
    
    public required init(tableView: TableViewRepresenting, dataProvider: DataProvider, cellDequeables: Array<CellDequeable>) {
        self.tableView = tableView
        self.dataProvider = dataProvider
        self.cellDequeables = cellDequeables
        super.init()
        registerCells(cellDequeables)
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    public func update(_ cell: UITableViewCell, with object: DataProvider.Object) {
        guard let cellDequeable = cellDequeableForIndexPath(object) else {
            fatalError("Could not update Cell")
        }
        let _ = cellDequeable.configure(cell, with: object)
    }
    
    
    // MARK: Private
    
    fileprivate func registerCells(_ cellDequeables: Array<CellDequeable>) {
        for (_, cellDequeable) in cellDequeables.enumerated() where cellDequeable.nib != nil {
            tableView.registerNib(cellDequeable.nib, forCellReuseIdentifier: cellDequeable.cellIdentifier)
        }
    }
    
    fileprivate func cellDequeableForIndexPath(_ object: DataProvider.Object) -> CellDequeable? {
        for (_, cellDequeable) in cellDequeables.enumerated() where cellDequeable.canConfigureCell(with: object) {
            return cellDequeable
        }
        
        return nil
    }
    
    // MARK: UITableViewDataSource
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataProvider.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfItems(inSection: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = dataProvider.object(at: indexPath)
        guard let cellDequeable = cellDequeableForIndexPath(object) else {
            fatalError("Unexpected cell type at \(indexPath)")
        }
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellDequeable.cellIdentifier, forIndexPath: indexPath)
        update(cell, with: object)
        
        return cell
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return dataProvider.sectionIndexTitles
    }
    
}