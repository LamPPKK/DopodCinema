//
//  TrailerViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/07.
//

import UIKit
import RxSwift
import RxCocoa

class TrailerViewController: BaseViewController<TrailerViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var emptyLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private let TrailerCellIdentity: String = "TrailerCell"
    
    private let getDataTrigger = PublishSubject<Void>()
    private let gotoYoutubeTrigger = PublishSubject<String>()
    private var trailers: [VideoInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindViewModel()
        getDataTrigger.onNext(())
    }
    
    // MARK: - Private functions
    private func setupUI() {
        setupSubHeader(with: .empty)
        topConstraint.constant = Constant.HEIGHT_NAV
        emptyLabel.font = .fontPoppinsSemiBold(withSize: 16)
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: TrailerCellIdentity, bundle: nil),
                           forCellReuseIdentifier: TrailerCellIdentity)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func bindViewModel() {
        let input = TrailerViewModel.Input(getDataTrigger: getDataTrigger.asObserver(),
                                           gotoYoutubeTrigger: gotoYoutubeTrigger.asObserver())
        
        let output = viewModel.transform(input: input)
        
        output.getDataEvent
            .drive(onNext: { [weak self] trailers in
                guard let self = self else { return }
                self.trailers = trailers
                
                if trailers.isEmpty {
                    self.emptyLabel.text = "This resource doesn't have a trailer yet, we will update it as soon as possible."
                    self.emptyLabel.isHidden = false
                    self.tableView.isHidden = true
                } else {
                    self.emptyLabel.isHidden = true
                    self.tableView.isHidden = false
                    self.setupTableView()
                }
            })
            .disposed(by: disposeBag)
        
        output.gotoYoutubeEvent.drive().disposed(by: disposeBag)
    }
}

extension TrailerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trailers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrailerCellIdentity) as! TrailerCell
        cell.bindData(trailers[indexPath.row])
        return cell
    }
}

extension TrailerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = trailers[indexPath.row].key
        gotoYoutubeTrigger.onNext(key)
    }
}
