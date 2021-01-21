# Musiq

Musiq is a sample project that I built to test some iOS frameworks, such as SwiftUI or Combine, as well as some popular design patterns.

## Installation

To get started, clone this repository.

```
git clone https://github.com/olsamaja/musiq.git
```

## Design Patterns

### Data Transfer Object

* [Why Model Objects Shouldn’t Implement Swift’s Decodable or Encodable Protocols](https://medium.com/better-programming/why-model-objects-shouldnt-implement-swift-s-decodable-or-encodable-protocols-1249cb44d4b3)

### Repository

* [Simple Repository Pattern in Swift](https://gist.github.com/omayib/9f515b6d5a72802bc2e07673788a308d)
* [Repository Design Pattern in Swift](https://medium.com/@frederikjacques/repository-design-pattern-in-swift-952061485aa)
* [iOS: Repository pattern in Swift](https://medium.com/tiendeo-tech/ios-repository-pattern-in-swift-85a8c62bf436)
* [Repository Pattern in Swift](https://medium.com/dev-genius/repository-pattern-in-swift-a8eda25b515d)

### Dependency Injection

* [Dependency Injection Tutorial for iOS: Getting Started](https://www.raywenderlich.com/14223279-dependency-injection-tutorial-for-ios-getting-started). Use of Interface Injection and DI Container.
* [Protocol oriented Dependency Injection with Swift](https://medium.com/@nfrugoni19/protocol-oriented-dependency-injection-with-swift-605b3d5b72ce)

## Architecture

### View Model

- Where should dependencies (network configuration) should be injected?
- Should get data from the data manager

### Data Manager

- Is connected with a local repository, and a remote repository. 
- Provides data from one of these repositories.

### Local Repository

- Call Data Fetcher to fetch data from server
- Data cannot be added, edited or deleted on remote store 

### Remote Repository

- Fetch data from cache
- Data canbe added, edited or deleted in local store 

### Data Fetcher (remote)

- Call API
