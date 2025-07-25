import Foundation
import SwiftData
import WorkoutKit
import HealthKit

// MARK: - Core Enums

/**
 * FitnessMetric: The different aspects of fitness that can be improved
 */
enum FitnessMetric: String, CaseIterable {
    case strength = "Strength"
    case stability = "Stability"
    case speed = "Speed"
    case endurance = "Endurance"
    case aerobicEndurance = "Aerobic Endurance"
    case anaerobicEndurance = "Anaerobic Endurance"
    case muscularEndurance = "Muscular Endurance"
    case agility = "Agility"
    case power = "Power"
    case mobility = "Mobility"
}

/**
 * Muscle: The different muscle groups and body parts that can be targeted
 */
enum Muscle: String, CaseIterable {
    // Core muscles
    case core = "Core"
    case obliques = "Obliques"
    case psoas = "Psoas"
    case iliacus = "Iliacus"
    
    // Upper body
    case chest = "Chest"
    case back = "Back"
    case lats = "Lats"
    case shoulders = "Shoulders"
    case biceps = "Biceps"
    case triceps = "Triceps"
    
    // Lower body
    case quadriceps = "Quadriceps"
    case hamstrings = "Hamstrings"
    case glutes = "Glutes"
    case calves = "Calves"
    case adductors = "Adductors"
    case abductors = "Abductors"
    
    // Full body
    case fullBody = "Full Body"
}

/**
 * Movement: The physical movements that can be performed
 */
enum Movement: String, CaseIterable {
    // Upper body movements
    case pullUps = "Pull Ups"
    case chinUps = "Chin Ups"
    case chestDips = "Chest Dips"
    case tricepDips = "Tricep Dips"
    case benchPress = "Bench Press"
    case latPulldowns = "Lat Pulldowns"
    case cablePullover = "Cable Pullover"
    case chestFlys = "Chest Flys"
    case bicepCurls = "Bicep Curls"
    case hammerCurls = "Hammer Curls"
    case preacherCurls = "Preacher Curls"
    case lateralRaises = "Lateral Raises"
    case overheadPress = "Overhead Press"
    case facePulls = "Face Pulls"
    case tricepPulldown = "Tricep Pulldown"
    case overheadPull = "Overhead Pull"
    
    // Lower body movements
    case barbellBackSquat = "Barbell Back Squat"
    case barbellDeadlifts = "Barbell Deadlifts"
    case calfRaises = "Calf Raises"
    case adductors = "Adductors"
    case abductors = "Abductors"
    
    // Core movements
    case lSit = "L-Sit"
    case legRaise = "Leg Raise"
    
    // Cardio movements
    case cycling = "Cycling"
    case run = "Run"
    case sprint = "Sprint"
    case jumpRope = "Jump Rope"
    
    // Stretching movements
    case benchHipFlexorStretch = "Bench Hip Flexor Stretch"
    case hamstringStretch = "Hamstring Stretch"
    case quadricepsStretch = "Quadriceps Stretch"
    case calfStretch = "Calf Stretch"
    case shoulderStretch = "Shoulder Stretch"
    case neckStretch = "Neck Stretch"
    case spinalTwist = "Spinal Twist"
    case childsPose = "Child's Pose"
    
    // Yoga movements
    case downwardDog = "Downward Dog"
    case warriorOne = "Warrior I"
    case warriorTwo = "Warrior II"
    case trianglePose = "Triangle Pose"
    case treePose = "Tree Pose"
    case catCowPose = "Cat Cow Pose"
    case cobralPose = "Cobra Pose"
    case planktoPose = "Plank Pose"
    case mountainPose = "Mountain Pose"
    case sunSalutation = "Sun Salutation"
    
    // Pilates movements  
    case pilatesHundred = "Pilates Hundred"
    case pilatesRollUp = "Pilates Roll Up"
    case pilatesSingleLegCircle = "Pilates Single Leg Circle"
    case pilatesTeaser = "Pilates Teaser"
    case pilatesPlank = "Pilates Plank"
    case pilatesBridge = "Pilates Bridge"
    
    // Mindfulness movements
    case meditation = "Meditation"
    case breathingExercise = "Breathing Exercise"
    case bodyScanning = "Body Scanning"
    case progressiveMuscleRelaxation = "Progressive Muscle Relaxation"
    
    // Complex movements
    case bearCrawls = "Bear Crawls"
    case hingeToSquat = "Hinge to Squat"
    case pikePulse = "Pike Pulse"
    case precisionBroadJump = "Precision Broad Jump"
    case ropeClimbing = "Rope Climbing"
    
    /**
     * Returns the primary muscles targeted by this movement
     */
    var targetMuscles: [Muscle] {
        switch self {
        // Upper body
        case .pullUps, .chinUps, .latPulldowns, .cablePullover:
            return [.back, .lats, .biceps]
        case .chestDips, .benchPress, .chestFlys:
            return [.chest, .triceps]
        case .tricepDips, .tricepPulldown, .overheadPull:
            return [.triceps]
        case .bicepCurls, .hammerCurls, .preacherCurls:
            return [.biceps]
        case .lateralRaises, .overheadPress, .facePulls:
            return [.shoulders]
            
        // Lower body
        case .barbellBackSquat:
            return [.quadriceps, .glutes]
        case .barbellDeadlifts:
            return [.hamstrings, .glutes, .back]
        case .calfRaises:
            return [.calves]
        case .adductors:
            return [.adductors]
        case .abductors:
            return [.abductors]
            
        // Core
        case .lSit, .legRaise:
            return [.core, .psoas]
            
        // Cardio (full body engagement)
        case .cycling, .run, .sprint, .jumpRope:
            return [.fullBody]
            
        // Stretching
        case .benchHipFlexorStretch:
            return [.psoas, .iliacus]
        case .hamstringStretch:
            return [.hamstrings]
        case .quadricepsStretch:
            return [.quadriceps]
        case .calfStretch:
            return [.calves]
        case .shoulderStretch:
            return [.shoulders]
        case .neckStretch:
            return [.fullBody] // neck not specific muscle
        case .spinalTwist, .childsPose:
            return [.back, .core]
            
        // Yoga movements
        case .downwardDog:
            return [.shoulders, .hamstrings, .calves]
        case .warriorOne, .warriorTwo:
            return [.quadriceps, .glutes, .core]
        case .trianglePose:
            return [.hamstrings, .core, .shoulders]
        case .treePose:
            return [.core, .glutes]
        case .catCowPose:
            return [.back, .core]
        case .cobralPose:
            return [.back, .chest]
        case .planktoPose:
            return [.core, .shoulders, .chest]
        case .mountainPose:
            return [.core, .glutes]
        case .sunSalutation:
            return [.fullBody]
            
        // Pilates movements
        case .pilatesHundred:
            return [.core, .obliques]
        case .pilatesRollUp:
            return [.core, .psoas]
        case .pilatesSingleLegCircle:
            return [.core, .psoas]
        case .pilatesTeaser:
            return [.core, .psoas]
        case .pilatesPlank:
            return [.core, .shoulders]
        case .pilatesBridge:
            return [.glutes, .hamstrings, .core]
            
        // Mindfulness movements
        case .meditation, .breathingExercise, .bodyScanning, .progressiveMuscleRelaxation:
            return [.fullBody] // mental focus, full body awareness
            
        // Complex movements
        case .bearCrawls, .pikePulse:
            return [.core, .psoas]
        case .hingeToSquat:
            return [.fullBody]
        case .precisionBroadJump:
            return [.fullBody]
        case .ropeClimbing:
            return [.fullBody]
        }
    }
    
