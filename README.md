# musiq

![Language](https://img.shields.io/badge/language-Swift%205.4-orange.svg)
[![GitHub followers](https://img.shields.io/github/followers/olsamaja.svg?style=social&label=Follow&style=flat-square)]()

A very sample app developed in Swift, which I use as a playground to test frameworks, design patterns and some other tricks.

## Features

- [x] Search artists
- [x] Top Tracks Chart
- [x] Top Artists Chart
- [x] Top Tags Chart

## Requirements

- iOS 14.0+
- Xcode 12.4

## Installation

To get started, clone this repository.

```
git clone https://github.com/olsamaja/musiq.git
```

## Project Structure

The Xcode workspace contains the following projects.

    ├─ MusiqApp
    ├─ MusiqModuleArtsists
    ├─ MusiqModuleCharts
    ├─ MusiqConfiguration
    ├─ MusiqShared
    ├─ MusiqCoreUI
    ├─ MusiqCore
    
### MusiqApp Project

This is the project of the main application.

### Domain Modules

#### Module Structure

    +- Module
        +─ Configuration
        +─ Presentation Layer
            +- Views
        +─ Domain Layer
            +- View Models
            +- Domain Models
                +- Data Mappers
        +─ Data Services Layer
            +- Data Manager
            +- Data Models
            +- API
    +- Tests


![Anatomy of a module](Diagrams/module-arch.png)

#### MusiqModuleArtsists Project

This project contains the Seach Artists module.

#### MusiqModuleCharts Project

This project contains the Charts module.

#### MusiqConfiguration Project

This project contains ressources, classes and functions needed for configuring the application.

### MusiqShared Project

This project contains shared classes and functions used by the other projects.

## Design Patterns

This section lists some of the few design patterns used in this project.

### Data Transfer Object

* [Why Model Objects Shouldn’t Implement Swift’s Decodable or Encodable Protocols](https://medium.com/better-programming/why-model-objects-shouldnt-implement-swift-s-decodable-or-encodable-protocols-1249cb44d4b3)

### Builder

* [Using the builder pattern in Swift](https://www.swiftbysundell.com/articles/using-the-builder-pattern-in-swift/)

### Repository

* [Simple Repository Pattern in Swift](https://gist.github.com/omayib/9f515b6d5a72802bc2e07673788a308d)
* [Repository Design Pattern in Swift](https://medium.com/@frederikjacques/repository-design-pattern-in-swift-952061485aa)
* [iOS: Repository pattern in Swift](https://medium.com/tiendeo-tech/ios-repository-pattern-in-swift-85a8c62bf436)
* [Repository Pattern in Swift](https://medium.com/dev-genius/repository-pattern-in-swift-a8eda25b515d)

### Dependency Injection

* [Dependency Injection Tutorial for iOS: Getting Started](https://www.raywenderlich.com/14223279-dependency-injection-tutorial-for-ios-getting-started). Use of Interface Injection and DI Container.
* [Protocol oriented Dependency Injection with Swift](https://medium.com/@nfrugoni19/protocol-oriented-dependency-injection-with-swift-605b3d5b72ce)
* [Resolver - An ultralight Dependency Injection / Service Locator framework](https://github.com/hmlongco/Resolver)

### Reducer and Feedback

* [CombineFeedback](https://github.com/sergdort/CombineFeedback)
* [The Combine Framework and Effects](https://www.pointfree.co/episodes/ep80-the-combine-framework-and-effects-part-1)

## Common Libraries

* [Resolver - An ultralight Dependency Injection / Service Locator framework](https://github.com/hmlongco/Resolver)
* [ViewInspector](https://github.com/nalexn/ViewInspector)
