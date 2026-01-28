import SwiftUI
import ComposableArchitecture
import Models

public struct ContactDetailView: View {
  let store: StoreOf<ContactDetailFeature>

  public init(store: StoreOf<ContactDetailFeature>) {
    self.store = store
  }

  public var body: some View {
    List {
      Section {
        HStack {
          Spacer()
          Image(systemName: "person.circle.fill")
            .font(.system(size: 100))
            .foregroundStyle(.blue)
          Spacer()
        }
        .padding(.vertical, 20)
      }

      Section("Name") {
        LabeledContent("First Name", value: store.contact.givenName)
        LabeledContent("Last Name", value: store.contact.familyName)
      }

      Section("Information") {
        LabeledContent("Contact ID", value: store.contact.id)
      }

      Section {
        if store.isLoadingRelationships {
          HStack {
            Spacer()
            ProgressView()
            Spacer()
          }
        } else if store.relationships.isEmpty && store.contact.relations.isEmpty {
          ContentUnavailableView(
            "No Relationships",
            systemImage: "person.2.slash",
            description: Text("No family or social relationships found.")
          )
        } else {
          // Show relationships from database (CloudKit synced)
          if !store.relationships.isEmpty {
            ForEach(store.relationships) { relationship in
              let isContact1 = relationship.contactID1 == store.contact.id
              let relationType = isContact1 ? relationship.relationType1To2 : relationship.relationType2To1
              let relatedContactID = isContact1 ? relationship.contactID2 : relationship.contactID1

              HStack {
                Image(systemName: "person.2.fill")
                  .foregroundStyle(.blue)
                VStack(alignment: .leading, spacing: 4) {
                  Text(relationType.capitalized)
                    .font(.headline)
                  Text("Contact: \(relatedContactID)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                  Text("Synced via CloudKit")
                    .font(.caption2)
                    .foregroundStyle(.green)
                }
              }
              .padding(.vertical, 4)
            }
          }

          // Show relationships from device contacts
          if !store.contact.relations.isEmpty {
            ForEach(store.contact.relations, id: \.name) { relation in
              HStack {
                Image(systemName: "person.2.fill")
                  .foregroundStyle(.orange)
                VStack(alignment: .leading, spacing: 4) {
                  Text(relation.name)
                    .font(.headline)
                  if let relationType = relation.relationType {
                    Text(relationType)
                      .font(.caption)
                      .foregroundStyle(.secondary)
                  }
                  Text("From device contacts")
                    .font(.caption2)
                    .foregroundStyle(.orange)
                }
              }
              .padding(.vertical, 4)
            }
          }
        }
      } header: {
        Text("Relationships")
      }
    }
    .navigationTitle("\(store.contact.givenName) \(store.contact.familyName)")
    .navigationBarTitleDisplayMode(.inline)
    .onAppear {
      store.send(.onAppear)
    }
  }
}

#Preview {
  NavigationStack {
    ContactDetailView(
      store: Store(initialState: ContactDetailFeature.State(
        contact: Contact(id: "1", givenName: "John", familyName: "Appleseed")
      )) {
        ContactDetailFeature()
      }
    )
  }
}
