import UIKit

// view
public typealias ViewForHeaderInSection = (_ tableView: UITableView, _ section: Int, _ item: TableSectionDataItem) -> UIView
public typealias ViewForFooterInSection = (_ tableView: UITableView, _ section: Int, _ item: TableSectionDataItem) -> UIView

// highlight
public typealias ShouldHighlightRowAtIndexPath = (_ tableView: UITableView, _ indexPath: IndexPath, _ rowData: Any) -> Void
public typealias DidHighlightRowAtIndexPath = (_ tableView: UITableView, _ indexPath: IndexPath, _ rowData: Any) -> Void
public typealias DidUnhighlightRowAtIndexPath = (_ tableView: UITableView, _ indexPath: IndexPath, _ rowData: Any) -> Void

// select
public typealias WillSelectRowAtIndexPath = (_ tableView: UITableView, _ indexPath: IndexPath, _ rowData: Any, _ cellClassName: String) -> Void
public typealias WillDeselectRowAtIndexPath = (_ tableView: UITableView, _ indexPath: IndexPath, _ rowData: Any, _ cellClassName: String) -> Void
public typealias DidSelectRowAtIndexPath = (_ tableView: UITableView, _ indexPath: IndexPath, _ rowData: Any, _ cellClassName: String) -> Void
public typealias DidDeselectRowAtIndexPath = (_ tableView: UITableView, _ indexPath: IndexPath, _ rowData: Any, _ cellClassName: String) -> Void


open class TableViewDelegate: NSObject, UITableViewDelegate {
    
    // 等同于：- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
    private var viewForHeaderInSection: ViewForHeaderInSection?
    
    // 等同于：- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
    private var viewForFooterInSection: ViewForFooterInSection?
    
    // 等同于: - (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
    private var shouldHighlightRowAtIndexPath: ShouldHighlightRowAtIndexPath?
    
    // 等同于：- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
    private var didHighlightRowAtIndexPath: DidHighlightRowAtIndexPath?
    
    // 等同于: - (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath;
    private var didUnhighlightRowAtIndexPath: DidUnhighlightRowAtIndexPath?
    
    // 等同于：- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
    private var willSelectRowAtIndexPath: WillSelectRowAtIndexPath?
    
    // 等同于：- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
    private var willDeselectRowAtIndexPath: WillDeselectRowAtIndexPath?
    
    // 等同于：- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
    private var didSelectRowAtIndexPath: DidSelectRowAtIndexPath?
    
    // 等同于：- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
    private var didDeselectRowAtIndexPath: DidDeselectRowAtIndexPath?
    
    private var dataItem: TableDataItem!
    
    open func set(viewForHeaderInSection: @escaping ViewForHeaderInSection) {
        self.viewForHeaderInSection = viewForHeaderInSection
    }
    
    open func set(viewForFooterInSection: @escaping ViewForFooterInSection) {
        self.viewForFooterInSection = viewForFooterInSection
    }
    
    open func set(shouldHighlightRowAtIndexPath: @escaping ShouldHighlightRowAtIndexPath) {
        self.shouldHighlightRowAtIndexPath = shouldHighlightRowAtIndexPath
    }
    
    open func set(didHighlightRowAtIndexPath: @escaping DidHighlightRowAtIndexPath) {
        self.didHighlightRowAtIndexPath = didHighlightRowAtIndexPath
    }
    
    open func set(didUnhighlightRowAtIndexPath: @escaping DidUnhighlightRowAtIndexPath) {
        self.didUnhighlightRowAtIndexPath = didUnhighlightRowAtIndexPath
    }
    
    open func set(willSelectRowAtIndexPath: @escaping WillSelectRowAtIndexPath) {
        self.willSelectRowAtIndexPath = willSelectRowAtIndexPath
    }
    
    open func set(willDeselectRowAtIndexPath: @escaping WillDeselectRowAtIndexPath) {
        self.willDeselectRowAtIndexPath = willDeselectRowAtIndexPath
    }
    
    open func set(didSelectRowAtIndexPath: @escaping DidSelectRowAtIndexPath) {
        self.didSelectRowAtIndexPath = didSelectRowAtIndexPath
    }
    
    open func set(didDeselectRowAtIndexPath: @escaping DidDeselectRowAtIndexPath) {
        self.didDeselectRowAtIndexPath = didDeselectRowAtIndexPath
    }
    
