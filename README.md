# Swift Concurrency Lab: The Architect's Guide

> "The hard part isn't the syntax; it's the mental model."

**Swift Concurrency Lab** is a live-code repository dedicated to demystifying the complex reality of building concurrent applications with Swift's async/await, Actors, and structured concurrency runtime.

This is not another tutorial on how to write `Task { }`. This project explores the architectural implications, runtime mechanics, performance tradeoffs, and the common pitfalls that senior engineers face when shipping this technology to production.

It is designed as a living handbook, a place to demonstrate, break, and fix advanced concurrency patterns in a real, runnable SwiftUI application.

---

## 🎯 Project Goals

* **Go Beyond Theory:** Move past WWDC-level introductions and into the messy reality of production code.
* **Visualize the Runtime:** Use live logs and UI state to see exactly how tasks interleave and how state changes over time.
* **Demonstrate Failure Modes:** Intentionally write code that contains data races, reentrancy bugs, and deadlocks to understand why they happen.
* **Provide Proven Solutions:** Showcase robust, thread-safe, and reentrant-safe architectural patterns that scale.

## Current Topics (Phase 1: Reentrancy & Isolation)

The initial release focuses on the most common misconception in Swift Concurrency: the difference between Thread Safety and Atomicity, and the resulting "Reentrancy Trap" inherent in Actors.

### 1. The Concurrency Quadrants
A foundational look at how different approaches to state management stack up.

* **The Locked Room (Non-Reentrant & Thread-Safe):** The classic `NSLock` / Mutex model. Safe and atomic, but blocks threads during critical sections.
* **The Danger Zone (Reentrant & NOT Thread-Safe):** Using `async` functions in a standard `class`. Demonstrates how easily data corruption occurs when isolation is missing.

### 2. The Reentrancy Trap (The "Buggy Actor")
Actors prevent crashes (data races), but they do not prevent logical inconsistencies (race conditions).
* **The Myth of Atomicity:** Demonstrates a "Double Sell" bug where two tasks exploit the gap created by an `await` suspension point to modify Actor state concurrently.
* **Live Simulation:** Watch two competing tasks drive an inventory count below zero, proving that Actor state is not constant across suspensions.

### 3. Production Solutions
Three distinct strategies for fixing reentrancy bugs, depending on business requirements.
* **Strategy A: Check-Wait-Recheck:** The pattern of verifying invariants immediately after every suspension point.
* **Strategy B: State Machine Lock:** Using an internal enum state to manually implement non-reentrant behavior for critical operations.
* **Strategy C: Functional Core (Atomic Block):** The cleanest approach—performing all side effects in a single, synchronous, atomic block at the end of an asynchronous function.

## 🚀 Getting Started

1.  **Clone** this repository.
2.  Open the project in **Xcode 15+**.
3.  Run the app in the **Simulator** (iPhone 15 Pro recommended).
4.  Navigate through the labs in the app. Use the **"Simulate"** buttons and watch the live **Execution Log** at the bottom of the screen to see the interleaving happen in real-time.

## Future Topics (Roadmap)

This repository is built to scale. Future labs will explore deeper aspects of the Swift Runtime:

* **Phase 2: The Cooperative Pool & Performance**
    * Visualizing thread explosion vs. cooperative scheduling.
    * The cost of "blocking" calls inside a Task.
    * Priority inversion and propagation.
* **Phase 3: Advanced Isolation & Sendable**
    * `@MainActor` bottlenecks and offloading strategies.
    * Deep dive into `Sendable` and region-based isolation (Swift 6).
    * Safely bridging legacy callback APIs with `CheckedContinuation`.
* **Phase 4: Custom Executors**
    * Building custom serial executors for specific workloads (e.g., database access).

## 🤝 Contributing

This is a community knowledge base. If you have a complex concurrency pattern, an interesting edge case, or a production lesson learned, please open a Pull Request to add a new lab scenario. Ensure your example includes both the problem demonstration and the structured solution.

---

**Built with ❤️ and a healthy respect for race conditions.**