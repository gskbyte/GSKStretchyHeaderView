import UIKit

class ScalableLabelViewController: GSKExampleBaseTableViewController {
    override func loadStretchyHeaderView() -> GSKStretchyHeaderView {
        let frame = CGRect(x: 0, y: 0, width: self.tableView.width, height: 320)
        let headerView = ScalableLabelHeaderView(frame: frame)
        return headerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureExpandModeButton()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.gsk_setNavigationBarTransparent(true, animated: false)
    }
    
    func configureExpandModeButton() {
        let buttonTitle: String = self.stretchyHeaderView.expansionMode == .TopOnly ? "Top only" : "Immediate"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .Plain, target: self, action: #selector(switchExpandMode))
    }
    
    func switchExpandMode() {
        switch self.stretchyHeaderView.expansionMode {
        case .TopOnly:
            self.stretchyHeaderView.expansionMode = .Immediate
        case .Immediate:
            self.stretchyHeaderView.expansionMode = .TopOnly
        }
        self.configureExpandModeButton()
    }
}
