# LuckyUserDefaultsStorable


[中文版本](README_CN.md)


## Introduction

A simple property wrapper that is very useful for storing configurations. It is easy to use.


## Installation

```ruby
    pod 'LuckyUserDefaultsStorable'
```

## Usage

* Define data format

```swift
    
     struct Config: Codable {
    
        var host: String
        
        // More properties
    }
    
```

* Use property wrapper

```swift

        @UserDefaultsStorable(key: "Config.defoult", defaultValue: Config(host: "https://www.google.com"))
        static var defoult: Config
```

## Description

```swift

    /// When suitName of UserDefaults is empty, UserDefaults.standard is used.
    let suitName: String?
    
    /// The key used for saving.
    let key: String
    
    /// The default value returned when UserDefaults does not have a value.
    let defaultValue: T

```

```swift
/// Please use it with Codable-compliant data.
public struct UserDefaultsStorable<T: Codable>
```


