//
//  ProfileSummaryView.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 29/12/2021.
//

import UIKit

final class ProfileSummaryView: UIView {
  private let contentStackView = UIStackView()
  private let headerView = ProfileSummaryHeaderView()

  init() {
    super.init(frame: .zero)

    setupComponents()
    setupConstraints()
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Interface

  func configure(with profile: Profile) {
    headerView.configure(
      with:
      ProfileSummaryHeaderView.ViewModel(
        avatarUrl: profile.avatarUrl,
        name: profile.name,
        username: profile.username,
        followersCount: profile.followersCount,
        followingCount: profile.followingCount,
        email: profile.email
      )
    )
  }

  // MARK: - Private

  // MARK: Views Setup

  private func setupComponents() {
    backgroundColor = .white
    
    contentStackView.axis = .vertical
    contentStackView.alignment = .fill
    contentStackView.distribution = .fill

    addSubview(headerView)
  }

  private func setupConstraints() {
    headerView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: topAnchor),
      headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }
}
