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

      // Fetch all contacts with their relations
      let keysToFetch: [CNKeyDescriptor] = [
        CNContactIdentifierKey as CNKeyDescriptor,
        CNContactGivenNameKey as CNKeyDescriptor,
        CNContactFamilyNameKey as CNKeyDescriptor,
        CNContactRelationsKey as CNKeyDescriptor,
      ]

      let request = CNContactFetchRequest(keysToFetch: keysToFetch)
      var contacts: [Contact] = []

      // First pass: build contact name lookup and initialize contacts
      try store.enumerateContacts(with: request) { cnContact, _ in
        let relations = cnContact.contactRelations.map { relation in
          Contact.Relation(
            name: relation.value.name,
            relationType: relation.label,
          )
        }
        contacts.append(
          Contact(
            id: cnContact.identifier,
            givenName: cnContact.givenName,
            familyName: cnContact.familyName,
            relations: relations
          )
        )
      }

      return contacts
    }
  )
}
