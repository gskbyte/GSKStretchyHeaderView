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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.gsk_setNavigationBarTransparent(true, animated: false)
    }
    
    func configureExpandModeButton() {
        let buttonTitle: String = self.stretchyHeaderView.expansionMode == .topOnly ? "Top only" : "Immediate"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .plain, target: self, action: #selector(switchExpandMode))
    }
    
    func switchExpandMode() {
        switch self.stretchyHeaderView.expansionMode {
        case .topOnly:
            self.stretchyHeaderView.expansionMode = .immediate
        case .immediate:
            self.stretchyHeaderView.expansionMode = .topOnly
        }
        self.configureExpandModeButton()
    }
}