    /**
     * Returns the primary fitness metrics this movement develops
     */
    var targetMetrics: [FitnessMetric] {
        switch self {
        // Upper body strength movements
        case .pullUps, .chinUps, .chestDips, .benchPress:
            return [.strength, .power]
        case .latPulldowns, .cablePullover, .chestFlys:
            return [.strength, .muscularEndurance]
        case .tricepDips, .tricepPulldown, .overheadPull:
            return [.strength, .muscularEndurance]
        case .bicepCurls, .hammerCurls, .preacherCurls:
            return [.strength, .muscularEndurance]
        case .lateralRaises, .overheadPress, .facePulls:
            return [.strength, .stability]
            
        // Lower body movements
        case .barbellBackSquat, .barbellDeadlifts:
            return [.strength, .power, .stability]
        case .calfRaises:
            return [.strength, .stability]
        case .adductors, .abductors:
            return [.stability, .mobility]
            
        // Core movements
        case .lSit, .legRaise:
            return [.strength, .stability, .muscularEndurance]
            
        // Cardio movements
        case .cycling:
            return [.aerobicEndurance, .muscularEndurance]
        case .run:
            return [.aerobicEndurance, .speed]
        case .sprint:
            return [.anaerobicEndurance, .speed, .power]
        case .jumpRope:
            return [.anaerobicEndurance, .agility, .speed]
            
        // Stretching
        case .benchHipFlexorStretch:
            return [.mobility]
        case .hamstringStretch, .quadricepsStretch, .calfStretch, .shoulderStretch, .neckStretch:
            return [.mobility]
        case .spinalTwist, .childsPose:
            return [.mobility, .stability]
            
        // Yoga movements
        case .downwardDog:
            return [.mobility, .stability, .strength]
        case .warriorOne, .warriorTwo:
            return [.stability, .strength, .mobility]
        case .trianglePose:
            return [.mobility, .stability]
        case .treePose:
            return [.stability]
        case .catCowPose:
            return [.mobility, .stability]
        case .cobralPose:
            return [.mobility, .strength]
        case .planktoPose:
            return [.strength, .stability, .muscularEndurance]
        case .mountainPose:
            return [.stability]
        case .sunSalutation:
            return [.mobility, .stability, .strength, .endurance]
            
        // Pilates movements
        case .pilatesHundred:
            return [.muscularEndurance, .stability]
        case .pilatesRollUp:
            return [.strength, .stability, .mobility]
        case .pilatesSingleLegCircle:
            return [.stability, .mobility]
        case .pilatesTeaser:
            return [.strength, .stability]
        case .pilatesPlank:
            return [.strength, .stability, .muscularEndurance]
        case .pilatesBridge:
            return [.strength, .stability]
            
        // Mindfulness movements
        case .meditation, .breathingExercise, .bodyScanning, .progressiveMuscleRelaxation:
            return [.stability] // mental stability and focus
            
        // Complex movements
        case .bearCrawls:
            return [.strength, .stability, .muscularEndurance]
        case .pikePulse:
            return [.strength, .stability, .mobility]
        case .hingeToSquat:
            return [.mobility, .stability, .strength]
        case .precisionBroadJump:
            return [.power, .agility, .speed]
        case .ropeClimbing:
            return [.strength, .power, .muscularEndurance]
        }
    }
}

/**
 * WorkoutType: Different categories/types of workouts
 */
enum WorkoutType: String, CaseIterable {
    // Basic types
    case warmup = "Warmup"
    case cooldown = "Cooldown"
    case strengthWorkout = "Strength Workout"
    case enduranceWorkout = "Endurance Workout"
    case stabilityWorkout = "Stability Workout"
    
    // Specific warmup types
    case dynamicWarmup = "Dynamic Warmup"
    case functionalWarmup = "Functional Warmup"
    
    // Specific strength types
    case functionalStrengthWorkout = "Functional Strength Workout"
    
    // Specific endurance types
    case muscularEnduranceWorkout = "Muscular Endurance Workout"
    case aerobicEnduranceWorkout = "Aerobic Endurance Workout"
    case anaerobicEnduranceWorkout = "Anaerobic Endurance Workout"
    
    // Specific stability types
    case functionalStabilityWorkout = "Functional Stability Workout"
}

// MARK: - Protocols

/// Protocol for any component that can be converted to WorkoutKit types
protocol WorkoutKitConvertible {
    associatedtype WorkoutKitType
    func toWorkoutKitType() -> WorkoutKitType
}

/// Protocol for workout components that have goals and can be tracked
protocol TrackableComponent {
    var displayName: String { get }
    var goal: WorkoutGoal { get }
}

/// Protocol for components that can have iterations/repetitions
protocol RepeatableComponent {
    var iterations: Int { get }
}

// MARK: - Core Fitness Types

/**
 * Exercise: A physical or mental activity that an athlete can do to improve their fitness metrics
 * 
 * Maps to WorkoutKit: IntervalStep (.work type)
 * - Defines the actual work being performed
 * - Can have specific goals (time, distance, calories, etc.)
 * - Can have alerts for pacing, heart rate, etc.
 * - Now includes movement and target muscles
 */
class Exercise: TrackableComponent, WorkoutKitConvertible {
    typealias WorkoutKitType = IntervalStep
    
