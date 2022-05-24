import UIKit

class DetailsViewController: UIViewController {
    var coordinator: MainCoordinator? {
        get { logic.coordinator }
        set { logic.coordinator = newValue }
    }
    
    private let logic: DetailsLogic
    
    private let ownerImageView: UIImageView
    private let repoOwnerNameLabel: UILabel
    private let repoStarIconView = UIImageView()
    private let numberOfStarsLabel: UILabel
    private let numberOfStarsStack: UIStackView
    private let imageOverlayStack: UIStackView
    private let repoTitleLabel: UILabel
    private let viewOnlineButton: UIButton
    private let commitsHistoryLabel: UILabel
    private let commitsTableView: UITableView
    private let activityIndicator: UIActivityIndicatorView
    private let shareRepoButton: UIButton
    
    init(logic: DetailsLogic) {
        self.logic = logic
        
        var config = UIButton.Configuration.filled()
        config.imagePadding = 9
        config.baseBackgroundColor = .systemGray6
        config.baseForegroundColor = .systemBlue
        
        ownerImageView = UIImageView()
        let repoByLabel = UILabel()
        repoOwnerNameLabel = UILabel()
        numberOfStarsLabel = UILabel()
        numberOfStarsStack = UIStackView()
        imageOverlayStack = UIStackView()
        repoTitleLabel = UILabel()
        viewOnlineButton = UIButton()
        commitsHistoryLabel = UILabel()
        commitsTableView = UITableView()
        activityIndicator = UIActivityIndicatorView()
        shareRepoButton = UIButton(configuration: config)
        
        if let ownerImage = logic.viewModel.ownerImage {
            ownerImageView.image = ownerImage
            ownerImageView.layer.masksToBounds = true
        } else {
            ownerImageView.backgroundColor = .lightGray
        }
        ownerImageView.contentMode = .scaleAspectFill
        
        repoByLabel.textColor = .white.withAlphaComponent(0.6)
        repoByLabel.text = "REPO BY"
        repoByLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
        repoOwnerNameLabel.textColor = .white
        repoOwnerNameLabel.text = logic.viewModel.repoAuthorName
        repoOwnerNameLabel.font = .systemFont(ofSize: 28, weight: .bold)
        
        repoStarIconView.image = UIImage(systemName: "star.fill")
        repoStarIconView.tintColor = .white.withAlphaComponent(0.5)
        repoStarIconView.contentMode = .scaleAspectFit
        
        numberOfStarsLabel.textColor = .white.withAlphaComponent(0.5)
        numberOfStarsLabel.text = "Number of Stars (\(logic.viewModel.starCount))"
        numberOfStarsLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
        numberOfStarsStack.axis = .horizontal
        numberOfStarsStack.spacing = 5
        
        imageOverlayStack.axis = .vertical
        imageOverlayStack.spacing = 4
        imageOverlayStack.alignment = .leading
        
        repoTitleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        repoTitleLabel.text = logic.viewModel.repoTitle
        
        viewOnlineButton.setTitle("VIEW ONLINE", for: .normal)
        viewOnlineButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        viewOnlineButton.backgroundColor = .systemGray6
        viewOnlineButton.setTitleColor(.systemBlue, for: .normal)
        viewOnlineButton.layer.masksToBounds = true
        viewOnlineButton.layer.cornerRadius = 30/2
        
        commitsHistoryLabel.text = "Commits History"
        commitsHistoryLabel.font = .systemFont(ofSize: 22, weight: .bold)
        
        activityIndicator.startAnimating()
        
        let shareIcon = UIImage(imageLiteralResourceName: "shareIcon")
        
        shareRepoButton.setTitle("Share Repo", for: .normal)
        shareRepoButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        shareRepoButton.layer.masksToBounds = true
        shareRepoButton.layer.cornerRadius = 10
        shareRepoButton.setImage(shareIcon, for: .normal)
        
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .systemBackground
        viewOnlineButton.addTarget(self, action: #selector(openURL), for: .touchUpInside)
        shareRepoButton.addTarget(self, action: #selector(shareRepo), for: .touchUpInside)
        
        view.addSubview(ownerImageView)
        imageOverlayStack.addArrangedSubview(repoByLabel)
        imageOverlayStack.addArrangedSubview(repoOwnerNameLabel)
        numberOfStarsStack.addArrangedSubview(repoStarIconView)
        numberOfStarsStack.addArrangedSubview(numberOfStarsLabel)
        imageOverlayStack.addArrangedSubview(numberOfStarsStack)
        view.addSubview(imageOverlayStack)
        view.addSubview(repoTitleLabel)
        view.addSubview(viewOnlineButton)
        view.addSubview(commitsHistoryLabel)
        view.addSubview(commitsTableView)
        commitsTableView.addSubview(activityIndicator)
        view.addSubview(shareRepoButton)
        
        setupOwnerImageConstraints()
        setupRepoStarIconViewConstraints()
        setupImageOverlayStackConstraints()
        setupRepoTitleLabelConstraints()
        setupViewOnlineButtonConstraints()
        setupCommitsHistoryLabelConstraints()
        setupCommitsTableViewConstraints()
        setupActivityIndicatorConstraints()
        setupShareRepoButtonConstraints()
        
        logic.hideActivityIndicator = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func openURL() {
        logic.openRepoURL()
    }
    
    @objc private func shareRepo() {
        logic.shareRepo()
    }
    
    private func setupOwnerImageConstraints() {
        ownerImageView.translatesAutoresizingMaskIntoConstraints = false
        ownerImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        ownerImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        ownerImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        ownerImageView.heightAnchor.constraint(equalTo: ownerImageView.widthAnchor, multiplier: 263/375).isActive = true
    }
    
    private func setupRepoStarIconViewConstraints() {
        repoStarIconView.translatesAutoresizingMaskIntoConstraints = false
        repoStarIconView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        repoStarIconView.widthAnchor.constraint(equalTo: repoStarIconView.heightAnchor).isActive = true
    }
    
    private func setupImageOverlayStackConstraints() {
        imageOverlayStack.translatesAutoresizingMaskIntoConstraints = false
        imageOverlayStack.bottomAnchor.constraint(equalTo: ownerImageView.bottomAnchor, constant: -22).isActive = true
        imageOverlayStack.leftAnchor.constraint(equalTo: ownerImageView.leftAnchor, constant: 20).isActive = true
        imageOverlayStack.rightAnchor.constraint(equalTo: ownerImageView.rightAnchor, constant: -20).isActive = true
    }
    
    private func setupRepoTitleLabelConstraints() {
        repoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        repoTitleLabel.topAnchor.constraint(equalTo: ownerImageView.bottomAnchor, constant: 21).isActive = true
        repoTitleLabel.leftAnchor.constraint(equalTo: imageOverlayStack.leftAnchor).isActive = true
        repoTitleLabel.rightAnchor.constraint(lessThanOrEqualTo: viewOnlineButton.leftAnchor, constant: -16).isActive = true
    }
    
    private func setupViewOnlineButtonConstraints() {
        viewOnlineButton.translatesAutoresizingMaskIntoConstraints = false
        viewOnlineButton.centerYAnchor.constraint(equalTo: repoTitleLabel.centerYAnchor).isActive = true
        viewOnlineButton.rightAnchor.constraint(equalTo: imageOverlayStack.rightAnchor).isActive = true
        viewOnlineButton.widthAnchor.constraint(equalToConstant: 118).isActive = true
        viewOnlineButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupCommitsHistoryLabelConstraints() {
        commitsHistoryLabel.translatesAutoresizingMaskIntoConstraints = false
        commitsHistoryLabel.topAnchor.constraint(equalTo: repoTitleLabel.bottomAnchor, constant: 39).isActive = true
        commitsHistoryLabel.leftAnchor.constraint(equalTo: imageOverlayStack.leftAnchor).isActive = true
    }
    
    private func setupCommitsTableViewConstraints() {
        commitsTableView.translatesAutoresizingMaskIntoConstraints = false
        commitsTableView.topAnchor.constraint(equalTo: commitsHistoryLabel.bottomAnchor, constant: 10).isActive = true
        commitsTableView.bottomAnchor.constraint(equalTo: shareRepoButton.topAnchor, constant: -24).isActive = true
        commitsTableView.leftAnchor.constraint(equalTo: imageOverlayStack.leftAnchor).isActive = true
        commitsTableView.rightAnchor.constraint(equalTo: imageOverlayStack.rightAnchor).isActive = true
    }
    
    private func setupActivityIndicatorConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: commitsTableView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: commitsTableView.centerXAnchor).isActive = true
    }
    
    private func setupShareRepoButtonConstraints() {
        shareRepoButton.translatesAutoresizingMaskIntoConstraints = false
        shareRepoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        shareRepoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        shareRepoButton.leftAnchor.constraint(equalTo: imageOverlayStack.leftAnchor).isActive = true
        shareRepoButton.rightAnchor.constraint(equalTo: imageOverlayStack.rightAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logic.setupTableView(commitsTableView)
    }
    
    func update(image: UIImage?) {
        if let image = image {
            ownerImageView.image = image
            ownerImageView.layer.masksToBounds = true
            ownerImageView.backgroundColor = .systemBackground
        }
    }
}


