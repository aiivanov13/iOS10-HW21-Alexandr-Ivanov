import UIKit
import SnapKit

class DetailView: UIViewController {
    var presenter: DetailViewOutput?

    // MARK: - Outlets

    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        view.addSubview(characterImage)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
    }

    private func setupLayout() {
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(40)
            make.top.equalTo(view).offset(30)
        }

        characterImage.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(60)
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
            make.height.equalTo(characterImage.snp.width)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(40)
            make.top.equalTo(characterImage.snp.bottom).offset(30)
        }
    }
}

// MARK: - DetailViewInput

extension DetailView: DetailViewInput {
    func setCharacter(name: String, description: String, imageData: Data) {
        if description == "" {
            descriptionLabel.text = "No data"
            descriptionLabel.textAlignment = .center
        } else {
            descriptionLabel.text = description
        }
        nameLabel.text = name
        characterImage.image = UIImage(data: imageData)
    }
}
