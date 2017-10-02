import GSKStretchyHeaderView

class ScalableLabelHeaderView: GSKStretchyHeaderView {
    let maxFontSize: CGFloat = 40
    let minFontSize: CGFloat = 20
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 20, width: self.contentView.width, height: self.contentView.height - 20))
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.monospacedDigitSystemFont(ofSize: self.maxFontSize, weight: UIFont.Weight.medium)
        label.textColor = UIColor.darkGray
        label.text = "Scalable text"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.maximumContentHeight = self.width
        self.minimumContentHeight = 64
        
        self.contentView.addSubview(self.label)
        self.backgroundColor = UIColor.orange
    }
    
    override func didChangeStretchFactor(_ stretchFactor: CGFloat) {
        super.didChangeStretchFactor(stretchFactor)
        
        let fontSize = CGFloatTranslateRange(min(1, stretchFactor), 0, 1, minFontSize, maxFontSize)
        if abs(fontSize - self.label.font.pointSize) > 0.05 { // to avoid changing the font too often, this could be more precise though
            self.label.font = UIFont.monospacedDigitSystemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
        }
    }
}
