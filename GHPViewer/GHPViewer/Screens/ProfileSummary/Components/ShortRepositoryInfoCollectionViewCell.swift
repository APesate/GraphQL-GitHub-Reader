//
//  ShortRepositoryInfoCollectionViewCell.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 30/12/2021.
//

import CommonUI
import UIKit

final class ShortRepositoryInfoCollectionViewCell: UICollectionViewCell {
  private let informationView = ShortRepositoryInfoView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupComponents()
    setupConstraints()
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Interface

  func configure(with model: ShortRepositoryInfoView.ViewModel) {
    informationView.ownerLabel.text = model.ownerName
    informationView.repositoryTitleLabel.text = model.repositoryTitle
    informationView.repositoryDescriptionLabel.text = model.repositoryDescription
    informationView.starsCountLabel.text = "\(model.starsCount)"
    informationView.mainLanguageLabel.text = model.mainLanguageName

    if let color = model.mainLanguageColor {
      informationView.mainLanguageView.backgroundColor = UIColor(hex: color) ?? .label
    }

    if let url = model.avatarUrl {
      informationView.avatarImageView.setImage(
        from: url,
        placeholder: UIImage(named: "avatar-placeholder")
      )
    }
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    informationView.ownerLabel.text = nil
    informationView.repositoryTitleLabel.text = nil
    informationView.repositoryDescriptionLabel.text = nil
    informationView.starsCountLabel.text = nil
    informationView.mainLanguageLabel.text = nil
    informationView.mainLanguageView.backgroundColor = .clear
  }

  // MARK: - Private

  // MARK: Views Setup

  private func setupComponents() {
    contentView.addSubview(informationView)
  }

  private func setupConstraints() {
    informationView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      informationView.topAnchor.constraint(
        equalTo: topAnchor,
        constant: DesignGuidelines.margins.top
      ),
      informationView.leadingAnchor.constraint(
        equalTo: leadingAnchor,
        constant: DesignGuidelines.margins.left
      ),
      bottomAnchor.constraint(
        equalTo: informationView.bottomAnchor,
        constant: DesignGuidelines.margins.bottom
      ),
      trailingAnchor.constraint(
        equalTo: informationView.trailingAnchor,
        constant: DesignGuidelines.margins.right
      ),
    ])
  }
}

// MARK: - Design Guidelines

extension ShortRepositoryInfoCollectionViewCell {
  enum DesignGuidelines {
    static let margins = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
  }
}
