//
//  ViewController.swift
//  BYSimpleTableView
//
//  Created by CardiorayT1 on 2019/5/29.
//  Copyright © 2019 houboye. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var tableView: UITableView!
    
    private var tableViewDelegate: TableViewDelegate?
    private var tableViewDataSource: TableViewDataSource?
    private var dataItem = TableDataItem()

    private var datas = ["1", "2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataItem.editingStyle = .delete
        tableViewDelegate = TableViewDelegate(dataItem: dataItem)
        tableViewDataSource = TableViewDataSource(dataItem: dataItem)
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        
        view.addSubview(tableView)
        
        tableView.register(cellClass: TestTableViewCell.self)
        
        tableViewDelegate?.set(didSelectRowAtIndexPath: { (tableView, indexPath, rowData, cellClassName) in
            print("\(cellClassName)")
        })
        
        tableViewDataSource?.set(commitEditing: { (tableView, editingStyle, indexPath, rowData) in
            self.datas.remove(at: indexPath.row)
            print("\(editingStyle)----\(rowData)---\(indexPath)")
            self.refreshData()
        })
        
        refreshData()
    }
    
    
    func refreshData() {
        // 先清除数据
        dataItem.clearData()
        
        dataItem.add(cellClass: TestTableViewCell.self, dataItems: datas)
        
        tableView.reloadData()
        
    }

}

