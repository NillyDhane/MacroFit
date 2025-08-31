import SwiftUI

// Custom layout for displaying macro nutrients in a triangular formation
struct MacroBreakdownLayout: Layout {
    var spacing: CGFloat = 20
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout CacheData
    ) -> CGSize {
        
        let maxSize = maxSize(subviews: subviews)
        let totalWidth = proposal.replacingUnspecifiedDimensions().width
        
        // Triangle formation for 3 macros (protein, carbs, fats)
        if subviews.count == 3 {
            let height = maxSize.height * 2 + spacing
            return CGSize(width: totalWidth, height: height)
        }
        
        // Horizontal layout for other counts
        let width = CGFloat(subviews.count) * (maxSize.width + spacing) - spacing
        return CGSize(width: min(width, totalWidth), height: maxSize.height)
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout CacheData
    ) {
        guard !subviews.isEmpty else { return }
        
        let maxSize = maxSize(subviews: subviews)
        
        // Triangle arrangement for 3 macro items
        if subviews.count == 3 {
            let centerX = bounds.midX
            let topY = bounds.minY
            let bottomY = bounds.minY + maxSize.height + spacing
            
            // Protein at top
            if subviews.indices.contains(0) {
                let position = CGPoint(x: centerX, y: topY + maxSize.height / 2)
                subviews[0].place(
                    at: position,
                    anchor: .center,
                    proposal: ProposedViewSize(maxSize)
                )
            }
            
            // Carbs at bottom left
            if subviews.indices.contains(1) {
                let position = CGPoint(
                    x: centerX - maxSize.width / 2 - spacing / 2,
                    y: bottomY + maxSize.height / 2
                )
                subviews[1].place(
                    at: position,
                    anchor: .center,
                    proposal: ProposedViewSize(maxSize)
                )
            }
            
            // Fats at bottom right
            if subviews.indices.contains(2) {
                let position = CGPoint(
                    x: centerX + maxSize.width / 2 + spacing / 2,
                    y: bottomY + maxSize.height / 2
                )
                subviews[2].place(
                    at: position,
                    anchor: .center,
                    proposal: ProposedViewSize(maxSize)
                )
            }
        } else {
            // Horizontal layout fallback
            var x = bounds.minX
            let y = bounds.midY
            
            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                let position = CGPoint(x: x + size.width / 2, y: y)
                subview.place(
                    at: position,
                    anchor: .center,
                    proposal: ProposedViewSize(size)
                )
                x += size.width + spacing
            }
        }
    }
    
    // Cache for performance
    struct CacheData {
        var maxSize: CGSize = .zero
    }
    
    func makeCache(subviews: Subviews) -> CacheData {
        CacheData(maxSize: maxSize(subviews: subviews))
    }
    
    func updateCache(_ cache: inout CacheData, subviews: Subviews) {
        cache.maxSize = maxSize(subviews: subviews)
    }
    
    typealias Cache = CacheData
    
    // Calculate maximum size from all subviews
    private func maxSize(subviews: Subviews) -> CGSize {
        var maxSize = CGSize.zero
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            maxSize.width = max(maxSize.width, size.width)
            maxSize.height = max(maxSize.height, size.height)
        }
        return maxSize
    }
}

// Circular layout for macro rings display
struct CircularMacroLayout: Layout {
    var radius: CGFloat = 100
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let diameter = radius * 2
        return CGSize(width: diameter, height: diameter)
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        guard !subviews.isEmpty else { return }
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let angleStep = (2 * CGFloat.pi) / CGFloat(subviews.count)
        
        for (index, subview) in subviews.enumerated() {
            // Start from top and distribute evenly
            let angle = CGFloat(index) * angleStep - CGFloat.pi / 2
            let x = center.x + cos(angle) * radius
            let y = center.y + sin(angle) * radius
            
            subview.place(
                at: CGPoint(x: x, y: y),
                anchor: .center,
                proposal: .unspecified
            )
        }
    }
}
