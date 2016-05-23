import GSKStretchyHeaderView

class ScalableLabelHeaderView: GSKStretchyHeaderView {
    let maxFontSize: CGFloat = 40
    let minFontSize: CGFloat = 20
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 20, width: self.contentView.width, height: self.contentView.height - 20))
        label.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        label.font = UIFont.monospacedDigitSystemFontOfSize(self.maxFontSize, weight: UIFontWeightMedium)
        label.textColor = UIColor.whiteColor()
        label.text = "Scalable 1234"
        label.textAlignment = .Center
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
        self.backgroundColor = UIColor.blackColor()
    }
    
    override func didChangeStretchFactor(stretchFactor: CGFloat) {
        super.didChangeStretchFactor(stretchFactor)
        
        let fontSize = CGFloatTranslateRange(min(1, stretchFactor), 0, 1, minFontSize, maxFontSize)
        self.label.font = UIFont.monospacedDigitSystemFontOfSize(fontSize, weight: UIFontWeightMedium)
    }
}