    let goal: WorkoutGoal
    let alert: (any WorkoutAlert)?
    let movement: Movement
    let targetMuscles: [Muscle]
    let targetMetrics: [FitnessMetric]
    
    var displayName: String {
        return movement.rawValue
    }
    
    init(movement: Movement, goal: WorkoutGoal, alert: (any WorkoutAlert)? = nil) {
        self.movement = movement
        self.goal = goal
        self.alert = alert
        self.targetMuscles = movement.targetMuscles
        self.targetMetrics = movement.targetMetrics
    }
    
    /// Converts this Exercise to a WorkoutKit IntervalStep
    func toWorkoutKitType() -> IntervalStep {
        let workoutStep = WorkoutStep(goal: goal, alert: alert, displayName: displayName)
        return IntervalStep(.work, step: workoutStep)
    }
    
    /// Legacy method name for backward compatibility
    func toIntervalStep() -> IntervalStep {
        return toWorkoutKitType()
    }
}

/**
 * Rest: A physical or mental rest that an athlete can do between exercises
 * 
 * Maps to WorkoutKit: IntervalStep (.recovery type)
 * - Defines recovery periods between work intervals
 * - Usually has time-based goals but can be open-ended
 */
class Rest: TrackableComponent, WorkoutKitConvertible {
    typealias WorkoutKitType = IntervalStep
    
    let displayName: String
    let goal: WorkoutGoal
    
    init(displayName: String = "Rest", goal: WorkoutGoal = .open) {
        self.displayName = displayName
        self.goal = goal
    }
    
    /// Converts this Rest to a WorkoutKit IntervalStep
    func toWorkoutKitType() -> IntervalStep {
        let workoutStep = WorkoutStep(goal: goal, displayName: displayName)
        return IntervalStep(.recovery, step: workoutStep)
    }
    
    /// Legacy method name for backward compatibility
    func toIntervalStep() -> IntervalStep {
        return toWorkoutKitType()
    }
}

/**
 * Workout: A group of exercises and rest periods that help improve fitness metrics
 * 
 * Maps to WorkoutKit: IntervalBlock
 * - Combines exercises with rest periods in a structured format
 * - Can be repeated multiple times (iterations)
 * - Represents a cohesive training block
 * - Now includes workout type and target fitness metrics
 */
class Workout: RepeatableComponent, WorkoutKitConvertible {
    typealias WorkoutKitType = IntervalBlock
    
    let exercises: [Exercise]
    let restPeriods: [Rest]
    let iterations: Int
    let workoutType: WorkoutType?
    
    init(exercises: [Exercise], restPeriods: [Rest], iterations: Int = 1, workoutType: WorkoutType? = nil) {
        self.exercises = exercises
        self.restPeriods = restPeriods
        self.iterations = iterations
        self.workoutType = workoutType
    }
    
    /// Returns all muscles targeted by this workout
    var targetMuscles: [Muscle] {
        let allMuscles = exercises.flatMap { $0.targetMuscles }
        return Array(Set(allMuscles)) // Remove duplicates
    }
    
    /// Returns all fitness metrics targeted by this workout
    var targetMetrics: [FitnessMetric] {
        let allMetrics = exercises.flatMap { $0.targetMetrics }
        return Array(Set(allMetrics)) // Remove duplicates
    }
    
    /// Converts this Workout to a WorkoutKit IntervalBlock
    func toWorkoutKitType() -> IntervalBlock {
        var steps: [IntervalStep] = []
        
        // Interleave exercises with rest periods
        for i in 0..<exercises.count {
            steps.append(exercises[i].toWorkoutKitType())
            if i < restPeriods.count {
                steps.append(restPeriods[i].toWorkoutKitType())
            }
        }
        
        return IntervalBlock(steps: steps, iterations: iterations)
    }
    
    /// Legacy method name for backward compatibility
    func toIntervalBlock() -> IntervalBlock {
        return toWorkoutKitType()
    }
    
    /// Returns a detailed plain text description of the workout
    func printableDescription() -> String {
        var output = ""
        
        if let workoutType = workoutType {
            output += "\(workoutType.rawValue)"
        } else {
            output += "Workout"
        }
        output += "\n"
        
        // Show iterations
        if iterations > 1 {
            output += "   Sets: \(iterations)\n"
        }
        
        // Show target metrics (derived from exercises)
        if !targetMetrics.isEmpty {
            output += "   Target Metrics: \(targetMetrics.map { $0.rawValue }.joined(separator: ", "))\n"
        }
        
        // Show target muscles
        if !targetMuscles.isEmpty {
            output += "   Target Muscles: \(targetMuscles.map { $0.rawValue }.joined(separator: ", "))\n"
        }
        
        // Show exercises and rest periods
        output += "   Exercises:\n"
        for (index, exercise) in exercises.enumerated() {
            output += "     • \(exercise.displayName)"
            
            // Show goal
            switch exercise.goal {
            case .time(let duration, _):
                let minutes = Int(duration) / 60
                let seconds = Int(duration) % 60
                output += " - Goal: \(String(format: "%02d:%02d", minutes, seconds))"
            case .distance(let distance, let unit):
                output += " - Goal: \(String(format: "%.1f %@", distance, unit.symbol))"
            case .open:
                output += " - Goal: Open"
            @unknown default:
                output += " - Goal: Unknown"
            }
            
            // Show alert if any
            if let alert = exercise.alert {
                output += " - Alert: \(alertDescription(alert))"
            }
            
            output += "\n"
            
            // Add rest period if available
            if index < restPeriods.count {
                let rest = restPeriods[index]
                output += "       Rest: \(rest.displayName)"
                switch rest.goal {
                case .time(let duration, _):
                    let minutes = Int(duration) / 60
                    let seconds = Int(duration) % 60
                    output += " (\(String(format: "%02d:%02d", minutes, seconds)))"
                case .open:
                    output += " (Open)"
                default:
                    break
                }
                output += "\n"
            }
        }
        
        return output
    }
    
