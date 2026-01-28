import ComposableArchitecture
import Foundation
import Models
import SQLiteData

// MARK: - Contact Detail Feature
@Reducer
public struct ContactDetailFeature {

  // MARK: - State
  @ObservableState
  public struct State: Equatable {
    public let contact: Contact
    public var relationships: [ContactRelationship] = []
    public var isLoadingRelationships = false

    public init(contact: Contact) {
      self.contact = contact
    }
  }

  // MARK: - Action
  public enum Action: Equatable {
    case onAppear
    case relationshipsResponse(Result<[ContactRelationship], Error>)

    public static func == (lhs: Action, rhs: Action) -> Bool {
      switch (lhs, rhs) {
      case (.onAppear, .onAppear):
        return true
      case (.relationshipsResponse(.success(let lhsValue)), .relationshipsResponse(.success(let rhsValue))):
        return lhsValue == rhsValue
      case (.relationshipsResponse(.failure), .relationshipsResponse(.failure)):
        return true
      default:
        return false
      }
    }
  }

  // MARK: - Dependencies
  @Dependency(\.defaultDatabase) var database

  // MARK: - Reducer
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        state.isLoadingRelationships = true
        let contactID = state.contact.id
        return .none

      case .relationshipsResponse(.success(let relationships)):
        state.isLoadingRelationships = false
        state.relationships = relationships
        return .none

      case .relationshipsResponse(.failure):
        state.isLoadingRelationships = false
        return .none
      }
    }
  }

  public init() {}
}
