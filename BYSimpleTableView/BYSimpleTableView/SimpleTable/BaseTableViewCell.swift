import UIKit

open class BaseTableViewCell: UITableViewCell {
    open var delegate: Any?
    
    // 子类必须重写, 计算cell的高度，默认20
    class func cellHeight(for data: Any) -> CGFloat {
        return 44.0
    }
    
    // 子类必须重写, 绑定数据
    open func bind(_ data: Any) {}
    
    // 子类可选实现 cell出现或消失在屏幕中时进行的操作
    open func cellWillDisplay(by data: Any) {}
    
    open func cellDidEndDisplay(by data: Any) {}
    
    // 用来计算动态cell高度
    open class func dynamicCellHeight(for staticCell: BaseTableViewCell, data: Any, cellClass: AnyClass, tableViewWidth: CGFloat) -> CGFloat {
        staticCell.bind(data)
        
        staticCell.bounds = CGRect(x: 0, y: 0, width: tableViewWidth, height: staticCell.bounds.height)
        
        staticCell.setNeedsLayout()
        staticCell.layoutIfNeeded()
        
        staticCell.contentView.setNeedsLayout()
        staticCell.contentView.layoutIfNeeded()
        
        for subView in staticCell.contentView.subviews {
            if subView.isKind(of: UILabel.self) {
                let subLabel = subView as! UILabel
                subLabel.preferredMaxLayoutWidth = subLabel.bounds.width
            }
        }
        
        var height = staticCell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        height += 1
        return height
    }
}
