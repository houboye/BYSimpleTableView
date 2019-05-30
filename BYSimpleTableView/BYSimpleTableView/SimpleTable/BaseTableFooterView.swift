import UIKit

open class BaseTableFooterView: UIView {
    open var delegate: Any?
    
    // 子类必须重写, 计算footer的高度，默认20
    open class func footerViewHeight(for data: Any) -> CGFloat {
        return 20.0
    }
    
    // 子类必须重写, 绑定数据
    open func bind(_ data: Any) {}
    
    // 子类可选实现 footer出现或消失在屏幕中时进行的操作
    open func footerWillDisplay(by data: Any) {}
    
    open func footerDidEndDisplay(by data: Any) {}
    
}
