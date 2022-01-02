//
//  ProfileSummaryViewProtocol.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 31/12/2021.
//

protocol ProfileSummaryViewProtocol: AnyObject {
  var isLoading: Bool { get set }

  func didLoad(data: ProfileSummaryViewModel)
  func didFail(with error: ProfileSummaryViewError)
}
