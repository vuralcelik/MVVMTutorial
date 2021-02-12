//
//  CatsVC.swift
//  MVVMTutorial
//
//  Created by Vural Çelik on 12.02.2021.
//

import UIKit
import Kingfisher

class DogVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    private var viewModel = DogVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDogs()
    }
    
    //MARK: - Events
    @IBAction func fetchMoreTapped(_ sender: Any) {
        getDogs()
    }
    
    //MARK: - Helper Methods
    private func getDogs() {
        viewModel.getDogs { [weak self] response in
            self?.imageView.kf.setImage(with: URL(string: response?.message ?? ""))
        } failure: { [weak self] dogErrorType in
            self?.showAlert(dogErrorType: dogErrorType)
        }
    }
    
    //MARK: - UI Configuration
    private func showAlert(dogErrorType: DogErrorTypes?) {
        let alert = UIAlertController(title: "Error", message: dogErrorType?.rawValue ?? "", preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
    }
}
