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
    loadData()
  }

  func reloadData() {
    loadData()
  }

  // MARK: - Private

  private func loadData() {
    profileSummaryRepository.fetch { [weak self] result in
      guard let self = self else { return }

      do {
        let model = try result.get()
        self.profileSummary = model
        self.view?.didLoad(data: model)
      } catch {
        print(error)
      }
    }
  }
}
