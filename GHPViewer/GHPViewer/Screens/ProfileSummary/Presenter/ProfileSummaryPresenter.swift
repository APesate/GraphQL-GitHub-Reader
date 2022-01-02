//
//  ProfileSummaryPresenter.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 30/12/2021.
//

import enum GraphQLClient.GraphQLClientError

final class ProfileSummaryPresenter: ProfileSummaryPresenterProtocol {
  weak var view: ProfileSummaryViewProtocol?

  private let profileSummaryRepository: ProfileSummaryRepositoryProtocol
  private(set) var profileSummary: ProfileSummary?

  init(profileSummaryRepository: ProfileSummaryRepositoryProtocol) {
    self.profileSummaryRepository = profileSummaryRepository
  }

  // MARK: - Interface

  func viewDidLoad() {
    loadData()
  }

  func reloadData() {
    loadData()
  }

  // MARK: - Private

  private func loadData() {
    view?.isLoading = true

    // TODO: Username should be a dynamic value.
    profileSummaryRepository.fetch(user: "apesate") { [weak self] result in
      guard let self = self else { return }
      self.view?.isLoading = false

      do {
        let model = try result.get()
        let viewModel = ProfileSummaryViewModel(model: model)
        self.profileSummary = model
        self.view?.didLoad(data: viewModel)
      } catch GraphQLClientError.noData {
        self.view?.didFail(with: .accountNotFound)
      } catch {
        self.view?.didFail(with: .somethingWentWrong)
      }
    }
  }
}
