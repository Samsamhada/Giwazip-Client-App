//
//  PostingTextViewController.swift
//  GiwazipClient
//
//  Created by creohwan on 2023/01/31.
//

import UIKit

import SnapKit

class PostingTextViewController: BaseViewController {
    
    // MARK: - Property
    
    private let textViewPlaceHolder: String = TextLiteral.textViewPlaceHolder
    private let viewModel = NetworkManager.shared
    var imageDatas: [Data] = []
    
    // MARK: - View
    
    private let textGuideLabel: UILabel = {
        $0.text = "문의 내역을 작성해주세요"
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return $0
    }(UILabel())
    
    private lazy var textView : UITextView = {
        $0.text = textViewPlaceHolder
        $0.textColor = .white
        $0.backgroundColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textContainerInset = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        $0.textAlignment = .natural
        $0.layer.cornerRadius = 8
        $0.delegate = self
        return $0
    }(UITextView())
    
    private let inquiryButton: UIButton = {
        $0.configuration = UIButton.Configuration.filled()
        $0.configuration?.title = TextLiteral.inquiryButtonText
        $0.configuration?.attributedTitle?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.baseBackgroundColor = .blue
        $0.configuration?.background.cornerRadius = 0
        $0.configuration?.contentInsets.bottom = 20
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(tapInquiryButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
    // MARK: - Method
    
    override func layout() {
        view.addSubview(textGuideLabel)
        textGuideLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        view.addSubview(textView)
        textView.snp.makeConstraints {
            $0.top.equalTo(textGuideLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(240)
        }
        
        view.addSubview(inquiryButton)
        inquiryButton.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(90)
        }
    }
    
    override func attribute() {
        super.attribute()
        navigationItem.title = "시공내용 작성"
        
        setupNotificationCenter()
    }
    
    @objc func tapInquiryButton() {
        viewModel.uploadPostData(description: textView.text, files: imageDatas)
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.inquiryButton.snp.updateConstraints { $0.height.equalTo(70) }
                self.inquiryButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height)
            })
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.inquiryButton.snp.updateConstraints { $0.height.equalTo(90) }
            self.inquiryButton.transform = .identity
        })
    }
}

extension PostingTextViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == textViewPlaceHolder) {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        if (textView.text == textViewPlaceHolder) ||
            (textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)  {
            inquiryButton.isEnabled = false
        } else {
            inquiryButton.isEnabled = true
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.textColor = .white
            textView.text = textViewPlaceHolder
        }
    }
}