    /// Helper function to describe workout alerts
    private func alertDescription(_ alert: any WorkoutAlert) -> String {
        switch alert {
        case let heartRateAlert as HeartRateRangeAlert:
            let lowerBound = heartRateAlert.target.lowerBound.value
            let upperBound = heartRateAlert.target.upperBound.value
            return "HR \(Int(lowerBound))-\(Int(upperBound)) BPM"
        case let heartRateAlert as HeartRateZoneAlert:
            return "HR Zone \(heartRateAlert.zone)"
        case let powerAlert as PowerRangeAlert:
            let lowerBound = powerAlert.target.lowerBound.value
            let upperBound = powerAlert.target.upperBound.value
            return "Power \(Int(lowerBound))-\(Int(upperBound)) W"
        case let powerAlert as PowerThresholdAlert:
            return "Power \(Int(powerAlert.target.value)) W"
        case let powerAlert as PowerZoneAlert:
            return "Power Zone \(powerAlert.zone)"
        case let cadenceAlert as CadenceRangeAlert:
            let lowerBound = cadenceAlert.target.lowerBound.value
            let upperBound = cadenceAlert.target.upperBound.value
            return "Cadence \(Int(lowerBound))-\(Int(upperBound)) RPM"
        case let cadenceAlert as CadenceThresholdAlert:
            return "Cadence \(Int(cadenceAlert.target.value)) RPM"
        case let speedAlert as SpeedRangeAlert:
            let lowerBound = speedAlert.target.lowerBound.value
            let upperBound = speedAlert.target.upperBound.value
            return "Speed \(String(format: "%.1f", lowerBound))-\(String(format: "%.1f", upperBound)) \(speedAlert.target.lowerBound.unit.symbol)"
        case let speedAlert as SpeedThresholdAlert:
            return "Speed \(String(format: "%.1f", speedAlert.target.value)) \(speedAlert.target.unit.symbol)"
        default:
            return "Target Alert"
        }
    }
}

// MARK: - PlannedStep & Flattening Helpers

/// Represents one planned interval step (either work or rest) extracted from a workout plan.
enum PlannedStep {
    case work(Exercise)
    case rest(Rest)

    /// Human-readable name (e.g. "Deadlift" or "Rest")
    var displayName: String {
        switch self {
        case .work(let exercise):
            return exercise.displayName
        case .rest(let rest):
            return rest.displayName
        }
    }
}

extension Workout {
    /// Produces the exact sequence of work/rest steps **including iterations** so that the
    /// resulting array aligns one-to-one with the IntervalSteps sent to WorkoutKit.
    func flattenedSteps() -> [PlannedStep] {
        var steps: [PlannedStep] = []

        guard !exercises.isEmpty else { return steps }

        for _ in 0..<max(iterations, 1) {
            for i in 0..<exercises.count {
                steps.append(.work(exercises[i]))
                if i < restPeriods.count {
                    steps.append(.rest(restPeriods[i]))
                }
            }
        }

        return steps
    }
}

extension ActivitySession {
    /// Concatenates flattened steps from all workouts *in declared order*.
    func flattenedSteps() -> [PlannedStep] {
        activityGroups.flatMap { group in
            group.workouts.flatMap { $0.flattenedSteps() }
        }
    }

    /// Flattened steps restricted to a specific HKWorkoutActivityType (useful for sub-workouts of a multi-activity session).
    func flattenedSteps(for activityType: HKWorkoutActivityType) -> [PlannedStep] {
        activityGroups
            .filter { $0.activity == activityType }
            .flatMap { group in
                group.workouts.flatMap { $0.flattenedSteps() }
            }
    }

    /// Pair each ActivityMetrics (chronological) with its matching planned step.
    /// If there are extra recorded intervals or unfinished steps, the pair’s optionals capture that.
    func mapMetricsToPlan(_ metrics: [ActivityMetrics]) -> [IntervalMapping] {
        let orderedMetrics = metrics.sorted { $0.startDate < $1.startDate }
        let plannedSteps = flattenedSteps()

        let maxCount = max(orderedMetrics.count, plannedSteps.count)

        var mappings: [IntervalMapping] = []
        for index in 0..<maxCount {
            let metric = index < orderedMetrics.count ? orderedMetrics[index] : nil
            let step   = index < plannedSteps.count   ? plannedSteps[index]   : nil
            mappings.append(IntervalMapping(index: index + 1, metrics: metric, plannedStep: step))
        }
        return mappings
    }

    /// Same as mapMetricsToPlan(_:) but limit both metrics and plan to a particular activity type.
    func mapMetricsToPlan(for activityType: HKWorkoutActivityType, metrics: [ActivityMetrics]) -> [IntervalMapping] {
        let filteredMetrics = metrics
            .filter { $0.activity.workoutConfiguration.activityType == activityType }
            .sorted { $0.startDate < $1.startDate }

        let plannedSteps = flattenedSteps(for: activityType)

        let maxCount = max(filteredMetrics.count, plannedSteps.count)
        var mappings: [IntervalMapping] = []
        for idx in 0..<maxCount {
            let metric = idx < filteredMetrics.count ? filteredMetrics[idx] : nil
            let step   = idx < plannedSteps.count   ? plannedSteps[idx]   : nil
            mappings.append(IntervalMapping(index: idx + 1, metrics: metric, plannedStep: step))
        }
        return mappings
    }
}

/// Holds the association between a recorded interval and the plan step it corresponds to (if any).
struct IntervalMapping {
    let index: Int
    let metrics: ActivityMetrics?
    let plannedStep: PlannedStep?
}

/**
 * Warmup: A preparation phase to ready the body for main workout
 * 
 * Maps to WorkoutKit: Collection of IntervalBlocks (via contained workouts)
 * - Prepares the body for the main training
 * - Usually lower intensity than main workout
 * - Can contain multiple workout components
 */
class Warmup: WorkoutKitConvertible {
    typealias WorkoutKitType = [IntervalBlock]
    
    let workouts: [Workout]
    let displayName: String
    
    init(workouts: [Workout], displayName: String = "Warmup") {
        self.workouts = workouts
        self.displayName = displayName
    }
    
    /// Converts this Warmup to WorkoutKit IntervalBlocks
    func toWorkoutKitType() -> [IntervalBlock] {
        return workouts.map { $0.toWorkoutKitType() }
    }
    
    /// Legacy method name for backward compatibility
    func toIntervalBlocks() -> [IntervalBlock] {
        return toWorkoutKitType()
    }
}

/**
 * Cooldown: A recovery phase to help the body recover after main workout
 * 
 * Maps to WorkoutKit: Collection of IntervalBlocks (via contained workouts)
 * - Helps the body transition from high activity to rest
 * - Usually lower intensity recovery movements
 * - Can contain multiple workout components
 */
class Cooldown: WorkoutKitConvertible {
    typealias WorkoutKitType = [IntervalBlock]
    
    let workouts: [Workout]
    let displayName: String
    
