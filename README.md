# LuckyModal

## How to use
1. Apply  `luckyModal()` to your `ContentView`:
```swift
@main
struct LibTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .luckyModal()
        }
    }
}
```
2. ` luckyModal()` will automatically add `LuckyModalManager` as an `EnvironmentObject`. So just add `EnvironmentObject` in a view where you want to use modal:
```swift
struct SomeView: View {
    
    @EnvironmentObject var luckyModal: LuckyModalManager

    var body: some View {
        ... // some code        
    }
}

```
3. And call `showModal()` method of `LuckyModalManager` object:
```swift
struct SomeView: View {
    
    ... // some code
    
    var body: some View {
        VStack {
            Button (action: {
                luckyModal.showModal(alignment: .bottom, edge: .bottom) {
                    VStack {
                        HStack {
                            Image(systemName: "person")
                            Text("Some text")
                        }
                        Button {
                            luckyModal.closeModal()
                        } label: {
                            Text("Close")
                        }
                    }
                    .padding()
                    .background(Color.init(.systemBackground))
                }
            }, label: {
                Text("Open")
            })
        }
    }
}
```
4. To close modal call `closeModal()` method.

## Docs
Documentation will be later... I hope.
