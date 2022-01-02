//
//  ProfileSummaryViewStub.swift
//  GHPViewerTests
//
//  Created by Andrés Pesate on 01/01/2022.
//

@testable import GHPViewer
import struct MockingHelpers.FunctionSpy

final class ProfileSummaryViewStub: ProfileSummaryViewProtocol {
  private(set) var isLoadingSpy = FunctionSpy<Bool, Void>()
  private(set) var didLoadDataSpy = FunctionSpy<ProfileSummaryViewModel, Void>()
  private(set) var didFailWithSpy = FunctionSpy<ProfileSummaryViewError, Void>()

  var isLoading: Bool = false {
    didSet {
      isLoadingSpy.call(parameters: isLoading)
    }
  }

  func didLoad(data: ProfileSummaryViewModel) {
    didLoadDataSpy.call(parameters: data)
  }

  func didFail(with error: ProfileSummaryViewError) {
    didFailWithSpy.call(parameters: error)
  }
}
