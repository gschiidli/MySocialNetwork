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
