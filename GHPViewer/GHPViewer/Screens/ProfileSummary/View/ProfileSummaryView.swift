//
//  ProfileSummaryView.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 29/12/2021.
//

import CommonUI
import UIKit

final class ProfileSummaryView: UIView, ErrorStateable {
  let refreshControl = UIRefreshControl()
  lazy var errorView = ErrorView()

  private let scrollView = UIScrollView()
  private let contentStackView = UIStackView()
  private let headerView = ProfileSummaryHeaderView()
  private let pinnedRepositoriesView = VerticalShowcase()
  private let topRepositoriesView = HorizontalShowcase()
  private let starredRepositoriesView = HorizontalShowcase()

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

  func hideComponents(_ value: Bool, animated: Bool = false) {
    UIView.animate(withDuration: animated ? 0.3 : 0.0) { [weak self] in
      guard let self = self else { return }
      [
        self.headerView,
        self.pinnedRepositoriesView,
        self.topRepositoriesView,
        self.starredRepositoriesView,
      ]
      .forEach { $0.alpha = value ? 0.0 : 1.0 }
    }
  }

  func configure(with summary: ProfileSummary) {
    configureHeaderView(with: summary)
    configurePinnedView(with: summary)
    configureTopRepositoriesView(with: summary)
    configureStarredView(with: summary)
  }

  // MARK: - Private

  // MARK: Views Setup

  private func setupComponents() {
    backgroundColor = .systemBackground

    scrollView.refreshControl = refreshControl

    contentStackView.axis = .vertical
    contentStackView.alignment = .top
    contentStackView.distribution = .fill
    [headerView, pinnedRepositoriesView, topRepositoriesView, starredRepositoriesView]
      .forEach(contentStackView.addArrangedSubview(_:))
    contentStackView.spacing = 24

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
      topRepositoriesView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
      starredRepositoriesView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
    ])
  }
}

// MARK: - View Configuration

private extension ProfileSummaryView {
  func configureHeaderView(with summary: ProfileSummary) {
    headerView.configure(
      with:
      ProfileSummaryHeaderView.ViewModel(
        avatarUrl: summary.user.avatarUrl,
        name: summary.user.name,
        username: summary.user.username,
        followersCount: summary.user.followers.totalCount,
        followingCount: summary.user.following.totalCount,
        email: summary.user.email
      )
    )
  }

  func configurePinnedView(with summary: ProfileSummary) {
    guard let pinnedItems = summary.user.pinnedItems?.nodes,
          !pinnedItems.isEmpty
    else {
      pinnedRepositoriesView.isHidden = true
      return
    }

    let repositories =
      pinnedItems
        .map {
          ShortRepositoryInfoView.ViewModel(
            avatarUrl: $0.owner.avatarUrl,
            ownerName: $0.owner.username,
            repositoryTitle: $0.title,
            repositoryDescription: $0.description,
            starsCount: $0.starsCount,
            mainLanguageName: $0.languages.mainLanguage,
            mainLanguageColor: $0.languages.mainLanguageColor
          )
        }

    pinnedRepositoriesView.configure(
      with:
      VerticalShowcase.ViewModel(
        header: SectionHeader.ViewModel(
          sectionTitle: "pinned".localized,
          actionTitle: "view-all".localized
        ),
        items: repositories
      )
    )
  }

  func configureTopRepositoriesView(with summary: ProfileSummary) {
    guard let topRepositories = summary.user.topRepositories?.nodes,
          !topRepositories.isEmpty
    else {
      topRepositoriesView.isHidden = true
      return
    }

    let repositories =
      topRepositories
        .map {
          ShortRepositoryInfoView.ViewModel(
            avatarUrl: $0.owner.avatarUrl,
            ownerName: $0.owner.username,
            repositoryTitle: $0.title,
            repositoryDescription: $0.description,
            starsCount: $0.starsCount,
            mainLanguageName: $0.languages.mainLanguage,
            mainLanguageColor: $0.languages.mainLanguageColor
          )
        }

    topRepositoriesView.configure(
      with:
      HorizontalShowcase.ViewModel(
        header: SectionHeader.ViewModel(
          sectionTitle: "top-repositories".localized,
          actionTitle: "view-all".localized
        ),
        items: repositories
      )
    )
  }

  func configureStarredView(with summary: ProfileSummary) {
    guard let starredRepositories = summary.user.starredRepositories?.nodes,
          !starredRepositories.isEmpty
    else {
      starredRepositoriesView.isHidden = true
      return
    }

    let repositories =
      starredRepositories
        .map {
          ShortRepositoryInfoView.ViewModel(
            avatarUrl: $0.owner.avatarUrl,
            ownerName: $0.owner.username,
            repositoryTitle: $0.title,
            repositoryDescription: $0.description,
            starsCount: $0.starsCount,
            mainLanguageName: $0.languages.mainLanguage,
            mainLanguageColor: $0.languages.mainLanguageColor
          )
        }

    starredRepositoriesView.configure(
      with:
      HorizontalShowcase.ViewModel(
        header: SectionHeader.ViewModel(
          sectionTitle: "starred-repositories".localized,
          actionTitle: "view-all".localized
        ),
        items: repositories
      )
    )
  }
}
