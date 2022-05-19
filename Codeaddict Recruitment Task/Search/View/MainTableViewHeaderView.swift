import UIKit

class MainTableViewHeaderView: UIView {
    let label: UILabel
    
    required convenience init?(coder: NSCoder) {
        self.init()
    }
    
    init() {
        label = UILabel()
        
        super.init(frame: .zero)
        
        label.font = .systemFont(ofSize: 22, weight: .bold)
        
        addSubview(label)
        
        setupLabelConstraints()
    }

    private func setupLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
    }
}
