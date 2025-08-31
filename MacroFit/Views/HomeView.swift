import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: UserProfileViewModel
    @State private var showingCalculator = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                headerSection

                // Main Content
                if viewModel.hasCalculatedTDEE {
                    currentStatsSection
                    quickActionsSection
                } else {
                    welcomeSection
                }

                Spacer(minLength: 50)
            }
            .padding()
        }
        .navigationTitle("MacroFit")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showingCalculator) {
            NavigationView {
                TDEECalculatorView()
            }
        }
    }

    // MARK: - View Components Title Test

    private var headerSection: some View {
        VStack(spacing: 10) {
            Image(systemName: "figure.run.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)

            Text("Your Fitness Journey Starts Here")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .padding(.top, 20)
    }

    private var welcomeSection: some View {
        VStack(spacing: 20) {
            Text("Welcome to MacroFit!")
                .font(.title2)
                .fontWeight(.bold)

            Text("Calculate your daily calorie needs and get personalized meal recommendations")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            NavigationLink(destination: TDEECalculatorView()) {
                Label("Calculate TDEE", systemImage: "plus.circle.fill")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 30)

            // Sample meals preview
            VStack(alignment: .leading, spacing: 10) {
                Text("Featured Meals")
                    .font(.headline)
                    .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(MockData.meals.prefix(3)) { meal in
                            MiniMealCard(meal: meal)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }

    private var currentStatsSection: some View {
        VStack(spacing: 15) {
            Text("Your Daily Targets")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Calorie Card
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Daily Calories")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(viewModel.userProfile.targetCalories)")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("\(viewModel.userProfile.goal.rawValue) Goal")
                        .font(.caption)
                        .foregroundColor(Color(viewModel.userProfile.goal.color))
                }

                Spacer()

                Image(systemName: "flame.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.orange)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)

            // Macros Summary
            HStack(spacing: 15) {
                MacroCard(
                    title: "Protein",
                    value: viewModel.userProfile.macros.protein,
                    unit: "g",
                    color: .red
                )
                MacroCard(
                    title: "Carbs",
                    value: viewModel.userProfile.macros.carbs,
                    unit: "g",
                    color: .blue
                )
                MacroCard(
                    title: "Fats",
                    value: viewModel.userProfile.macros.fats,
                    unit: "g",
                    color: .green
                )
            }
        }
    }

    private var quickActionsSection: some View {
        VStack(spacing: 15) {
            Text("Quick Actions")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            NavigationLink(destination: ResultsView()) {
                ActionCard(
                    title: "View Full Results",
                    icon: "chart.bar.fill",
                    color: .blue
                )
            }

            NavigationLink(destination: PreferencesView()) {
                ActionCard(
                    title: "Set Meal Preferences",
                    icon: "slider.horizontal.3",
                    color: .green
                )
            }

            NavigationLink(destination: MealListView()) {
                ActionCard(
                    title: "Browse Meals",
                    icon: "fork.knife.circle.fill",
                    color: .orange
                )
            }

            Button(action: {
                showingCalculator = true
            }) {
                ActionCard(
                    title: "Recalculate TDEE",
                    icon: "arrow.clockwise",
                    color: .purple
                )
            }
        }
    }
}

// MARK: - Supporting Views

struct MacroCard: View {
    let title: String
    let value: Int
    let unit: String
    let color: Color

    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text("\(value)")
                .font(.title2)
                .fontWeight(.bold)
            Text(unit)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(color.opacity(0.1))
        .cornerRadius(10)
    }
}

struct ActionCard: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 40)

            Text(title)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.primary)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct MiniMealCard: View {
    let meal: Meal

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(
                    colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 150, height: 100)
                .overlay(
                    Image(systemName: "fork.knife")
                        .font(.title)
                        .foregroundColor(.white)
                )

            Text(meal.name)
                .font(.caption)
                .fontWeight(.medium)
                .lineLimit(1)

            HStack(spacing: 4) {
                Image(systemName: "flame.fill")
                    .font(.caption2)
                    .foregroundColor(.orange)
                Text("\(meal.calories) cal")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 150)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(UserProfileViewModel())
        }
    }
}
