# Introduction
This code sample accompanies the [Medium blogpost](https://medium.com/@keremkaratal/swiftui-exploiting-xcode-11-canvas-2fe46d66c3d8?source=friends_link&sk=a7fdaac805dafdedd771635f9aba6a19) on how to exploit the Xcode 11 Canvas. 

# Quick Start
You need to get a TMDB API key to be able to run this on your machine:

1. Get an API Key from TMDB: https://www.themoviedb.org/settings/api
2. Rename this file to AppSecrets.swift
3. Comment out the [below code](ImageLoader/AppSecrets.sample.swift) and replace the placeholder with the API Key you received.

``` swift
struct AppSecrets {
    static let TMDBApiSecret = "YOUR_TMDB_API_KEY_GOES_HERE"
}
```