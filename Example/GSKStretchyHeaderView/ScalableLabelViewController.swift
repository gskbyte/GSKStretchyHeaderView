import UIKit

class ScalableLabelViewController: GSKExampleBaseTableViewController {
    override func loadStretchyHeaderView() -> GSKStretchyHeaderView {
        let frame = CGRect(x: 0, y: 0, width: self.tableView.width, height: 320)
        let headerView = ScalableLabelHeaderView(frame: frame)
        return headerView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.gsk_setNavigationBarTransparent(true, animated: false)
    }
}
