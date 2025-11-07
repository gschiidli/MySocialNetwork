import ComposableArchitecture
import Contacts
import ContactsClient
import Foundation
import Models

extension ContactsClient: DependencyKey {
  public static let liveValue = ContactsClient(
    fetchContacts: {
      let store = CNContactStore()

      // Request access to contacts
      let granted = try await store.requestAccess(for: .contacts)
      guard granted else {
        throw ContactsError.accessDenied
      }

      // Define the keys we want to fetch
      let keysToFetch: [CNKeyDescriptor] = [
        CNContactGivenNameKey as CNKeyDescriptor,
        CNContactFamilyNameKey as CNKeyDescriptor,
        CNContactIdentifierKey as CNKeyDescriptor,
      ]

      // Fetch all contacts
      let request = CNContactFetchRequest(keysToFetch: keysToFetch)
      var contacts: [Contact] = []

      try store.enumerateContacts(with: request) { cnContact, _ in
        let contact = Contact(
          id: cnContact.identifier,
          givenName: cnContact.givenName,
          familyName: cnContact.familyName
        )
        contacts.append(contact)
      }

      return contacts
    }
  )
}
