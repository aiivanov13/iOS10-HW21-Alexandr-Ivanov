import UIKit
import Alamofire
import SnapKit

class CharactersView: UIViewController {
    var presenter: CharactersViewOutput?

    // MARK: - Outlets

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        let insetView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 10)))
        textField.delegate = self
        textField.returnKeyType = .search
        textField.enablesReturnKeyAutomatically = true
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.rightView = insetView
        textField.leftView = insetView
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setupView()
        setupHierarchy()
        setupLayout()
        setupNotifications()
    }

    // MARK: - Setup

    private func setupView() {
        view.backgroundColor = .systemGray6
    }

    private func setupHierarchy() {
        view.addSubview(tableView)
        view.addSubview(searchTextField)
        view.addSubview(cancelButton)
    }

    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.89)
        }

        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(15)
            make.leading.equalTo(view).inset(30)
            make.trailing.equalTo(cancelButton.snp.leading).offset(-15)
            make.height.equalTo(40)
        }

        cancelButton.snp.makeConstraints { make in
            make.trailing.equalTo(view).inset(30)
            make.centerY.equalTo(searchTextField)
        }
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: - Action

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    @objc func cancelButtonTapped() {
        presenter?.loadData()
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
    }
}

// MARK: - UITextFieldDelegate

extension CharactersView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter?.searchCharaters(with: textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UITableViewDelegate

extension CharactersView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchTextField.resignFirstResponder()
        presenter?.presentDetail(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension CharactersView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getCharactersCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier) as? CharacterTableViewCell else { return UITableViewCell() }
        presenter?.getCharacterImage(at: indexPath, completion: { data in
            cell.characterThumbnail = UIImage(data: data)
        })
        cell.character = presenter?.getCharacter(at: indexPath)

        return cell
    }
}

// MARK: - CharactersViewInput

extension CharactersView: CharactersViewInput {
    func cancelButton(is enabled: Bool) {
        cancelButton.isEnabled = enabled
    }

    func reloadData() {
        tableView.reloadData()
    }

    func showAlert(code: String, message: String) {
        alertController(title: code, message: message)
    }
}
