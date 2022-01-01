//
//  ShortRepositoryInfoView.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 30/12/2021.
//

import CommonUI
import UIKit

final class ShortRepositoryInfoView: UIView {
  private let contentStackView = UIStackView()
  private let ownerInfoStackView = UIStackView()
  private let starsLanguageStackView = UIStackView()

  private let starImageView = UIImageView()

  let avatarImageView = UIImageView()
  let ownerLabel = UILabel()
  let repositoryTitleLabel = UILabel()
  let repositoryDescriptionLabel = UILabel()
  let starsCountLabel = UILabel()
  let mainLanguageLabel = UILabel()
  let mainLanguageView = UIView()

  init() {
    super.init(frame: .zero)
    setupComponents()
    setupConstraints()
  }

  init(model: ViewModel) {
    super.init(frame: .zero)
    setupComponents()
    setupConstraints()
    configure(with: model)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Interface

  func configure(with model: ViewModel) {
    ownerLabel.text = model.ownerName
    repositoryTitleLabel.text = model.repositoryTitle
    repositoryDescriptionLabel.text = model.repositoryDescription
    starsCountLabel.text = "\(model.starsCount)"
    mainLanguageLabel.text = model.mainLanguageName

    if let color = model.mainLanguageColor {
      mainLanguageView.backgroundColor = UIColor(hex: color) ?? .label
    }

    if let url = model.avatarUrl {
      avatarImageView.setImage(
        from: url,
        placeholder: UIImage(named: "avatar-placeholder")
      )
    }
  }

  // MARK: - Private

  // MARK: Views Setup

  private func setupComponents() {
    layer.borderColor = UIColor.lightGray.cgColor
    layer.borderWidth = DesignGuidelines.borderWidth
    layer.cornerRadius = DesignGuidelines.borderRadius

    avatarImageView.clipsToBounds = true
    avatarImageView.layer.cornerRadius = DesignGuidelines.avatarImageCornerRadius

    mainLanguageView.clipsToBounds = true
    mainLanguageView.layer.cornerRadius = DesignGuidelines.mainLanguageColorViewRadius

    ownerLabel.font = .systemFont(ofSize: 16, weight: .regular)
    ownerLabel.textColor = .label

    repositoryTitleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    repositoryTitleLabel.textColor = .label

    // Number of lines capped at 1 to preserve consistency. Design didn't specify
    repositoryDescriptionLabel.font = .systemFont(ofSize: 16, weight: .regular)
    repositoryDescriptionLabel.textColor = .label

    starsCountLabel.font = .systemFont(ofSize: 16, weight: .regular)
    starsCountLabel.textColor = .label

    mainLanguageLabel.font = .systemFont(ofSize: 16, weight: .regular)
    mainLanguageLabel.textColor = .label

    starImageView.image = UIImage(named: "star")

    [avatarImageView, ownerLabel, UIView.spacerView()]
      .forEach(ownerInfoStackView.addArrangedSubview(_:))
    ownerInfoStackView.axis = .horizontal
    ownerInfoStackView.alignment = .center
    ownerInfoStackView.distribution = .fill
    ownerInfoStackView.spacing = DesignGuidelines.avatarLabelSpacing

    [starImageView, starsCountLabel, mainLanguageView, mainLanguageLabel, UIView.spacerView()]
      .forEach(starsLanguageStackView.addArrangedSubview(_:))
    starsLanguageStackView.axis = .horizontal
    starsLanguageStackView.alignment = .center
    starsLanguageStackView.distribution = .fill
    starsLanguageStackView.spacing = DesignGuidelines.iconLabelSpacing
    starsLanguageStackView.setCustomSpacing(
      DesignGuidelines.starsLanguageSpacing,
      after: starsCountLabel
    )

    [
      ownerInfoStackView,
      repositoryTitleLabel,
      repositoryDescriptionLabel,
      starsLanguageStackView,
    ]
    .forEach(contentStackView.addArrangedSubview(_:))
    contentStackView.axis = .vertical
    contentStackView.alignment = .fill
    contentStackView.distribution = .fill
    contentStackView.spacing = DesignGuidelines.contentSpacing
    contentStackView.setCustomSpacing(
      DesignGuidelines.descriptionLabelStarsImageSpacing,
      after: repositoryDescriptionLabel
    )

    addSubview(contentStackView)
  }

  private func setupConstraints() {
    [contentStackView, avatarImageView, starImageView, mainLanguageView]
      .forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

    NSLayoutConstraint.activate([
      contentStackView.topAnchor.constraint(
        equalTo: topAnchor,
        constant: DesignGuidelines.margins.top
      ),
      contentStackView.leadingAnchor.constraint(
        equalTo: leadingAnchor,
        constant: DesignGuidelines.margins.left
      ),
      bottomAnchor.constraint(
        equalTo: contentStackView.bottomAnchor,
        constant: DesignGuidelines.margins.bottom
      ),
      trailingAnchor.constraint(
        equalTo: contentStackView.trailingAnchor,
        constant: DesignGuidelines.margins.right
      ),

      avatarImageView.widthAnchor
        .constraint(equalToConstant: DesignGuidelines.avatarImageSize.width),
      avatarImageView.heightAnchor
        .constraint(equalToConstant: DesignGuidelines.avatarImageSize.height),

      starImageView.widthAnchor
        .constraint(equalToConstant: DesignGuidelines.startImageSize.width),
      starImageView.heightAnchor
        .constraint(equalToConstant: DesignGuidelines.startImageSize.height),

      mainLanguageView.widthAnchor
        .constraint(equalToConstant: DesignGuidelines.mainLanguageColorViewSize.width),
      mainLanguageView.heightAnchor
        .constraint(equalToConstant: DesignGuidelines.mainLanguageColorViewSize.height),
    ])
  }
}

// MARK: - View Model

extension ShortRepositoryInfoView {
  struct ViewModel: Hashable {
    let id = UUID()
    let avatarUrl: URL?
    let ownerName: String
    let repositoryTitle: String
    let repositoryDescription: String?
    let starsCount: Int
    let mainLanguageName: String?
    let mainLanguageColor: String?
  }
}

// MARK: - Design Guidelines

extension ShortRepositoryInfoView {
  enum DesignGuidelines {
    static let margins = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 28.0, right: 16.0)
    static let borderRadius: CGFloat = 8.0
    static let borderWidth: CGFloat = 1.0
    static let startImageSize = CGSize(width: 12.0, height: 12.0)
    static let mainLanguageColorViewSize = CGSize(width: 10.0, height: 10.0)
    static let mainLanguageColorViewRadius: CGFloat = mainLanguageColorViewSize.height / 2
    static let avatarImageSize = CGSize(width: 32.0, height: 32.0)
    static let avatarImageCornerRadius: CGFloat = avatarImageSize.height / 2

    static let contentSpacing: CGFloat = 4.0
    static let avatarLabelSpacing: CGFloat = 8.0
    static let descriptionLabelStarsImageSpacing: CGFloat = 16.0
    static let iconLabelSpacing: CGFloat = 4.0
    static let starsLanguageSpacing: CGFloat = 24.0
  }
}
