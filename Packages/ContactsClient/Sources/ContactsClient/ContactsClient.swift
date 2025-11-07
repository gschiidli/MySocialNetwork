import ComposableArchitecture
import Foundation
import Models

// MARK: - Contacts Client
@DependencyClient
public struct ContactsClient: Sendable {
  public var fetchContacts: @Sendable () async throws -> [Contact]
}

extension ContactsClient: TestDependencyKey {
  public static let testValue = ContactsClient(
    fetchContacts: {
      [
        Contact(
          id: "1",
          givenName: "John",
          familyName: "Appleseed",
          relations: [
            Contact.Relation(
              name: "Jane",
              relationType: nil,
            )
          ]
        ),
        Contact(
          id: "2",
          givenName: "Jane",
          familyName: "Doe",
          relations: [
            Contact.Relation(
              name: "John",
              relationType: "sister",
            )
          ]
        ),
        Contact(id: "3", givenName: "Bob", familyName: "Smith"),
      ]
    }
  )
}

extension DependencyValues {
  public var contactsClient: ContactsClient {
    get { self[ContactsClient.self] }
    set { self[ContactsClient.self] = newValue }
  }
}

// MARK: - Errors
public enum ContactsError: Error, LocalizedError {
  case accessDenied

  public var errorDescription: String? {
    switch self {
    case .accessDenied:
      return "Access to contacts was denied. Please enable access in Settings."
    }
  }
}
