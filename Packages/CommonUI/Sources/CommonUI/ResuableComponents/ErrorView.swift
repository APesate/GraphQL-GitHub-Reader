//
//  ErrorView.swift
//  CommonUI
//
//  Created by Andrés Pesate on 29/12/2021.
//

import UIKit

public enum ErrorViewAccessibilityIdentifiers {
  static let iconImageView = "ev_icon_imageview"
  static let descriptionLabel = "ev_description_label"
}

private enum ErrorViewDesignGuidelines {
  static let iconLabelSpacing: CGFloat = 24.0
  static let iconSize = CGSize(width: 85, height: 85)
}

public final class ErrorView: UIView {
  public struct Model {
    var icon: UIImage?
    var description: String?

    public init(icon: UIImage?, description: String?) {
      self.icon = icon
      self.description = description
    }
  }

  public let iconImageView = UIImageView()
  public let descriptionLabel = UILabel()

  public init() {
    super.init(frame: .zero)

    setupComponents()
    setupConstraints()
    setupAccessibilityIdentifiers()
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Interface

  public var model: Model? {
    didSet {
      iconImageView.image = model?.icon
      descriptionLabel.text = model?.description
    }
  }

  // MARK: Private

  private func setupComponents() {
    iconImageView.contentMode = .scaleAspectFit

    descriptionLabel.numberOfLines = 0
    descriptionLabel.font = .preferredFont(forTextStyle: .callout)
    descriptionLabel.textColor = .secondaryLabel
    descriptionLabel.textAlignment = .center

    [iconImageView, descriptionLabel].forEach(addSubview(_:))
  }

  private func setupConstraints() {
    [iconImageView, descriptionLabel]
      .forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

    NSLayoutConstraint.activate([
      iconImageView.topAnchor.constraint(equalTo: topAnchor),
      iconImageView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
      iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      iconImageView.widthAnchor
        .constraint(equalToConstant: ErrorViewDesignGuidelines.iconSize.width),
      iconImageView.heightAnchor
        .constraint(equalToConstant: ErrorViewDesignGuidelines.iconSize.height),
      trailingAnchor.constraint(greaterThanOrEqualTo: iconImageView.trailingAnchor),

      descriptionLabel.topAnchor.constraint(
        equalTo: iconImageView.bottomAnchor,
        constant: ErrorViewDesignGuidelines.iconLabelSpacing
      ),
      descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
      bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
    ])

    descriptionLabel.setContentHuggingPriority(.required, for: .vertical)
    descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
  }

  private func setupAccessibilityIdentifiers() {
    iconImageView.accessibilityIdentifier = ErrorViewAccessibilityIdentifiers.iconImageView
    descriptionLabel.accessibilityIdentifier = ErrorViewAccessibilityIdentifiers.descriptionLabel
  }
}
