import UIKit

open class TableSectionDataItem: NSObject {
    open var headerClass: AnyClass?
    open var footerClass: AnyClass?
    
    open var sectionHeaderTitle: String?
    open var sectionFooterTitle: String?
    
    open var sectionHeaderData: Any?
    open var sectionFooterData: Any?
    
    open var sectionHeaderDelegate: Any?
    open var sectionFooterDelegate: Any?
    
    open var cells = [TableCellDataItem]()
}

open class TableCellDataItem: NSObject {
    open var cellClassName: String!
    open var cellData: Any?
    open var cellDelegate: Any?
}

open class TableDataItem: NSObject {
    open var editingStyle = UITableViewCell.EditingStyle.none
    
    open var firstData: Any? {
        if items.count > 0 {
            return items.first
        }
        return nil
    }
    
    open var lastData: Any? {
        if items.count > 0 {
            return items.last
        }
        return nil
    }
    
    open var items = [TableSectionDataItem]()
    
    class func dataItem() -> TableDataItem {
        let item = TableDataItem()
        return item
    }
    
    /// 分别设置区头区尾视图类型和相关数据以及代理对象
    ///
    /// - Parameters:
    ///   - headerClass: 区头类型
    ///   - headerDataItem: 区头相关数据
    ///   - headerDelegate: 区头代理
    ///   - footerClass: 区尾类型
    ///   - footerDataItem: 区尾相关数据
    ///   - footerDelegate: 区尾代理
    open func add(headerClass: AnyClass? = nil,
                  headerDataItem: Any? = nil,
                  headerDelegate: Any? = nil,
                  footerClass: AnyClass? = nil,
                  footerDataItem: Any? = nil,
                  footerDelegate: Any? = nil) {
        let sectionSource = TableSectionDataItem()
        sectionSource.headerClass = headerClass
        sectionSource.footerClass = footerClass
        sectionSource.sectionHeaderData = headerDataItem
        sectionSource.sectionFooterData = footerDataItem
        sectionSource.sectionHeaderDelegate = headerDelegate
        sectionSource.sectionFooterDelegate = footerDelegate
        
        items.append(sectionSource)
    }
    
    /// 添加Cell类型和相关数据以及代理对象进当前区
    ///
    /// - Parameters:
    ///   - cellClass: Cell类型
    ///   - dataItem: 相关数据,与Cell类中的bindData:方法接收的参数类型一致
    ///   - delegate: 代理对象
    open func add(cellClass: AnyClass,
                  dataItem: Any,
                  delegate: Any? = nil) {
        add(cellClass: cellClass, dataItems: [dataItem], delegate: delegate)
    }
    
    /// 将相关数据数组中的数据分别与Cell类型和代理对象添加进当前区
    ///
    /// - Parameters:
    ///   - cellClass: Cell类型
    ///   - dataItems: 相关数据数组
    ///   - delegate: 代理对象
    open func add(cellClass: AnyClass,
                  dataItems: [Any],
                  delegate: Any? = nil) {
        guard let sectionSource = items.last else {
            items.append(TableSectionDataItem())
            add(cellClass: cellClass, dataItems: dataItems, delegate: delegate)
            return
        }
        
        for dataItem in dataItems {
            let cellItem = TableCellDataItem()
            cellItem.cellClassName = NSStringFromClass(cellClass)
            cellItem.cellData = dataItem
            cellItem.cellDelegate = delegate
            
            sectionSource.cells.append(cellItem)
        }
    }
    
    /// 清除数据源
    open func clearData() {
        items.removeAll()
    }
    
    
    /// 通过indexPath获取相关数据源
    ///
    /// - Parameter indexPath: 数据源索引,与Cell索引一致
    /// - Returns: 相关数据源
    func cellData(for indexPath: IndexPath) -> Any? {
        let sectionItem = items[indexPath.section]
        let cellItem = sectionItem.cells[indexPath.row]
        return cellItem.cellData
    }
    
    /// 通过indexPath获取相关Cell类型
    ///
    /// - Parameter indexPath: Cell索引
    /// - Returns: 相关Cell类型
    open func cellClassName(for indexPath: IndexPath) -> String? {
        let sectionItem = items[indexPath.section]
        let cellItem = sectionItem.cells[indexPath.row]
        
        return cellItem.cellClassName
    }
    
    /// 通过indexPath获取相关Cell高度
    ///
    /// - Parameter indexPath: Cell索引
    /// - Returns: 相关Cell高度
    open func cellHeight(for indexPath: IndexPath) -> CGFloat {
        let sectionItem = items[indexPath.section]
        let cellItem = sectionItem.cells[indexPath.row]
        
        guard let cellClass = NSClassFromString(cellItem.cellClassName!) as? BaseTableViewCell.Type  else {
            return 44.0
        }
        return cellClass.cellHeight(for: cellItem.cellData as Any)
    }
    
    /// 通过section获取区头高度
    ///
    /// - Parameter section: 区索引
    /// - Returns: 相关区头高度
    open func headerHegiht(for section: Int) -> CGFloat {
        let sectionItem = items[section]
        
        guard let headerClass = sectionItem.headerClass as? BaseTableHeaderView.Type else {
            return 20.0
        }
        return headerClass.headerViewHeight(for: sectionItem.sectionHeaderData as Any)
    }
    
    /// 通过section获取区尾高度
    ///
    /// - Parameter section: 区索引
    /// - Returns: 相关区尾高度
    open func footerHegiht(for section: Int) -> CGFloat {
        let sectionItem = items[section]
        
        guard let footerClass = sectionItem.headerClass as? BaseTableFooterView.Type else {
            return 20.0
        }
        
        return footerClass.footerViewHeight(for: sectionItem.sectionFooterData as Any)
    }
    
    /// 通过区索引获取相关自定义区头数据
    ///
    /// - Parameter section: 区索引
    /// - Returns: 相关自定义区头尾数据
    open func sectionHeaderDataItem(for section: Int) -> Any? {
        return items[section].sectionHeaderData
    }
    
    /// 通过区索引获取相关自定义区尾数据
    ///
    /// - Parameter section: 区索引
    /// - Returns: 相关自定义区头尾数据
    open func sectionFooterDataItem(for section: Int) -> Any? {
        return items[section].sectionFooterData
    }
    
}
