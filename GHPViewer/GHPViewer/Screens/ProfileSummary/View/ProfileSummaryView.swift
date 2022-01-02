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

  func configure(with summary: ProfileSummaryViewModel) {
    headerView.configure(with: summary.header)

    if let model = summary.pinnedItems {
      pinnedRepositoriesView.configure(with: model)
      pinnedRepositoriesView.isHidden = false
    } else {
      pinnedRepositoriesView.isHidden = true
    }

    if let model = summary.topRepositories {
      topRepositoriesView.configure(with: model)
      topRepositoriesView.isHidden = false
    } else {
      topRepositoriesView.isHidden = true
    }

    if let model = summary.starredRepositories {
      starredRepositoriesView.configure(with: model)
      starredRepositoriesView.isHidden = false
    } else {
      starredRepositoriesView.isHidden = true
    }
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
