import SwiftUI

struct PaywallView: View {
    @EnvironmentObject var purchases: PurchaseManager
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()
                VStack(spacing: 20) {
                    Image(systemName: "star.circle.fill")
                        .resizable()
                        .frame(width: 72, height: 72)
                        .foregroundColor(Theme.accent)
                    Text("Model Kit Shelf Pro")
                        .font(Theme.titleFont)
                        .foregroundColor(Theme.textPrimary)
                    Text("Unlimited kits and build-log photo timeline")
                        .font(Theme.bodyFont)
                        .foregroundColor(Theme.textMuted)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Button(action: {
                        Task {
                            await purchases.purchase()
                            if purchases.isPro { dismiss() }
                        }
                    }) {
                        Text(purchases.product?.displayPrice ?? "$\(2.99)")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.accent)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                    }
                    .accessibilityIdentifier("purchaseButton")
                    .padding(.horizontal)
                    Button("Restore Purchases") {
                        Task { await purchases.restore() }
                    }
                    .accessibilityIdentifier("paywallRestoreButton")
                    .foregroundColor(Theme.textMuted)
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                        .accessibilityIdentifier("paywallCloseButton")
                }
            }
        }
    }
}
