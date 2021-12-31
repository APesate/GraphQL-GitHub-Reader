//
//  ProfileSummaryViewController.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 29/12/2021.
//

import UIKit

protocol ProfileSummaryViewProtocol: AnyObject {
  func didLoad(data: ProfileSummary)
}

final class ProfileSummaryViewController: UIViewController, ProfileSummaryViewProtocol {
  private var profileSummaryView: ProfileSummaryView! { view as? ProfileSummaryView }
  private let presenter: ProfileSummaryPresenterProtocol

  init(presenter: ProfileSummaryPresenterProtocol) {
    self.presenter = presenter

    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    view = ProfileSummaryView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupComponents()
    presenter.viewDidLoad()
  }

  // MARK: - Interface

  // TODO: This could be sliced into several function per view component if needed. Keeping it together for simplicity.
  func didLoad(data: ProfileSummary) {
    profileSummaryView.refreshControl.endRefreshing()
    profileSummaryView.configure(with: data)
  }

  // MARK: - Private

  private func setupComponents() {
    title = "Profile"
    
    profileSummaryView.refreshControl.addTarget(
      self,
      action: #selector(didPullRefreshControl),
      for: .valueChanged
    )
  }

  // MARK: - Actions

  @objc private func didPullRefreshControl() {
    presenter.reloadData()
  }
}
