import UIKit

public typealias CommitEditing = (_ tableView: UITableView, _ editingStyle: UITableViewCell.EditingStyle, _ indexPath: IndexPath, _ rowData: Any) -> Void

class TableViewDataSource: NSObject, UITableViewDataSource {
    private var dataItem: TableDataItem!
    
    private var commitEditing: CommitEditing?
    
    func set(commitEditing: @escaping CommitEditing) {
        self.commitEditing = commitEditing
    }
    
    init(dataItem: TableDataItem) {
        super.init()
        self.dataItem = dataItem
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataItem.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionItem = dataItem.items[section]
        return sectionItem.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionItem = dataItem.items[indexPath.section]
        let cellItem = sectionItem.cells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellItem.cellClassName!, for: indexPath)
        
        if let tableViewCell = cell as? BaseTableViewCell {
            tableViewCell.delegate = cellItem.cellDelegate
            tableViewCell.bind(cellItem.cellData as Any)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let rowData = dataItem.cellData(for: indexPath)
        commitEditing?(tableView, editingStyle, indexPath, rowData as Any)
    }
}
