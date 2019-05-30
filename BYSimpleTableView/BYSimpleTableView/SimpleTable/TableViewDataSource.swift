import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    private var dataItem: TableDataItem!
    
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
            tableViewCell.bind(cellItem.cellData!)
        }
        return cell
    }
}
