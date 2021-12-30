//
//  ProfileSummaryViewController.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 29/12/2021.
//

import UIKit

protocol ProfileSummaryViewProtocol: AnyObject {
  func configure(with model: ProfileSummary)
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
    title = "Profile"
    presenter.viewDidLoad()
  }

  // MARK: - Interface

  func configure(with model: ProfileSummary) {
    profileSummaryView.configure(with: model)
  }

  // MARK: - Private
}
