import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var viewModel: UserProfileViewModel
    @State private var selectedGoal: FitnessGoal = .maintenance
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // TDEE Result Card
                tdeeCard
                
                // Goal Selector
                goalSelector
                
                // Calories for Selected Goal
                calorieCard
                
                // Macros Breakdown
                macrosSection
                
                // Visual Macro Distribution
                macroDistributionView
                
                // Next Steps
                nextStepsSection
            }
            .padding()
        }
        .navigationTitle("Your Results")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            selectedGoal = viewModel.userProfile.goal
        }
    }
    
    // MARK: - View Components
    
    private var tdeeCard: some View {
        VStack(spacing: 10) {
            Text("Your TDEE")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("\(viewModel.userProfile.tdee)")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.blue)
            
            Text("calories/day")
                .font(.title3)
                .foregroundColor(.secondary)
            
            Text("This is your Total Daily Energy Expenditure - the calories you burn daily")
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemGray6))
        )
    }
    
    private var goalSelector: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Select Your Goal")
                .font(.headline)
            
            Picker("Goal", selection: $selectedGoal) {
                ForEach(FitnessGoal.allCases, id: \.self) { goal in
                    Text(goal.rawValue).tag(goal)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedGoal) { _, newValue in
                viewModel.updateGoal(newValue)
            }
        }
    }
    
    private var calorieCard: some View {
        HStack(spacing: 20) {
            // Maintenance for reference
            VStack(spacing: 5) {
                Text("Maintenance")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("\(viewModel.userProfile.tdee)")
                    .font(.title3)
                    .fontWeight(.semibold)
                Text("cal/day")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(selectedGoal == .maintenance ? Color.blue.opacity(0.2) : Color(.systemGray6))
            )
            
            // Selected Goal Calories
            VStack(spacing: 5) {
                Text(selectedGoal.rawValue)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("\(viewModel.getCaloriesForGoal(selectedGoal))")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(selectedGoal.color))
                Text("cal/day")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                
                if selectedGoal != .maintenance {
                    Text("\(selectedGoal.calorieAdjustment > 0 ? "+" : "")\(selectedGoal.calorieAdjustment)")
                        .font(.caption)
                        .foregroundColor(Color(selectedGoal.color))
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(selectedGoal.color).opacity(0.2))
            )
        }
    }
    
    private var macrosSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Recommended Macros")
                .font(.headline)
            
            let macros = viewModel.getMacrosForGoal(selectedGoal)
            
            // Protein
            MacroRow(
                name: "Protein",
                grams: macros.protein,
                percentage: macros.proteinPercentage,
                color: .red,
                icon: "p.circle.fill"
            )
            
            // Carbs
            MacroRow(
                name: "Carbohydrates",
                grams: macros.carbs,
                percentage: macros.carbsPercentage,
                color: .blue,
                icon: "c.circle.fill"
            )
            
            // Fats
            MacroRow(
                name: "Fats",
                grams: macros.fats,
                percentage: macros.fatsPercentage,
                color: .green,
                icon: "f.circle.fill"
            )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemGray6))
        )
    }
    
    private var macroDistributionView: some View {
        VStack(spacing: 10) {
            Text("Macro Distribution")
                .font(.headline)
            
            let macros = viewModel.getMacrosForGoal(selectedGoal)
            
            // Custom Ring Layout will go here
            MacroRingsView(
                protein: macros.proteinPercentage,
                carbs: macros.carbsPercentage,
                fats: macros.fatsPercentage
            )
            .frame(height: 200)
        }
    }
    
    private var nextStepsSection: some View {
        VStack(spacing: 15) {
            Text("Next Steps")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            NavigationLink(destination: PreferencesView()) {
                HStack {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title2)
                        .foregroundColor(.green)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Set Dietary Preferences")
                            .font(.body)
                            .fontWeight(.medium)
                        Text("Customize meals to your needs")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
        }
    }
}

// MARK: - Supporting Views

struct MacroRow: View {
    let name: String
    let grams: Int
    let percentage: Double
    let color: Color
    let icon: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.body)
                    .fontWeight(.medium)
                Text("\(Int(percentage))% of daily calories")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(grams)g")
                    .font(.headline)
                Text("\(grams * (name == "Fats" ? 9 : 4)) cal")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 5)
    }
}

// Simple visual representation - will be replaced with custom layout
struct MacroRingsView: View {
    let protein: Double
    let carbs: Double
    let fats: Double
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 20) {
                MacroRing(
                    percentage: protein,
                    color: .red,
                    label: "Protein",
                    width: geometry.size.width / 3 - 20
                )
                
                MacroRing(
                    percentage: carbs,
                    color: .blue,
                    label: "Carbs",
                    width: geometry.size.width / 3 - 20
                )
                
                MacroRing(
                    percentage: fats,
                    color: .green,
                    label: "Fats",
                    width: geometry.size.width / 3 - 20
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct MacroRing: View {
    let percentage: Double
    let color: Color
    let label: String
    let width: CGFloat
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .stroke(color.opacity(0.2), lineWidth: 10)
                
                Circle()
                    .trim(from: 0, to: percentage / 100)
                    .stroke(color, lineWidth: 10)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut(duration: 1), value: percentage)
                
                Text("\(Int(percentage))%")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .frame(width: width, height: width)
            
            Text(label)
                .font(.caption)
                .fontWeight(.medium)
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResultsView()
                .environmentObject(UserProfileViewModel())
        }
    }
}
