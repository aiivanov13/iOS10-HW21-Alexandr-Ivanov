import UIKit

extension UIViewController {
    func alertController(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let actionButton = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alert.addAction(actionButton)
        present(alert, animated: true, completion: nil)
    }
}
