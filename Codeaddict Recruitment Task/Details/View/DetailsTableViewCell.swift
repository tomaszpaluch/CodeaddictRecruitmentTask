import UIKit

class DetailsTableViewCell: UITableViewCell {
    private let indexContainer: UIView
    private let indexLabel: UILabel
    private let commitAuthorNameLabel: UILabel
    private let commitAuthorEmailLabel: UILabel
    private let commitMessageLabel: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        indexContainer = UIView()
        indexLabel = UILabel()
        commitAuthorNameLabel = UILabel()
        commitAuthorEmailLabel = UILabel()
        commitMessageLabel = UILabel()
        
        indexContainer.backgroundColor = .lightGray
        indexContainer.layer.masksToBounds = true
        indexContainer.layer.cornerRadius = 18
        indexLabel.font = .systemFont(ofSize: 17, weight: .medium)
        commitAuthorNameLabel.font = .systemFont(ofSize: 17, weight: .medium)
        commitAuthorNameLabel.textColor = .systemBlue
        commitAuthorEmailLabel.font = .systemFont(ofSize: 17, weight: .regular)
        commitMessageLabel.textColor = UIColor(white: 158/255, alpha: 1)
        commitMessageLabel.font = .systemFont(ofSize: 17, weight: .regular)
        commitMessageLabel.numberOfLines = 0
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(indexContainer)
        indexContainer.addSubview(indexLabel)
        contentView.addSubview(commitAuthorNameLabel)
        contentView.addSubview(commitAuthorEmailLabel)
        contentView.addSubview(commitMessageLabel)
        
        setupIndexContainerConstraints()
        setupIndexLabelConstraints()
        setupCommitAuthorNameLabelConstraints()
        setupCommitAuthorEmailLabelConstraints()
        setupCommitMessageLabelConstraints()
    }
    
    private func setupIndexContainerConstraints() {
        indexContainer.translatesAutoresizingMaskIntoConstraints = false
        indexContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 26).isActive = true
        indexContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        indexContainer.widthAnchor.constraint(equalToConstant: 36).isActive = true
        indexContainer.heightAnchor.constraint(equalTo: indexContainer.widthAnchor).isActive = true
    }
    
    private func setupIndexLabelConstraints() {
        indexLabel.translatesAutoresizingMaskIntoConstraints = false
        indexLabel.centerYAnchor.constraint(equalTo: indexContainer.centerYAnchor).isActive = true
        indexLabel.centerXAnchor.constraint(equalTo: indexContainer.centerXAnchor).isActive = true
    }
    
    private func setupCommitAuthorNameLabelConstraints() {
        commitAuthorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        commitAuthorNameLabel.bottomAnchor.constraint(equalTo: commitAuthorEmailLabel.topAnchor, constant: -2).isActive = true
        commitAuthorNameLabel.leftAnchor.constraint(equalTo: commitAuthorEmailLabel.leftAnchor).isActive = true
        commitAuthorNameLabel.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor).isActive = true
    }
    
    private func setupCommitAuthorEmailLabelConstraints() {
        commitAuthorEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        commitAuthorEmailLabel.centerYAnchor.constraint(equalTo: indexContainer.centerYAnchor).isActive = true
        commitAuthorEmailLabel.leftAnchor.constraint(equalTo: indexContainer.rightAnchor, constant: 20).isActive = true
        commitAuthorEmailLabel.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor).isActive = true
    }
    
    private func setupCommitMessageLabelConstraints() {
        commitMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        commitMessageLabel.topAnchor.constraint(equalTo: commitAuthorEmailLabel.bottomAnchor, constant: 2).isActive = true
        commitMessageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11.5).isActive = true
        commitMessageLabel.leftAnchor.constraint(equalTo: commitAuthorEmailLabel.leftAnchor).isActive = true
        commitMessageLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(item: GitHubCommit, at index: Int) {
        indexLabel.text = "\(index)"
        commitAuthorNameLabel.text = item.commit.author.name
        commitAuthorEmailLabel.text = item.commit.author.email
        commitMessageLabel.text = item.commit.message
    }
}
