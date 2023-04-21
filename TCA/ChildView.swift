import ComposableArchitecture
import SwiftUI

struct ChildView: View {
    typealias Reducer = AppReducer
    let store: StoreOf<Reducer>
    
    public init(store: StoreOf<Reducer>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                Text("Child View")
                    .padding()
                Text("count: \(viewStore.state.count)")
                    .padding()
                Button("+2", action: { viewStore.send(.plustwo) })
                    .padding()
            }
            .font(.title)
        }
    }
}

struct ChildView_Previews: PreviewProvider {
    static var previews: some View {
        ChildView(store: Store(initialState: AppReducer.State(), reducer: AppReducer()))
    }
}
