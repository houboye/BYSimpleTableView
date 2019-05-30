import UIKit

extension UITableView {
    func register(cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: NSStringFromClass(cellClass))
    }
    
    func register(cellClasses: [AnyClass]) {
        for cellClass in cellClasses {
            register(cellClass: cellClass)
        }
    }
}
