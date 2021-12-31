//
//  ProfileSummaryViewController.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 29/12/2021.
//

import UIKit

protocol ProfileSummaryViewProtocol: AnyObject {
  var isLoading: Bool { get set }

  func didLoad(data: ProfileSummary)
}

final class ProfileSummaryViewController: UIViewController, ProfileSummaryViewProtocol {
  private struct ViewState {
    var wasConfigured: Bool = false
  }

  private var viewState: ViewState = .init()
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

  // TODO: This could be sliced into several function per view component if needed. Keeping it together for simplicity.
  func didLoad(data: ProfileSummary) {
    viewState.wasConfigured = true
    profileSummaryView.hideComponents(!viewState.wasConfigured, animated: true)
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
    profileSummaryView.hideComponents(true)
  }

  // MARK: - Actions

  @objc private func didPullRefreshControl() {
    presenter.reloadData()
  }
}
