//
//  ProfileSummaryViewError.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 31/12/2021.
//

enum ProfileSummaryViewError: Error, Equatable {
  case accountNotFound
  case somethingWentWrong

  var localizedDescription: String {
    switch self {
      case .somethingWentWrong:
        return "error-generic".localized
      case .accountNotFound:
        return "error-account-not-found".localized
    }
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    switch (lhs, rhs) {
    case (.accountNotFound, .accountNotFound):
      return true
    case (.somethingWentWrong, .somethingWentWrong):
      return true
    default:
      return false
    }
  }
}