    init(workouts: [Workout], displayName: String = "Cooldown") {
        self.workouts = workouts
        self.displayName = displayName
    }
    
    /// Converts this Cooldown to WorkoutKit IntervalBlocks
    func toWorkoutKitType() -> [IntervalBlock] {
        return workouts.map { $0.toWorkoutKitType() }
    }
    
    /// Legacy method name for backward compatibility
    func toIntervalBlocks() -> [IntervalBlock] {
        return toWorkoutKitType()
    }
}

/**
 * ActivityGroup: A group of workouts that share the same activity type and location
 * 
 * Maps to WorkoutKit: CustomWorkout
 * - Groups workouts under a single activity type
 * - Defines the activity type and location for WorkoutKit tracking
 */
struct ActivityGroup {
    let activity: HKWorkoutActivityType
    let location: HKWorkoutSessionLocationType
    let workouts: [Workout]
    
    init(activity: HKWorkoutActivityType, location: HKWorkoutSessionLocationType, workouts: [Workout]) {
        self.activity = activity
        self.location = location
        self.workouts = workouts
    }
    
    /// Returns all muscles targeted by this activity group
    var targetMuscles: [Muscle] {
        let allMuscles = workouts.flatMap { $0.targetMuscles }
        return Array(Set(allMuscles)) // Remove duplicates
    }
    
    /// Returns all fitness metrics targeted by this activity group
    var targetMetrics: [FitnessMetric] {
        let allMetrics = workouts.flatMap { $0.targetMetrics }
        return Array(Set(allMetrics)) // Remove duplicates
    }
    
    /// Converts this ActivityGroup to a WorkoutKit CustomWorkout
    func toCustomWorkout(sessionDisplayName: String) -> CustomWorkout {
        let blocks = workouts.map { $0.toWorkoutKitType() }
        let fullDisplayName = "\(sessionDisplayName) - \(activity.displayName)"
        
        return CustomWorkout(
            activity: activity,
            location: location,
            displayName: fullDisplayName,
            blocks: blocks
        )
    }
}

/**
 * ActivitySession: A complete workout session - a collection of activity groups
 * 
 * Maps to WorkoutKit: Multiple CustomWorkouts (one per activity group)
 * - Groups activity groups that can be tracked together as a cohesive session
 * - Each activity group becomes a separate CustomWorkout when scheduled
 * - Represents a complete training session that can be sent to Apple Watch
 */
class ActivitySession: WorkoutKitConvertible, Identifiable, ObservableObject {
    typealias WorkoutKitType = [CustomWorkout]
    
    let id = UUID()
    let activityGroups: [ActivityGroup]
    let displayName: String
    let workoutPlans: [WorkoutPlan] // Pre-created workout plans for scheduling
    
    init(activityGroups: [ActivityGroup], displayName: String) {
        self.activityGroups = activityGroups
        self.displayName = displayName
        
        // Create workout plans during initialization
        let customWorkouts = activityGroups.map { $0.toCustomWorkout(sessionDisplayName: displayName) }
        self.workoutPlans = customWorkouts.map { customWorkout in
            let workoutPlanWorkout = WorkoutPlan.Workout.custom(customWorkout)
            return WorkoutPlan(workoutPlanWorkout, id: UUID())
        }
    }
    
    /// Convenience initializer for single activity type sessions (backward compatibility)
    convenience init(workouts: [Workout], activity: HKWorkoutActivityType, location: HKWorkoutSessionLocationType, displayName: String? = nil) {
        let group = ActivityGroup(activity: activity, location: location, workouts: workouts)
        let sessionDisplayName = displayName ?? activity.displayName
        self.init(activityGroups: [group], displayName: sessionDisplayName)
    }
    
    /// Returns all workouts across all activity groups
    var workouts: [Workout] {
        return activityGroups.flatMap { $0.workouts }
    }
    
    /// Returns the primary activity type for backward compatibility (first group's activity)
    var activity: HKWorkoutActivityType {
        return activityGroups.first?.activity ?? .other
    }
    
    /// Returns the primary location for backward compatibility (first group's location)
    var location: HKWorkoutSessionLocationType {
        return activityGroups.first?.location ?? .unknown
    }
    
    /// Converts this ActivitySession to WorkoutKit CustomWorkouts (one per activity group)
    func toWorkoutKitType() -> [CustomWorkout] {
        return activityGroups.map { $0.toCustomWorkout(sessionDisplayName: displayName) }
    }
    
    /// Legacy method name for backward compatibility - returns first CustomWorkout
    func toCustomWorkout() -> CustomWorkout {
        let customWorkouts = toWorkoutKitType()
        return customWorkouts.first ?? CustomWorkout(
            activity: .other,
            location: .unknown,
            displayName: displayName,
            blocks: []
        )
    }
    
    /// Returns all muscles targeted by this activity session
    var targetMuscles: [Muscle] {
        let allMuscles = activityGroups.flatMap { $0.targetMuscles }
        return Array(Set(allMuscles)) // Remove duplicates
    }
    
    /// Returns all fitness metrics targeted by this activity session
    var targetMetrics: [FitnessMetric] {
        let allMetrics = activityGroups.flatMap { $0.targetMetrics }
        return Array(Set(allMetrics)) // Remove duplicates
    }
    
    /// Returns a detailed plain text description of the activity session
    func printableDescription() -> String {
        var output = ""
        
        output += "=== \(displayName.uppercased()) ===\n\n"
        
        // Show target metrics
        if !targetMetrics.isEmpty {
            output += "Target Metrics: \(targetMetrics.map { $0.rawValue }.joined(separator: ", "))\n"
        }
        
        // Show target muscles
        if !targetMuscles.isEmpty {
            output += "Target Muscles: \(targetMuscles.map { $0.rawValue }.joined(separator: ", "))\n"
        }
        
        output += "\n💪 ACTIVITY GROUPS\n"
        output += "------------------\n"
        
        for (groupIndex, group) in activityGroups.enumerated() {
            output += "\n🏃 \(group.activity.displayName) (\(group.location.displayName))\n"
            output += "Target Metrics: \(group.targetMetrics.map { $0.rawValue }.joined(separator: ", "))\n"
            output += "Target Muscles: \(group.targetMuscles.map { $0.rawValue }.joined(separator: ", "))\n\n"
            
            for (workoutIndex, workout) in group.workouts.enumerated() {
                output += "\(groupIndex + 1).\(workoutIndex + 1). \(workout.printableDescription())\n"
            }
        }
        
        return output
    }
}

