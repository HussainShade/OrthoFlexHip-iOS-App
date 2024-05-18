//
//  PatientFeedbackVc.swift
//  OrthoFlex Hip
//
//  Created by Sail L1 on 28/03/24.
//

import UIKit

class PatientFeedbackVc: UIViewController {

    @IBOutlet weak var feedbackTextView: UITextView!

    let placeholder = "Write your Feedback here..."
    let placeholderColor = UIColor.lightGray

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
    }

    func setupTextView() {
        feedbackTextView.text = placeholder
        feedbackTextView.textColor = placeholderColor
        feedbackTextView.delegate = self
 
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func feedbackSaveBtn(_ sender: Any) {
        let feedbackText = feedbackTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if feedbackText.isEmpty || feedbackText == placeholder {
            showAlert(message: "Fill the empty field", Title: "Alert")
        } else {
            submitFeedback(feedbackText)
        }
    }
   
    func submitFeedback(_ text: String) {
        let patientId = DataManager.shared.patientLoginId
        let formData = ["id": "\(patientId)", "feedback": text]

        APIHandler().postAPIValues(type: AddFeedback.self, apiUrl: ServiceAPI.AddFeedback, method: "POST", formData: formData) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    
                    self?.showAlert(message: data.status ? data.message : "Something went wrong", Title: "Success")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(message: "Something went wrong", Title: "Failure")
                    print(error)
                }
            }
        }
    }

    func showAlert(message: String, Title: String) {
        let alertController = UIAlertController(title: Title , message: message, preferredStyle: .alert)
       
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.navigationController?.popViewController(animated: false)
            })
        present(alertController, animated: true)
    }
}

extension PatientFeedbackVc: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = placeholderColor
        }
    }
}

