import ComposableArchitecture
import Foundation
import Models

// MARK: - Contact Detail Feature
@Reducer
public struct ContactDetailFeature {

  // MARK: - State
  @ObservableState
  public struct State: Equatable {
    public let contact: Contact

    public init(contact: Contact) {
      self.contact = contact
    }
  }

  // MARK: - Action
  public enum Action {
    case onAppear
  }

  // MARK: - Reducer
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return .none
      }
    }
  }

  public init() {}
}