// MARK: - Session Abstraction Layer

/**
 * WorkoutSession: A wrapper around ActivitySession for regular workout sessions
 */
class WorkoutSession: ObservableObject, Identifiable {
    let id = UUID()
    let activitySession: ActivitySession
    
    var displayName: String { activitySession.displayName }
    var workouts: [Workout] { activitySession.workouts }
    var activityGroups: [ActivityGroup] { activitySession.activityGroups }
    var targetMuscles: [Muscle] { activitySession.targetMuscles }
    var targetMetrics: [FitnessMetric] { activitySession.targetMetrics }
    
    init(activitySession: ActivitySession) {
        self.activitySession = activitySession
    }
    
    func printableDescription() -> String {
        return activitySession.printableDescription()
    }
}

/**
 * MindAndBodySession: A wrapper around ActivitySession for mind & body sessions
 */
class MindAndBodySession: ObservableObject, Identifiable {
    let id = UUID()
    let activitySession: ActivitySession
    
    var displayName: String { activitySession.displayName }
    var workouts: [Workout] { activitySession.workouts }
    var activityGroups: [ActivityGroup] { activitySession.activityGroups }
    var targetMuscles: [Muscle] { activitySession.targetMuscles }
    var targetMetrics: [FitnessMetric] { activitySession.targetMetrics }
    
    init(activitySession: ActivitySession) {
        self.activitySession = activitySession
    }
    
    func printableDescription() -> String {
        return activitySession.printableDescription()
    }
}

/**
 * WorkoutManager: Central manager for all activity sessions and workout operations
 * 
 * Responsibilities:
 * - Store and manage all activity sessions using SwiftData
 * - Provide access to activity sessions for UI components
 * - Bridge between SwiftData persistence and WorkoutKit integration
 * - Create default workout sessions if none exist
 */
@Observable
class WorkoutManager {
    
    static let shared = WorkoutManager()
    
    var activitySessions: [ActivitySession] = []
    var mindAndBodySessions: [ActivitySession] = []
    
    // Abstraction layer properties
    var workoutSessions: [WorkoutSession] {
        return activitySessions.map { WorkoutSession(activitySession: $0) }
    }
    
    var mindBodySessions: [MindAndBodySession] {
        return mindAndBodySessions.map { MindAndBodySession(activitySession: $0) }
    }
    
    private init() {}
    
    // Load all sessions from SwiftData and ensure defaults are present
    func loadSessions(from context: ModelContext) {
        do {
            // Fetch all stored sessions ordered by creation date (newest first)
            let descriptor = FetchDescriptor<PersistentActivitySession>(
                sortBy: [SortDescriptor(\.dateCreated, order: .reverse)]
            )
            var persistentSessions = try context.fetch(descriptor)

            // Ensure each built-in default session exists, creating any that are missing
            if ensureDefaultSessionsExist(in: context, existingSessions: persistentSessions) {
                // Re-fetch after inserting newly created sessions so we have an up-to-date list
                persistentSessions = try context.fetch(descriptor)
            }

            // Convert and categorise the final list of sessions
            processSessions(persistentSessions)

        } catch {
            print("Error loading sessions: \(error)")
        }
    }

    // Ensure that every default ActivitySession (including mind & body) exists in the store.
    // Any missing default is created and inserted. Returns true if new sessions were created.
    private func ensureDefaultSessionsExist(in context: ModelContext, existingSessions: [PersistentActivitySession]) -> Bool {
        // Build a quick lookup of already stored session names to avoid duplicates
        let existingNames = Set(existingSessions.map { $0.displayName })

        // Compose the full list of default sessions we expect to ship with the app
        let defaultSessions: [ActivitySession] = createDefaultActivitySessions() + createDefaultMindAndBodySessions()

        var didCreate = false

        for session in defaultSessions where !existingNames.contains(session.displayName) {
            let persistent = session.toPersistentModel()
            persistent.isPrebuilt = true
            context.insert(persistent)
            didCreate = true
        }

        // Persist any inserts that occurred so they are available on the next fetch
        if didCreate {
            do {
                try context.save()
                print("Missing default workout sessions created successfully")
            } catch {
                print("Error saving newly created default sessions: \(error)")
            }
        }

        return didCreate
    }
    
    // Helper method to process and categorize sessions
    private func processSessions(_ persistentSessions: [PersistentActivitySession]) {
        // Convert to runtime models and separate by type
        var regularSessions: [ActivitySession] = []
        var mindBodySessions: [ActivitySession] = []
        
        for persistentSession in persistentSessions {
            let session = persistentSession.toActivitySession()
            
            // Determine if it's a mind & body session based on activity types
            let isMindBodySession = session.activityGroups.allSatisfy { group in
                [.yoga, .pilates, .flexibility, .mindAndBody].contains(group.activity)
            }
            
            if isMindBodySession {
                mindBodySessions.append(session)
            } else {
                regularSessions.append(session)
            }
        }
        
        self.activitySessions = regularSessions
        self.mindAndBodySessions = mindBodySessions
    }
    
    // Create default workout sessions
    private func createDefaultSessions(in context: ModelContext) {
        do {
            // Create default activity sessions
            let defaultSessions = createDefaultActivitySessions()
            
            for session in defaultSessions {
                let persistentSession = session.toPersistentModel()
                persistentSession.isPrebuilt = true
                context.insert(persistentSession)
            }
            
            // Create default mind and body sessions
            let mindBodySessions = createDefaultMindAndBodySessions()
            
            for session in mindBodySessions {
                let persistentSession = session.toPersistentModel()
                persistentSession.isPrebuilt = true
                context.insert(persistentSession)
            }
            
            try context.save()
            print("Default workout sessions created successfully")
        } catch {
            print("Error creating default sessions: \(error)")
        }
    }
    
    // MARK: - Default Activity Sessions
    
    private func createDefaultActivitySessions() -> [ActivitySession] {
        return [
            createUpperBodyStrengthActivitySession(),
            createLowerBodyStrengthActivitySession(),
            createCardioEnduranceActivitySession()
        ]
    }
    
