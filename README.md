# Swift Concurrency Lab

This project goes beyond basics to examine the complex reality of shipping concurrent apps It serves as a runnable handbook designed to demonstrate failure modes like reentrancy bugs and provide proven thread-safe solutions

**Core Topics**
* **The Concurrency Quadrants** Exploring the difference between Thread Safety Atomicity and Reentrancy
* **The Reentrancy Trap** Demonstrating actor state bugs and the myth of actor atomicity with live simulations
* **Production Solutions** Patterns for fixing race conditions including Check-Wait-Recheck State Machine Locks and Atomic Blocks

## 🚀 Getting Started

1.  **Clone** this repository
2.  Open the project in **Xcode 15+**
3.  Run the app in the **Simulator** iPhone 15 Pro recommended
4.  Navigate through the labs Use the **Simulate** buttons and watch the live **Execution Log** to see interleaving occur in real-time

## 🔮 Future Topics

This repository is built to grow Future labs will explore deeper aspects of the runtime

* **Phase 2 Cooperative Pool & Performance**
    * Visualizing thread explosion vs cooperative scheduling
    * The cost of blocking calls inside Tasks
    * Priority inversion and propagation
* **Phase 3 Advanced Isolation**
    * MainActor bottlenecks and offloading strategies
    * Deep dive into Sendable and region-based isolation Swift 6
* **Phase 4 Custom Executors**
    * Building custom serial executors for specific workloads
