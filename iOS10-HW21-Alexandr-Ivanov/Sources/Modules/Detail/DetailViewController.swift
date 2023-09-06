import UIKit
import SnapKit

class DetailViewController: UIViewController {
    var character: Character? {
        didSet {
            nameLabel.text = character?.name

            if character?.description == "" {
                descriptionLabel.text = "No data"
                descriptionLabel.textAlignment = .center
            } else {
                descriptionLabel.text = character?.description
            }

            RequestService.shared.getImage(path: character?.thumbnail?.getImagePath(with: ImageSize.fantastic)) { [weak self] data in
                self?.characterImage.image = UIImage(data: data)
            }
        }
    }

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