    init(dataItem: TableDataItem) {
        super.init()
        self.dataItem = dataItem
    }
    
    
    // display
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let tableViewCell = cell as? BaseTableViewCell {
            let sectionItem = dataItem.items[indexPath.section]
            let cellItem = sectionItem.cells[indexPath.row]
            tableViewCell.cellWillDisplay(by: cellItem.cellData!)
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let tableHeaderView = view as? BaseTableHeaderView {
            let sectionItem = dataItem.items[section]
            tableHeaderView.headerWillDisplay(by: sectionItem.sectionHeaderData as Any)
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let tableFooterView = view as? BaseTableFooterView {
            let sectionItem = dataItem.items[section]
            tableFooterView.footerWillDisplay(by: sectionItem.sectionFooterData as Any)
        }
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let tableViewCell = cell as? BaseTableViewCell {
            let sectionItem = dataItem.items[indexPath.section]
            let cellItem = sectionItem.cells[indexPath.row]
            tableViewCell.cellDidEndDisplay(by: cellItem.cellData!)
        }
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if let tableHeaderView = view as? BaseTableHeaderView {
            let sectionItem = dataItem.items[section]
            tableHeaderView.headerDidEndDisplay(by: sectionItem.sectionHeaderData as Any)
        }
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        if let tableFooterView = view as? BaseTableFooterView {
            let sectionItem = dataItem.items[section]
            tableFooterView.footerDidEndDisplay(by: sectionItem.sectionFooterData as Any)
        }
    }
    
    // height
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataItem.cellHeight(for: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return dataItem.headerHegiht(for: section)
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return dataItem.footerHegiht(for: section)
    }
    
    // view
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionItem = dataItem.items[section]
        if let customerSectionHeaderView = viewForHeaderInSection?(tableView, section, sectionItem) {
            return customerSectionHeaderView
        }
        
        let sectionHeaderHeight = dataItem.headerHegiht(for: section)
        
        guard let headerClass = sectionItem.headerClass as? BaseTableHeaderView.Type else {
            return UIView()
        }
        let header = headerClass.init()
        header.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: sectionHeaderHeight)
        header.bind(sectionItem.sectionHeaderData as Any)
        header.delegate = sectionItem.sectionHeaderDelegate
        
        return header
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionItem = dataItem.items[section]
        if let customerSectionFooterView = viewForFooterInSection?(tableView, section, sectionItem) {
            return customerSectionFooterView
        }
        
        let sectionFooterHeight = dataItem.headerHegiht(for: section)
        
        guard let footerClass = sectionItem.headerClass as? BaseTableFooterView.Type else {
            return UIView()
        }
        let footer = footerClass.init()
        footer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: sectionFooterHeight)
        footer.bind(sectionItem.sectionFooterData as Any)
        footer.delegate = sectionItem.sectionFooterDelegate
        
        return footer
    }
    
    // highlighting
    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let rowData = dataItem.cellData(for: indexPath)
        shouldHighlightRowAtIndexPath?(tableView, indexPath, rowData as Any)
        return true
    }
    
    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let rowData = dataItem.cellData(for: indexPath)
        didHighlightRowAtIndexPath?(tableView, indexPath, rowData as Any)
    }
    
    public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let rowData = dataItem.cellData(for: indexPath)
        didUnhighlightRowAtIndexPath?(tableView, indexPath, rowData as Any)
    }
    
    // select
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let className = dataItem.cellClassName(for: indexPath)!
        let rowData = dataItem.cellData(for: indexPath)
        willSelectRowAtIndexPath?(tableView, indexPath, rowData as Any, className)
        
        return indexPath
    }
    
    public func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        let className = dataItem.cellClassName(for: indexPath)!
        let rowData = dataItem.cellData(for: indexPath)
        willDeselectRowAtIndexPath?(tableView, indexPath, rowData as Any, className)
        
        return indexPath
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let className = dataItem.cellClassName(for: indexPath)!
        let rowData = dataItem.cellData(for: indexPath)
        didSelectRowAtIndexPath?(tableView, indexPath, rowData as Any, className)
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let className = dataItem.cellClassName(for: indexPath)!
        let rowData = dataItem.cellData(for: indexPath)
        didDeselectRowAtIndexPath?(tableView, indexPath, rowData as Any, className)
    }
}
