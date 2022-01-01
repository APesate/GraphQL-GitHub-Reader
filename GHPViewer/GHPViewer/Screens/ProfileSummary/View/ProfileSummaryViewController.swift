//
//  ProfileSummaryViewController.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 29/12/2021.
//

import CommonUI
import UIKit

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

  var isLoading: Bool = false {
    didSet {
      isLoading ?
        profileSummaryView.refreshControl.beginRefreshing() :
        profileSummaryView.refreshControl.endRefreshing()
    }
  }

  func didFail(with error: ProfileSummaryViewError) {
    profileSummaryView.hideComponents(true, animated: true)
    let icon =
      error == .accountNotFound ?
      UIImage(named: "error_404") :
      UIImage(named: "error_warning")

    profileSummaryView
      .set(
        errorModel:
        ErrorView.Model(
          icon: icon,
          description: error.localizedDescription
        )
      )
  }

  // TODO: This could be sliced into several function per view component if needed. Keeping it together for simplicity.
  func didLoad(data: ProfileSummary) {
    profileSummaryView.set(errorModel: nil)
    profileSummaryView.hideComponents(false, animated: true)
    profileSummaryView.configure(with: data)
  }

  // MARK: - Private

  private func setupComponents() {
    title = "profile".localized

    profileSummaryView.refreshControl.addTarget(
      self,
      action: #selector(didPullRefreshControl),
      for: .valueChanged
    )
    profileSummaryView.hideComponents(true)
  }

  // MARK: - Actions

  @objc private func didPullRefreshControl() {
    presenter.reloadData()
  }
}
