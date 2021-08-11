import PromiseKit

public class PromiseUtils {
    public static func attempt<T>(delayBeforeRetry: DispatchTimeInterval = .seconds(5), _ body: @escaping () -> Promise<T>) -> Promise<T> {
        func attempt() -> Promise<T> {
            return body().recover { error -> Promise<T> in
                return after(delayBeforeRetry).then(on: nil, attempt)
            }
        }
        return attempt()
    }
    
    public  static func attemptCancellable<T>(delayBeforeRetry: DispatchTimeInterval = .seconds(5), _ body: @escaping () -> Promise<T>) -> (Promise<T>, () -> ()) {
        var cancelMe = false
        func attempt() -> Promise<T> {
            return body().recover { error -> Promise<T> in
                guard !cancelMe else {
                    throw error
                }
                return after(delayBeforeRetry).then(on: nil, attempt)
            }
        }

        let cancel = { cancelMe = true }
        return (attempt(), cancel)
    }
    
    
}
