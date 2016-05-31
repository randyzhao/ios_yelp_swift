# Assignment 2 - Yelp

Yelp is a client using Yelp API

Submitted by: **Randy Zhao**

Time spent: **17** hours spent in total

## User Stories

The following stories have been implemented.

Search results page

- [x] Table rows should be dynamic height according to the content height.
- [x] Custom cells should have the proper Auto Layout constraints.
- [x] Search bar should be in the navigation bar
- [x] Optional: Infinite scroll for restaurant results
- [x] Optional: Implement map view of restaurant results

Filter page

- [x]  The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
- [x] The filters table should be organized into sections as in the mock.
- [x] You can use the default UISwitch for on/off states. 
- [ ] Optional: implement a custom switch
- [x] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
- [x] Distance filter should expand as in the real Yelp app.
- [x] Categories should show a subset of the full list with a "See All" row to expand.
- [x] Optional: Implement the restaurant detail page.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

### Search result page ##
![filter result](http://i.imgur.com/sTpXfPh.gif)

### Filters page ###
![filters](http://i.imgur.com/EajOdE4.gif)

### Details page ###
![details](http://i.imgur.com/KQhQGMx.gif)

### Autolayout ###
[autolayout](http://i.imgur.com/x8gYVIp.gifv)

## Questions ##

1. What is the best way to dismiss keyboard when user clicks or swipes anywhere in the screen. I found a solution that requires to add swipe gesture recognizer for every directions
2. The dropdown sections and see-all section in filters page make the delegate handlers pretty complicated. And I implemented them with some redundent code. I wonder if there is any more generic way to implement the configuration page.


## License

    Copyright [2016] [Randy Zhao]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
