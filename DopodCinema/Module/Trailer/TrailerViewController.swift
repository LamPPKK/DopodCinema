//
//  TrailerViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/07.
//

import UIKit

class TrailerViewController: BaseViewController<TrailerViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var emptyLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private let TrailerCellIdentity: String = "TrailerCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
//        view.backgroundColor = .clear
//
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = blurView.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurView.addSubview(blurEffectView)
        
        setupSubHeader(with: .empty)
        topConstraint.constant = Constant.HEIGHT_NAV
        emptyLabel.font = .fontPoppinsSemiBold(withSize: 16)
        if viewModel.getListTrailer().isEmpty {
            emptyLabel.text = "The resource you requested could not be found."
            emptyLabel.isHidden = false
            tableView.isHidden = true
        } else {
            emptyLabel.isHidden = true
            tableView.isHidden = false
            setupTableView()
        }
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: TrailerCellIdentity, bundle: nil),
                           forCellReuseIdentifier: TrailerCellIdentity)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TrailerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getListTrailer().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrailerCellIdentity) as! TrailerCell
        cell.bindData(viewModel.getListTrailer()[indexPath.row])
        return cell
    }
}

extension TrailerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.gotoYoutubeScreen(viewModel.getListTrailer()[indexPath.row].key)
    }
}
