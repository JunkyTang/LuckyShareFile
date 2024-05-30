# SanboxStorable

[中文版本](README_CN.md)

## Installation

```ruby

pod 'LuckySanboxStorable'

```

## Usage

### Define a data model conforming to the SanboxFileModel protocol

```swift
struct FileModel: SanboxFileModel {
    
    /// The name of the saved file
    var sanboxFileName: String?
    
    /// The original file URL
    var originFileUrl: URL
    
}
```

* Customize the sandbox directory

```swift
var sanboxDirectory: URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}
```

* Customize the folder name

```swift
var folderName: String {
    return "file"
}
```

### Initialize the data model and save it

```swift
let model = FileModel(originFileUrl: url)
// If no file name is given, a UUID will be used by default, and after successful saving, sanboxFileName will be assigned
try model.saveToSanbox()
```

### Read the data

```swift
let data = try model.dataInSanbox()
```



