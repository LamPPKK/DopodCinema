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
    @IBOutlet private weak var aboutAppLabel: UILabel!
    
    private let gotoPrivacyPolicyTrigger = PublishSubject<(title: String, url: String)>()
    private let gotoShareAppTrigger = PublishSubject<Void>()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setAction()
        bindViewModel()
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
        
        notificationView.isHidden = true
        aboutAppLabel.font = .fontPoppinsRegular(withSize: 14)
        aboutAppLabel.textColor = Constant.Color.color2B2F31
        
        let appName: String = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? .empty
        let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? .empty
        if appName.isEmpty {
            aboutAppLabel.text = "v\(appVersion)"
        } else {
            aboutAppLabel.text = "\(appName) - v\(appVersion)"
        }
    }
    
    private func setAction() {
        
        policyView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.gotoPrivacyPolicyTrigger.onNext((title: "Privacy Policy", url: Constant.Setting.URL_POLICY))
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
                self.gotoShareAppTrigger.onNext(())
            })
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let input = SettingViewModel.Input(gotoPrivacyPolicyTrigger: gotoPrivacyPolicyTrigger.asObserver(),
                                           gotoShareAppTrigger: gotoShareAppTrigger.asObserver())
        
        let output = viewModel.transform(input: input)
        
        output.gotoShareAppEvent
            .drive { [weak self] urlShareApp in
                guard let self = self else { return }
                self.handleShareApp(urlShareApp)
            }
            .disposed(by: disposeBag)
        
        [output.gotoPrivacyPolicyEvent]
            .forEach({ $0.drive().disposed(by: disposeBag) })
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
    
    private func handleShareApp(_ url: String) {
        if let urlStr = NSURL(string: url) {
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
