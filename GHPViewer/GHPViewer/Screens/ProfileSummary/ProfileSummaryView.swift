//
//  ProfileSummaryView.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 29/12/2021.
//

import UIKit

final class ProfileSummaryView: UIView {
  let refreshControl = UIRefreshControl()

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

  func configure(with summary: ProfileSummary) {
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

    if let pinnedItems = summary.user.pinnedItems?.nodes,
       !pinnedItems.isEmpty
    {
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
            sectionTitle: "Pinned",
            actionTitle: "View all"
          ),
          items: repositories
        )
      )
    } else {
      pinnedRepositoriesView.isHidden = true
    }

    if let topRepositories = summary.user.topRepositories?.nodes,
       !topRepositories.isEmpty
    {
      let repositories =
        topRepositories
          .map {
            ShortRepositoryInfoCollectionViewCell.ViewModel(
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
            sectionTitle: "Top repositories",
            actionTitle: "View all"
          ),
          items: repositories
        )
      )
    } else {
      topRepositoriesView.isHidden = true
    }

    if let starredRepositories = summary.user.starredRepositories?.nodes,
       !starredRepositories.isEmpty
    {
      let repositories =
        starredRepositories
          .map {
            ShortRepositoryInfoCollectionViewCell.ViewModel(
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
            sectionTitle: "Starred repositories",
            actionTitle: "View all"
          ),
          items: repositories
        )
      )
    } else {
      topRepositoriesView.isHidden = true
    }
  }

  var dummyCellRepo: ShortRepositoryInfoCollectionViewCell.ViewModel {
    ShortRepositoryInfoCollectionViewCell.ViewModel(
      avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/4807617?v=4")!,
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
