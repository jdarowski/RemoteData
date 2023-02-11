public enum RemoteData<V, E: Error> {
    case notAsked
    case loading
    case failure(error: E)
    case success(value: V)
}
