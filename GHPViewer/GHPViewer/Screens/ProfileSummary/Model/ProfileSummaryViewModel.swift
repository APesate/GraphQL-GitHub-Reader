//
//  ProfileSummaryViewModel.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 02/01/2022.
//

struct ProfileSummaryViewModel: Equatable {
  let header: ProfileSummaryHeaderView.ViewModel
  let pinnedItems: VerticalShowcase.ViewModel?
  let topRepositories: HorizontalShowcase.ViewModel?
  let starredRepositories: HorizontalShowcase.ViewModel?

  init(model: ProfileSummary) {
    header = Self.headerViewModel(from: model)
    pinnedItems = Self.pinnedViewModel(from: model)
    topRepositories = Self.topRepositoriesViewModel(from: model)
    starredRepositories = Self.starredRepositoriesViewModel(from: model)
  }
}

// MARK: - Mapper

// TODO: This extension could be moved into a factory class to build and configure the view model. Keeping it here for simplicity.
private extension ProfileSummaryViewModel {
  static func headerViewModel(
    from summary: ProfileSummary
  ) -> ProfileSummaryHeaderView.ViewModel {
    ProfileSummaryHeaderView.ViewModel(
      avatarUrl: summary.user.avatarUrl,
      name: summary.user.name,
      username: summary.user.username,
      followersCount: summary.user.followers.totalCount,
      followingCount: summary.user.following.totalCount,
      email: summary.user.email
    )
  }

  static func pinnedViewModel(
    from summary: ProfileSummary
  ) -> VerticalShowcase.ViewModel? {
    guard let pinnedItems = summary.user.pinnedItems?.nodes,
          !pinnedItems.isEmpty
    else {
      return nil
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

    return VerticalShowcase.ViewModel(
      header: SectionHeader.ViewModel(
        sectionTitle: "pinned".localized,
        actionTitle: "view-all".localized
      ),
      items: repositories
    )
  }

  static func topRepositoriesViewModel(
    from summary: ProfileSummary
  ) -> HorizontalShowcase.ViewModel? {
    guard let topRepositories = summary.user.topRepositories?.nodes,
          !topRepositories.isEmpty
    else {
      return nil
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

    return HorizontalShowcase.ViewModel(
      header: SectionHeader.ViewModel(
        sectionTitle: "top-repositories".localized,
        actionTitle: "view-all".localized
      ),
      items: repositories
    )
  }

  static func starredRepositoriesViewModel(
    from summary: ProfileSummary
  ) -> HorizontalShowcase.ViewModel? {
    guard let starredRepositories = summary.user.starredRepositories?.nodes,
          !starredRepositories.isEmpty
    else {
      return nil
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

    return HorizontalShowcase.ViewModel(
      header: SectionHeader.ViewModel(
        sectionTitle: "starred-repositories".localized,
        actionTitle: "view-all".localized
      ),
      items: repositories
    )
  }
}
