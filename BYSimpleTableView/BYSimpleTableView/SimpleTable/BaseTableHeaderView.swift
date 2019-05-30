import UIKit

open class BaseTableHeaderView: UIView {
    open var delegate: Any?
    
    // 子类必须重写, 计算header的高度，默认20
    open class func headerViewHeight(for data: Any) -> CGFloat {
        return 20.0
    }
    
    // 子类必须重写, 绑定数据
    open func bind(_ data: Any) {}
    
    // 子类可选实现 header出现或消失在屏幕中时进行的操作
    open func headerWillDisplay(by data: Any) {}
    
    open func headerDidEndDisplay(by data: Any) {}
    
}
