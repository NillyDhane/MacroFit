import SwiftUI

// Reusable Macro Circle Component
struct MacroCircleView: View {
    let protein: Int
    let carbs: Int
    let fats: Int
    let totalCalories: Int
    
    private var proteinPercentage: Double {
        Double(protein * 4) / Double(totalCalories) * 100
    }
    
    private var carbsPercentage: Double {
        Double(carbs * 4) / Double(totalCalories) * 100
    }
    
    private var fatsPercentage: Double {
        Double(fats * 9) / Double(totalCalories) * 100
    }
    
    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 20)
            
            // Protein arc
            Circle()
                .trim(from: 0, to: proteinPercentage / 100)
                .stroke(Color.red, lineWidth: 20)
                .rotationEffect(.degrees(-90))
            
            // Carbs arc
            Circle()
                .trim(from: proteinPercentage / 100,
                      to: (proteinPercentage + carbsPercentage) / 100)
                .stroke(Color.blue, lineWidth: 20)
                .rotationEffect(.degrees(-90))
            
            // Fats arc
            Circle()
                .trim(from: (proteinPercentage + carbsPercentage) / 100,
                      to: 1)
                .stroke(Color.green, lineWidth: 20)
                .rotationEffect(.degrees(-90))
            
            // Center text
            VStack {
                Text("\(totalCalories)")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("calories")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

// Animated Progress Ring
struct AnimatedMacroRing: View {
    let value: Double // 0.0 to 1.0
    let color: Color
    let label: String
    @State private var animatedValue: Double = 0
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                // Background ring
                Circle()
                    .stroke(color.opacity(0.2), lineWidth: 12)
                
                // Animated ring
                Circle()
                    .trim(from: 0, to: animatedValue)
                    .stroke(
                        LinearGradient(
                            colors: [color, color.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 12, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 1.0), value: animatedValue)
                
                // Percentage text
                Text("\(Int(value * 100))%")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            
            Text(label)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
        }
        .onAppear {
            animatedValue = value
        }
    }
}

// Gradient Button Component
struct GradientButton: View {
    let title: String
    let icon: String?
    let action: () -> Void
    
    init(title: String, icon: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.body.bold())
                }
                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                LinearGradient(
                    colors: [Color.blue, Color.purple],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(12)
            .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 3)
        }
    }
}

// Stats Card Component
struct StatsCard: View {
    let title: String
    let value: String
    let subtitle: String?
    let icon: String
    let color: Color
    
    init(title: String, value: String, subtitle: String? = nil, icon: String, color: Color) {
        self.title = title
        self.value = value
        self.subtitle = subtitle
        self.icon = icon
        self.color = color
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption2)
                        .foregroundColor(color)
                }
            }
            
            Spacer()
            
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
                .padding()
                .background(color.opacity(0.1))
                .clipShape(Circle())
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
}

// Nutrition Badge
struct NutritionBadge: View {
    let value: Int
    let unit: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 2) {
                Text("\(value)")
                    .font(.headline)
                    .fontWeight(.bold)
                Text(unit)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .foregroundColor(color)
            
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(color.opacity(0.1))
        .cornerRadius(10)
    }
}

// Loading View
struct LoadingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 4)
                    .frame(width: 60, height: 60)
                
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 4
                    )
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(isAnimating ? 360 : 0))
                    .animation(
                        .linear(duration: 1)
                        .repeatForever(autoreverses: false),
                        value: isAnimating
                    )
            }
            
            Text("Calculating...")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .onAppear {
            isAnimating = true
        }
    }
}
