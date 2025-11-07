import ComposableArchitecture
import ContactDetailFeature
import ContactsClient
import Foundation
import Models

// MARK: - App Feature
@Reducer
public struct AppFeature {

  // MARK: - Path Reducer
  @Reducer
  public enum Path {
    case detail(ContactDetailFeature)
  }

  // MARK: - State
  @ObservableState
  public struct State: Equatable {
    public var contacts: [Contact] = []
    public var isLoading = false
    public var error: String?
    public var path = StackState<Path.State>()

    public init() {}
  }

  // MARK: - Action
  public enum Action {
    case onAppear
    case contactsResponse(Result<[Contact], Error>)
    case contactTapped(Contact)
    case path(StackActionOf<Path>)
  }

  // MARK: - Dependencies
  @Dependency(\.contactsClient) var contactsClient

  // MARK: - Reducer
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        state.isLoading = true
        state.error = nil
        return .run { [contactsClient] send in
          await send(.contactsResponse(Result { try await contactsClient.fetchContacts() }))
        }

      case .contactsResponse(.success(let contacts)):
        state.isLoading = false
        state.contacts = contacts
        return .none

      case .contactsResponse(.failure(let error)):
        state.isLoading = false
        state.error = error.localizedDescription
        return .none

      case .contactTapped(let contact):
        state.path.append(.detail(ContactDetailFeature.State(contact: contact)))
        return .none

      case .path:
        return .none
      }
    }
    .forEach(\.path, action: \.path)
  }

  public init() {}
}

extension AppFeature.Path.State: Equatable {}
extension AppFeature.Path.Action: Equatable {}
