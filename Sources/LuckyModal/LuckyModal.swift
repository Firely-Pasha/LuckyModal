import SwiftUI

enum LuckyModalType {
    case bottom
    case left
    case center
}

class LuckyModalManager: ObservableObject {
    
    @Published var isModalVisible = false
    @Published var alignment = Alignment.bottom
    @Published var edge = Edge.bottom
    @Published fileprivate var content: (() -> AnyView)? = nil
    
    func showModal<T: View>(alignment: Alignment = .bottom, edge: Edge = .bottom, @ViewBuilder content: @escaping () -> T) {
        self.edge = edge
        self.alignment = alignment
        self.content = { AnyView(content()) }
        self.isModalVisible = true
    }
    
    func closeModal() {
        self.isModalVisible = false
    }
}

private struct LuckyModal: View {
    
    @EnvironmentObject var luckyModal: LuckyModalManager
    
    private var contentAnimationDuration = 0.2
    private var backgroundAnimationDuration = 0.2
    
    var body: some View {
        ZStack(alignment: luckyModal.alignment) {
            if luckyModal.isModalVisible {
                Color.black.opacity(0.5)
                    .transition(
                        AnyTransition.opacity.animation(
                            .easeInOut(duration: backgroundAnimationDuration)
                        )
                    )
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        luckyModal.isModalVisible = false
                    }
                    .zIndex(0)
            }
            if luckyModal.isModalVisible {
                if let content = luckyModal.content {
                    if luckyModal.alignment == .center {
                        content()
                            .onTapGesture {
                                
                            }
                            .modifier(LuckyModalCenterModifier())
                            .animation(
                                .linear(duration: Double(contentAnimationDuration))
                            )
                            .transition(.move(edge: luckyModal.edge))
                            .zIndex(1)
                    } else {
                        content()
                            .modifier(LuckyModalCenterModifier())
                            .animation(
                                .linear(duration: Double(contentAnimationDuration))
                            )
                            .transition(.move(edge: luckyModal.edge))
                            .zIndex(1)
                    }
                }
            }
        }
    }
    
}

private struct LuckyModalCenterModifier: ViewModifier {
        
    func body(content: Content) -> some View {
        return VStack {
            Spacer()
            HStack {
                Spacer()
                content
                Spacer()
            }
            Spacer()
        }
    }
}

private struct LuckyModalModifier: ViewModifier {
    
    @ObservedObject var luckyModal = LuckyModalManager()
    
    func body(content: Content) -> some View {
        return ZStack {
            content
                .zIndex(0)
            LuckyModal()
                .zIndex(1)
        }
        .environmentObject(luckyModal)
    }
}

extension View {
    func luckyModal() -> some View {
        return self
            .modifier(LuckyModalModifier())
    }
}

