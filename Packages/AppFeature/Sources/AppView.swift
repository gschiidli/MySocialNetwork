import SwiftUI
import ComposableArchitecture
import ContactDetailFeature
import Models

public struct AppView: View {
  @Bindable var store: StoreOf<AppFeature>

  public init(store: StoreOf<AppFeature>) {
    self.store = store
  }

  public var body: some View {
    NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
      Group {
        if store.isLoading {
          ProgressView("Loading contacts...")
        } else if let error = store.error {
          VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
              .font(.system(size: 50))
              .foregroundStyle(.red)
            Text("Error")
              .font(.title2)
              .bold()
            Text(error)
              .multilineTextAlignment(.center)
              .foregroundStyle(.secondary)
          }
          .padding()
        } else if store.contacts.isEmpty {
          ContentUnavailableView(
            "No Contacts",
            systemImage: "person.crop.circle.badge.xmark",
            description: Text("You don't have any contacts yet.")
          )
        } else {
          List(store.contacts) { contact in
            Button {
              store.send(.contactTapped(contact))
            } label: {
              HStack {
                Image(systemName: "person.circle.fill")
                  .font(.title2)
                  .foregroundStyle(.blue)
                VStack(alignment: .leading) {
                  Text("\(contact.givenName) \(contact.familyName)")
                    .font(.headline)
                }
              }
              .padding(.vertical, 4)
            }
          }
        }
      }
      .navigationTitle("Contacts")
      .onAppear {
        store.send(.onAppear)
      }
    } destination: { store in
      switch store.case {
      case .detail(let store):
        ContactDetailView(store: store)
      }
    }
  }
}

#Preview {
  AppView(
    store: Store(initialState: AppFeature.State()) {
      AppFeature()
    } withDependencies: {
      $0.contactsClient = .testValue
    }
  )
}
