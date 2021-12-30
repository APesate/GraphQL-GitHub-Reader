//
//  ProfileSummaryView.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 29/12/2021.
//

import UIKit

final class ProfileSummaryView: UIView {
  private let scrollView = UIScrollView()
  private let contentStackView = UIStackView()
  private let headerView = ProfileSummaryHeaderView()
  private let pinnedRepositoriesView = VerticalShowcase()

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

    pinnedRepositoriesView.configure(
      with:
      VerticalShowcase.ViewModel(
        header: SectionHeader.ViewModel(sectionTitle: "Pinned", actionTitle: "View all"),
        items: [
          dummyRepo,
          dummyRepo,
          dummyRepo,
        ]
      )
    )
  }

  var dummyRepo: ShortRepositoryInfoView.ViewModel {
    ShortRepositoryInfoView.ViewModel(
      avatarURL: URL(string: "https://avatars.githubusercontent.com/u/4807617?v=4")!,
      ownerName: "setaylor",
      repositoryTitle: "telegraph-android",
      repositoryDescription: "Telegraph X is Android client",
      starsCount: 75,
      mainLanguageName: "Swift",
      mainLanguageColor: "#FFA036"
    )
  }

  // MARK: - Private

  // MARK: Views Setup

  private func setupComponents() {
    backgroundColor = .systemBackground

    contentStackView.axis = .vertical
    contentStackView.alignment = .top
    contentStackView.distribution = .fill
    [headerView, pinnedRepositoriesView].forEach(contentStackView.addArrangedSubview(_:))
    contentStackView.setCustomSpacing(24, after: headerView)

    scrollView.addSubview(contentStackView)
    addSubview(scrollView)
  }

  private func setupConstraints() {
    [scrollView, contentStackView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

      contentStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
      contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor),
      scrollView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),

      pinnedRepositoriesView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
    ])
  }
}
