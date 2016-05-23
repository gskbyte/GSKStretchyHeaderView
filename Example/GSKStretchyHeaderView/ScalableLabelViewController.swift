import UIKit

class ScalableLabelViewController: GSKExampleBaseTableViewController {
    var targetContentOffsetY: CGFloat?
    
    override func loadStretchyHeaderView() -> GSKStretchyHeaderView {
        let frame = CGRect(x: 0, y: 0, width: self.tableView.width, height: 320)
        let headerView = ScalableLabelHeaderView(frame: frame)
        return headerView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.gsk_setNavigationBarTransparent(true, animated: false)
    }
    
    
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let minContentOffset = -self.stretchyHeaderView.minimumContentHeight
        let maxContentOffset = -self.stretchyHeaderView.maximumContentHeight
        
        if self.stretchyHeaderView.stretchFactor < 0.4 {
            self.targetContentOffsetY = (velocity.y > -1.2) ? minContentOffset : maxContentOffset
        } else if self.stretchyHeaderView.stretchFactor < 1 {
            self.targetContentOffsetY = (velocity.y > 1.2) ? minContentOffset : maxContentOffset
        }
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.adjustScrollToTargetOffset()
        }
    }
    
    override func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        self.adjustScrollToTargetOffset()
    }
    
    private func adjustScrollToTargetOffset() {
        if let contentOffsetY = self.targetContentOffsetY {
            self.tableView.setContentOffset(CGPoint(x: 0, y: contentOffsetY), animated: true)
            self.targetContentOffsetY = nil
        }
    }
}