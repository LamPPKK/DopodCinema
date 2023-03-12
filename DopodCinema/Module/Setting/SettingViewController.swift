//
//  SettingViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import MessageUI

class SettingViewController: BaseViewController<SettingViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var notificationView: UIView!
    @IBOutlet private weak var notificationLabel: UILabel!
    @IBOutlet private weak var locationView: UIView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var feedbackView: UIView!
    @IBOutlet private weak var feedbackLabel: UILabel!
    @IBOutlet private weak var policyView: UIView!
    @IBOutlet private weak var policyLabel: UILabel!
    @IBOutlet private weak var shareView: UIView!
    @IBOutlet private weak var shareLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setAction()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        topConstraint.constant = Constant.HEIGHT_NAV
        setupSubHeader(with: "Setting")
        
        notificationView.corner(radius: 2)
        notificationLabel.font = .fontPoppinsSemiBold(withSize: 14)
        
        locationView.corner(radius: 2)
        locationLabel.font = .fontPoppinsSemiBold(withSize: 14)
        
        feedbackView.corner(radius: 2)
        feedbackLabel.font = .fontPoppinsSemiBold(withSize: 14)
        
        policyView.corner(radius: 2)
        policyLabel.font = .fontPoppinsSemiBold(withSize: 14)
        
        shareView.corner(radius: 2)
        shareLabel.font = .fontPoppinsSemiBold(withSize: 14)
    }
    
    private func setAction() {
        
        policyView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.tapToPolicy()
            })
            .disposed(by: disposeBag)
        
        feedbackView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.tapToFeedback()
            })
            .disposed(by: disposeBag)
        
        shareView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.tapToShareApp()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Action
    private func tapToFeedback() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([Constant.Setting.EMAIL_FEEDBACK])
            mail.setSubject(Constant.Setting.SUBJECT_CONTENT)
            mail.setMessageBody(Constant.Setting.BODY_CONTENT, isHTML: false)
            
            present(mail, animated: true)
        } else if let emailUrl = createEmailUrl(to: Constant.Setting.EMAIL_FEEDBACK,
                                                subject: Constant.Setting.SUBJECT_CONTENT,
                                                body: Constant.Setting.BODY_CONTENT) {
            Utils.open(with: emailUrl)
        }

    }
    
    private func tapToPolicy() {
        
    }
    
    private func tapToShareApp() {
        if let urlStr = NSURL(string: "https://itunes.apple.com/us/app/myapp/id\(Constant.Setting.MY_APP_ID)?ls=1&mt=8") {
            let objectsToShare = [urlStr]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                if let popup = activityVC.popoverPresentationController {
                    popup.sourceView = self.view
                    popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
                }
            }
            
            self.present(activityVC, animated: true, completion: nil)
        }
    }
}

// MARK: - Extension Message
extension SettingViewController: MFMailComposeViewControllerDelegate {
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
