  # General Info  

The app has three tabs: `Artworks`, `Artists`, `Suffixes`. The data is taken from public API of The Art Institute of Chicago.

**Artworks**  

List of artworks titles. When user scrolls to the end of the list, new page is being loaded. The user can check the details of the each item and load the image.

**Artists**  

List of artists. When user scrolls to the end of the list, new page is being loaded. The user can check more info about the artist and the list of his/her artworks.

**Suffixes**  

Suffixes screen shows a list of suffixes, that are created from the list of artists.

The tab is focused on a task of different manipulations with the suffixes. 
* Search matching suffix (if it's longer than 3 letters)
* The searching is debounced for 800 ms in order to give a user time for typing.
* Colored search results as a gradient from the best to the worst search time.

In the next sections of this document, I will be mainly focusing on describing the `Suffixes` tab since it has a more interesting structure and more sophisticated solutions implemented.

  # Technical Solutions  
  
**Architecture**  
  
In this project I followed MVVM architecture approach together with SOA.  
  
The project has three internal packages: `UIComponents`, `Navigation`, `Networking`.  

The `UIComponents` module contains the main visual components of the app, so it's easy to be reused in other apps of the same group.

The `Navigation` module contains a custom implementation of the navigation, since the native SwiftUI navigation implementation does not provide the desired level of the control over navigation. 
I implemented it in a separate module, so it can be easily reused or replaced when the native soution is ready.
  
The `Networking` module contains code working with the backend. The reason why I implemented it in a separate module is that it can be reused in different apps which use same backend. 
The module is generated with the use of OpenApi code-gen, which helps to quickly adapt the client-side SDKs every time developers updated a corresponding REST API.

There are `Realm` and `RealmDatabase` as external dependencies added with the help of SwiftPM.
  
**Services**  
  
`ServiceLocator` is a singleton registry for all the services that are used by the application.

`CacheService` provides caching of the network response to get the artists info for further splitting the names into suffixes.

`FileService` provides saving and reading from the saved file of the suffix search results.

`NetworkService` provides an abstaction layer to connect the app and the `Networking` module.

`SuffixManipulationService` module is responsible for the different operations with suffixes. 
  
**Models**  
  
The `Networking` module contains the models, that represent the structure of the backend responses and are used for parsing.   
All properties in the response models are `optional` in order to make the models sustainable to malformed backend responses. An app must not fail if the backend returns malformed data for a propery which is not used in the app.   
  
**WrappedSequence**  
  
The `WrappedSequence` struct is created in order to embrace the power of the sequence protocol and allow iterating over the `titles` inside the `artists` array.

**SuffixSequence**  

The `SuffixIterator` struct and `SuffixSequence` struct allows to iterate over suffixes that are formed from a single string. For example, if it takes a word `dog`, then it forms a sequence of the following suffixes: `dog, og, g`.

**Concurrent tasks**

Actor `Job` and class `JobScheduler` are used to schedule concurrent tasks of searching matching suffixes and estimating a search efficiency by providing the search time.

**Injected property wrapper**

`Injected` property wrapped is used to inject dependency to the different services inside `view models` without using initializers.

**Additional tools**  

There is `ArtApi.yaml` in the project directory, that represents the API specification, that was created with the Swagger Editor and used to generate the `Networking` module.
`generate.sh` is a script used to generate the `Networking` module.

`SwiftLint` is integrated into Xcode to follow Swift style and conventions.

**Tests**  

`SuffixesManipulationTests` tests the methods that are used for operations with suffixes.
`ArtCatalogueUITests` folder contains UI tests for three tabs, testing a simple user flow and the presence of the navigation buttons on the screen.

# Limitations  
    
* On Production I would add the backend response error hanling for the case when backend return nil for the properties that are necessary for the business logic.
So that the app doesn't crash in that case, and user could see an error message. I would also track such exceptions as Crashlytics non-fatal events. In that case the team quickly learns about a problem related to the backend responses and can take appropriate actions.  

* I would remove all the hardcoded strings into the separate struct/enum on production, so it's easier to control.

* I would add the following tests:
  * Integration tests for parsing of data models. For that I would add json files and parse them with the existing models. The tests would check that fields of parsed models have same values as jsons.

# Requirements

* Swift 5.5
* Xcode 13.3.1
* iOS 15.0+  