    private func createUpperBodyStrengthActivitySession() -> ActivitySession {
        let shortRest = Rest(goal: .time(30, .seconds))
        let openRest = Rest()
        
        let pullUps = Exercise(movement: .pullUps, goal: .open)
        let dips = Exercise(movement: .chestDips, goal: .open)
        let warmupWorkout = Workout(
            exercises: [pullUps, dips],
            restPeriods: [shortRest, shortRest],
            iterations: 2,
            workoutType: .dynamicWarmup
        )
        
        let latPulldown = Exercise(movement: .latPulldowns, goal: .open)
        let backStrengthWorkout = Workout(
            exercises: [latPulldown],
            restPeriods: [openRest],
            iterations: 3,
            workoutType: .functionalStrengthWorkout
        )
        
        let benchPress = Exercise(movement: .benchPress, goal: .open)
        let chestStrengthWorkout = Workout(
            exercises: [benchPress],
            restPeriods: [openRest],
            iterations: 3,
            workoutType: .functionalStrengthWorkout
        )
        
        let cablePullover = Exercise(movement: .cablePullover, goal: .open)
        let backEnduranceWorkout = Workout(
            exercises: [cablePullover],
            restPeriods: [openRest],
            iterations: 3,
            workoutType: .muscularEnduranceWorkout
        )

        let chestFlys = Exercise(movement: .chestFlys, goal: .open)
        let chestEnduranceWorkout = Workout(
            exercises: [chestFlys],
            restPeriods: [openRest],
            iterations: 3,
            workoutType: .muscularEnduranceWorkout
        )
        
        return ActivitySession(
            activityGroups: [
                ActivityGroup(activity: .traditionalStrengthTraining, location: .indoor, workouts: [warmupWorkout, backStrengthWorkout, chestStrengthWorkout, chestEnduranceWorkout, backEnduranceWorkout])
            ],
            displayName: "Upper Body"
        )
    }

    private func createLowerBodyStrengthActivitySession() -> ActivitySession {
        
        let timedRest = Rest(goal: .time(30, .seconds))
        
        // Cycling warmup and main workout
        let cyclingWarmup = Exercise(movement: .cycling, goal: .time(300, .seconds), alert: .heartRate(zone: 2))
        let cyclingWarmupWorkout = Workout(
            exercises: [cyclingWarmup],
            restPeriods: [],
            workoutType: .warmup
        )
        
        let openRest = Rest()
        
        let adductors = Exercise(movement: .adductors, goal: .open)
        let abductors = Exercise(movement: .abductors, goal: .open)
        let hipWarmupWorkout = Workout(
            exercises: [adductors, abductors],
            restPeriods: [openRest, openRest],
            iterations: 2,
            workoutType: .functionalWarmup
        )
        
        let backSquats = Exercise(movement: .barbellBackSquat, goal: .open)
        let squatWorkout = Workout(
            exercises: [backSquats],
            restPeriods: [openRest],
            iterations: 3,
            workoutType: .functionalStrengthWorkout
        )
        
        let deadlifts = Exercise(movement: .barbellDeadlifts, goal: .open)
        let deadliftWorkout = Workout(
            exercises: [deadlifts],
            restPeriods: [openRest],
            iterations: 3,
            workoutType: .functionalStrengthWorkout
        )
        
        let calfRaises = Exercise(movement: .calfRaises, goal: .open)
        let stabilityWorkout = Workout(
            exercises: [calfRaises],
            restPeriods: [openRest],
            iterations: 3,
            workoutType: .functionalStabilityWorkout
        )
        
        return ActivitySession(
            activityGroups: [
                ActivityGroup(activity: .cycling, location: .indoor, workouts: [cyclingWarmupWorkout]),
                ActivityGroup(activity: .traditionalStrengthTraining, location: .indoor, workouts: [hipWarmupWorkout, squatWorkout, deadliftWorkout, stabilityWorkout])
            ],
            displayName: "Lower Body"
        )
    }

    private func createCardioEnduranceActivitySession() -> ActivitySession {
        let timedRest = Rest(goal: .time(30, .seconds))
        
        // Cycling warmup and main workout
        let cyclingWarmup = Exercise(movement: .cycling, goal: .time(300, .seconds), alert: .heartRate(zone: 2))
        let cyclingWarmupWorkout = Workout(
            exercises: [cyclingWarmup],
            restPeriods: [],
            workoutType: .warmup
        )
        
        // Running main workout
        let continuousRunning = Exercise(movement: .run, goal: .time(1800, .seconds), alert: .speed(10, unit: .kilometersPerHour))
        let runningWorkout = Workout(
            exercises: [continuousRunning],
            restPeriods: [],
            workoutType: .aerobicEnduranceWorkout
        )
        
        // Jump rope HIIT workout
        let jumpRope = Exercise(movement: .jumpRope, goal: .time(90, .seconds), alert: .heartRate(zone: 4))
        let plyometricsWorkout = Workout(
            exercises: [jumpRope],
            restPeriods: [timedRest],
            iterations: 3,
            workoutType: .anaerobicEnduranceWorkout
        )
        
        return ActivitySession(
            activityGroups: [
                ActivityGroup(activity: .cycling, location: .indoor, workouts: [cyclingWarmupWorkout]),
                ActivityGroup(activity: .running, location: .indoor, workouts: [runningWorkout]),
                ActivityGroup(activity: .jumpRope, location: .indoor, workouts: [plyometricsWorkout])
            ],
            displayName: "Mixed Cardio"
        )
    }
    
    // MARK: - Default Mind and Body Sessions
    
    private func createDefaultMindAndBodySessions() -> [ActivitySession] {
        return [
            createYogaFlowSession()
        ]
    }
    
    private func createYogaFlowSession() -> ActivitySession {
        let shortRest = Rest(goal: .time(10, .seconds))
        let transitionRest = Rest(goal: .time(5, .seconds))
        
        // Warm-up flow
        let mountainPose = Exercise(movement: .mountainPose, goal: .time(30, .seconds))
        let catCow = Exercise(movement: .catCowPose, goal: .time(60, .seconds))
        let childsPose = Exercise(movement: .childsPose, goal: .time(30, .seconds))
        let warmupWorkout = Workout(
            exercises: [mountainPose, catCow, childsPose],
            restPeriods: [transitionRest, transitionRest, shortRest],
            workoutType: .warmup
        )
        
        // Main flow
        let sunSalutation = Exercise(movement: .sunSalutation, goal: .time(300, .seconds))
        let warrior1 = Exercise(movement: .warriorOne, goal: .time(45, .seconds))
        let warrior2 = Exercise(movement: .warriorTwo, goal: .time(45, .seconds))
        let triangle = Exercise(movement: .trianglePose, goal: .time(45, .seconds))
        let mainFlowWorkout = Workout(
            exercises: [sunSalutation, warrior1, warrior2, triangle],
            restPeriods: [shortRest, transitionRest, transitionRest, shortRest],
            iterations: 2
        )
        
        // Cool-down
        let downwardDog = Exercise(movement: .downwardDog, goal: .time(60, .seconds))
        let cobra = Exercise(movement: .cobralPose, goal: .time(45, .seconds))
        let finalChildsPose = Exercise(movement: .childsPose, goal: .time(120, .seconds))
        let cooldownWorkout = Workout(
            exercises: [downwardDog, cobra, finalChildsPose],
            restPeriods: [transitionRest, transitionRest, Rest()],
            workoutType: .cooldown
        )
        
        return ActivitySession(
            activityGroups: [
                ActivityGroup(activity: .yoga, location: .indoor, workouts: [warmupWorkout, mainFlowWorkout, cooldownWorkout])
            ],
            displayName: "Yoga Flow"
        )
    }

