//
//  ProfileSummaryPresenter.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 30/12/2021.
//

final class ProfileSummaryPresenter: ProfileSummaryPresenterProtocol {
  weak var view: ProfileSummaryViewProtocol?

  private let profileSummaryRepository: ProfileSummaryRepositoryProtocol
  private var profileSummary: ProfileSummary?

  init(profileSummaryRepository: ProfileSummaryRepositoryProtocol) {
    self.profileSummaryRepository = profileSummaryRepository
  }

  // MARK: - Interface

  func viewDidLoad() {
    profileSummaryRepository.fetch { [weak self] result in
      guard let self = self else { return }

      switch result {
      case let .success(model):
        self.profileSummary = model
        self.view?.configure(with: model)

      case let .failure(error):
        print(error)
      }
    }
  }

  // MARK: - Private
}
