import UIKit
import SnapKit

class CharacterTableViewCell: UITableViewCell {
    class var identifier: String { "character" }

    var characterThumbnail: UIImage? {
        didSet {
            characterImage.image = characterThumbnail
        }
    }
    
    var character: Character? {
        didSet {
            nameLabel.text = character?.name
            modifiedLabel.text = "Modified: " + (character?.modified?.date ?? "")
        }
    }

    // MARK: - Outlets

    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var modifiedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupHierarchy() {
        addSubview(characterImage)
        addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(modifiedLabel)
    }

    private func setupLayout() {
        characterImage.snp.makeConstraints { make in
            make.top.bottom.leading.equalTo(self).inset(15)
            make.width.equalTo(characterImage.snp.height)
        }

        stackView.snp.makeConstraints { make in
            make.leading.equalTo(characterImage.snp.trailing).offset(15)
            make.top.bottom.trailing.equalTo(self).inset(15)
        }
    }

    // MARK: - Reuse

    override func prepareForReuse() {
        super.prepareForReuse()
        accessoryView = nil
        characterImage.image = nil
        modifiedLabel.text = nil
    }
}