    // Add a new activity session to SwiftData
    func addActivitySession(_ session: ActivitySession, to context: ModelContext) {
        let persistentSession = session.toPersistentModel()
        context.insert(persistentSession)
        
        do {
            try context.save()
            loadSessions(from: context) // Refresh the local arrays
        } catch {
            print("Error saving new session: \(error)")
        }
    }
    
    // Delete an activity session from SwiftData
    func deleteActivitySession(_ session: ActivitySession, from context: ModelContext) {
        do {
            let sessionDisplayName = session.displayName
            let descriptor = FetchDescriptor<PersistentActivitySession>(
                predicate: #Predicate<PersistentActivitySession> { persistentSession in
                    persistentSession.displayName == sessionDisplayName
                }
            )
            let persistentSessions = try context.fetch(descriptor)
            
            if let sessionToDelete = persistentSessions.first {
                context.delete(sessionToDelete)
                try context.save()
                loadSessions(from: context) // Refresh the local arrays
            }
        } catch {
            print("Error deleting session: \(error)")
        }
    }
    
    // MARK: - Workout Matching
    
    /// Find matching activity session based on workout characteristics
    func findMatchingActivitySession(for workout: HKWorkout) -> ActivitySession? {
        let allSessions = activitySessions + mindAndBodySessions
        
        // First, try to match by activity type
        let candidateSessions = allSessions.filter { session in
            session.activityGroups.contains { group in
                group.activity == workout.workoutActivityType
            }
        }
        
        // If no exact activity type match, return nil
        guard !candidateSessions.isEmpty else { return nil }
        
        // Try to match by duration (within 10% tolerance)
        let workoutDuration = workout.duration
        let toleranceFactor = 0.1 // 10% tolerance
        
        for session in candidateSessions {
            let estimatedDuration = estimateSessionDuration(session)
            let durationDifference = abs(workoutDuration - estimatedDuration)
            let tolerance = max(workoutDuration, estimatedDuration) * toleranceFactor
            
            if durationDifference <= tolerance {
                return session
            }
        }
        
        // If no duration match, return the first candidate with matching activity type
        return candidateSessions.first
    }
    
    /// Estimate the total duration of an activity session
    private func estimateSessionDuration(_ session: ActivitySession) -> TimeInterval {
        var totalDuration: TimeInterval = 0
        
        for group in session.activityGroups {
            for workout in group.workouts {
                let workoutDuration = estimateWorkoutDuration(workout)
                totalDuration += workoutDuration * Double(workout.iterations)
            }
        }
        
        return totalDuration
    }
    
    /// Estimate the duration of a single workout
    private func estimateWorkoutDuration(_ workout: Workout) -> TimeInterval {
        var duration: TimeInterval = 0
        
        // Add exercise durations
        for exercise in workout.exercises {
            duration += estimateExerciseDuration(exercise)
        }
        
        // Add rest period durations
        for rest in workout.restPeriods {
            duration += estimateRestDuration(rest)
        }
        
        return duration
    }
    
    /// Estimate the duration of a single exercise
    private func estimateExerciseDuration(_ exercise: Exercise) -> TimeInterval {
        switch exercise.goal {
        case .time(let duration, _):
            return duration
        case .distance(let distance, let unit):
            // Estimate based on movement type and distance
            return estimateDurationForDistance(distance, unit: unit, movement: exercise.movement)
        case .open:
            // Estimate based on movement type
            return estimateDurationForOpenGoal(movement: exercise.movement)
        @unknown default:
            return 60 // Default 1 minute
        }
    }
    
    /// Estimate the duration of a rest period
    private func estimateRestDuration(_ rest: Rest) -> TimeInterval {
        switch rest.goal {
        case .time(let duration, _):
            return duration
        case .open:
            return 60 // Default 1 minute for open rest
        default:
            return 30 // Default 30 seconds
        }
    }
    
    /// Estimate duration for distance-based exercises
    private func estimateDurationForDistance(_ distance: Double, unit: UnitLength, movement: Movement) -> TimeInterval {
        let distanceInMeters = Measurement(value: distance, unit: unit).converted(to: .meters).value
        
        switch movement {
        case .run:
            // Assume 6 min/km pace
            return (distanceInMeters / 1000) * 360
        case .cycling:
            // Assume 20 km/h pace
            return (distanceInMeters / 1000) * 180
        case .sprint:
            // Assume 4 min/km pace
            return (distanceInMeters / 1000) * 240
        default:
            // Default estimation
            return distanceInMeters / 10 // 10 meters per second
        }
    }
    
    /// Estimate duration for open goal exercises
    private func estimateDurationForOpenGoal(movement: Movement) -> TimeInterval {
        switch movement {
        // Strength exercises - typically 45-60 seconds
        case .pullUps, .chinUps, .chestDips, .tricepDips, .benchPress, .latPulldowns, .barbellBackSquat, .barbellDeadlifts:
            return 60
        // Cardio exercises - typically longer
        case .cycling, .run:
            return 300 // 5 minutes
        case .sprint, .jumpRope:
            return 90 // 1.5 minutes
        // Stretching/yoga - typically 30-60 seconds
        case .hamstringStretch, .quadricepsStretch, .calfStretch, .shoulderStretch:
            return 30
        case .downwardDog, .warriorOne, .warriorTwo, .trianglePose:
            return 45
        case .sunSalutation:
            return 300 // 5 minutes
        case .meditation:
            return 600 // 10 minutes
        default:
            return 60 // Default 1 minute
        }
    }
}
