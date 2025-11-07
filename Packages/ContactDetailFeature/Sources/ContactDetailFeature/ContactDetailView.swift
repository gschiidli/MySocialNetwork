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

      if !store.contact.relations.isEmpty {
        Section("Relationships") {
          ForEach(store.contact.relations, id: \.name) { relation in
            HStack {
              Image(systemName: "person.2.fill")
                .foregroundStyle(.green)
              VStack(alignment: .leading, spacing: 4) {
                Text(relation.name)
                  .font(.headline)
                if let relationType = relation.relationType {
                  Text(relationType)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
              }
            }
            .padding(.vertical, 4)
          }
        }
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
