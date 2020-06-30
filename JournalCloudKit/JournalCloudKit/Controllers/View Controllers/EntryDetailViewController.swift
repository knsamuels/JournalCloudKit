//
//  EntryDetailViewController.swift
//  JournalCloudKit
//
//  Created by Kristin Samuels  on 6/29/20.
//  Copyright © 2020 Kristin Samuels . All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entry: Entry? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
    }
    
    func updateViews() {
        if let entry = entry {
            titleTextField.text = entry.title
            bodyTextView.text = entry.body
        }
    }
    @IBAction func snreenTapped(_ sender: UITapGestureRecognizer) {
        bodyTextView.resignFirstResponder()
        titleTextField.resignFirstResponder()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, !title.isEmpty, let body = bodyTextView.text, !body.isEmpty else {return}
        EntryController.shared.createEntryWith(title: title, body: body) { (result) in
            switch result {
            case .success(let entry):
                EntryController.shared.entries.append(entry)
            case .failure(let error):
                print(error.errorDescription)
            }
        }
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
}

extension EntryDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
}
