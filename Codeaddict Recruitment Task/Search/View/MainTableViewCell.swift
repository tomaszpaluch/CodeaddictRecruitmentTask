import UIKit

class MainTableViewCell: UITableViewCell {
    private let repoOwnerImage: UIImageView
    private let repoTitle: UILabel
    private let repoStarIconView: UIImageView
    private let repoStarLabel: UILabel
    private let chevronImageView: UIImageView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        repoOwnerImage = UIImageView()
        repoTitle = UILabel()
        repoStarIconView = UIImageView()
        repoStarLabel = UILabel()
        chevronImageView = UIImageView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundView = UIView()
        backgroundView?.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        backgroundView?.layer.cornerRadius = 13
        backgroundView?.layer.masksToBounds = true
        
        repoOwnerImage.layer.cornerRadius = 10
        repoOwnerImage.layer.masksToBounds = true
        repoOwnerImage.backgroundColor = .darkGray
        
        repoTitle.font = .systemFont(ofSize: 17, weight: .semibold)
        
        repoStarIconView.image = UIImage(systemName: "star")
        repoStarIconView.tintColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        repoStarIconView.contentMode = .scaleAspectFit
        
        repoStarLabel.font = .systemFont(ofSize: 17, weight: .regular)
        repoStarLabel.textColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.tintColor = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1)
        chevronImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(repoOwnerImage)
        contentView.addSubview(repoTitle)
        contentView.addSubview(repoStarIconView)
        contentView.addSubview(repoStarLabel)
        contentView.addSubview(chevronImageView)
                
        setupBackgroundViewConstraints()
        setupRepoOwnerImageConstraints()
        setupRepoTitleConstraints()
        setupRepoStarIconViewConstraints()
        setupStarLabelConstraints()
        setupChevronImageViewConstraints()
    }
    
    private func setupBackgroundViewConstraints() {
        backgroundView?.translatesAutoresizingMaskIntoConstraints = false

        backgroundView?.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        backgroundView?.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        backgroundView?.heightAnchor.constraint(equalToConstant: 92.0).isActive = true
        backgroundView?.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    private func setupRepoOwnerImageConstraints() {
        repoOwnerImage.translatesAutoresizingMaskIntoConstraints = false
        
        if let view = backgroundView {
            repoOwnerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
            repoOwnerImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
            repoOwnerImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
            repoOwnerImage.widthAnchor.constraint(equalTo: repoOwnerImage.heightAnchor).isActive = true
        }
    }
    
    private func setupRepoTitleConstraints() {
        repoTitle.translatesAutoresizingMaskIntoConstraints = false
        repoTitle.topAnchor.constraint(equalTo: repoOwnerImage.topAnchor, constant: 10).isActive = true
        repoTitle.leftAnchor.constraint(equalTo: repoOwnerImage.rightAnchor, constant: 16).isActive = true
        repoTitle.rightAnchor.constraint(lessThanOrEqualTo: chevronImageView.leftAnchor, constant: -8).isActive = true
    }
    
    private func setupRepoStarIconViewConstraints() {
        repoStarIconView.translatesAutoresizingMaskIntoConstraints = false
        repoStarIconView.centerYAnchor.constraint(equalTo: repoStarLabel.centerYAnchor).isActive = true
        repoStarIconView.heightAnchor.constraint(equalToConstant: 17).isActive = true
        repoStarIconView.widthAnchor.constraint(equalTo: repoStarIconView.heightAnchor).isActive = true
        repoStarIconView.leftAnchor.constraint(equalTo: repoTitle.leftAnchor).isActive = true
    }
    
    private func setupStarLabelConstraints() {
        repoStarLabel.translatesAutoresizingMaskIntoConstraints = false
        repoStarLabel.topAnchor.constraint(equalTo: repoTitle.bottomAnchor).isActive = true
        repoStarLabel.leftAnchor.constraint(equalTo: repoStarIconView.rightAnchor, constant: 4).isActive = true
    }
    
    private func setupChevronImageViewConstraints() {
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        if let view = backgroundView {
            chevronImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
            chevronImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
        
        chevronImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        chevronImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(image: UIImage?, item: GitHubSearchItem) {
        repoOwnerImage.image = image
        repoTitle.text = item.full_name
        repoStarLabel.text = "\(item.stargazers_count) stars"
    }
}
