

 # **What is Fluent** 
 Fluent is an iphone keyboard app where whenever a user uses their keyboard to text a friendm it automatically shows a translation of what they've typed in the language they are learning. For example, if someone texts their friend "How are you?" then the Spanish equivalent phrase would appear above the keyboard. "como estas?"



**Make sure change the xcode running scheme to the extension before running on a simulator**

<img width="299" alt="Screen Shot 2020-10-20 at 3 02 23 PM" src="https://user-images.githubusercontent.com/45300300/96632169-52bf1f80-12e5-11eb-883f-ae10c31ae464.png">

<h4>Cloning Repo</h4>
Run:

```xcode
    * git clone https://github.com/xingY97/Fluent.git
```
## Getting Started

<h3>Prerequisites</h3>

<h4>Environment</h4>
Start up by installing the requirements using:

```cocoapods
    pod init (creates a pod file)
```
Inside pod file enter
```
    pod 'Firebase/Analytics'
    pod 'GoogleMLKit/Translate'
```
```
    pod install
```

<h3>Testing in XCode</h3>

[Apple Developer: Run your app in the Simulator or on a Device](https://developer.apple.com/documentation/xcode/running_your_app_in_the_simulator_or_on_a_device)

<h4>Built With</h4>
* Swift
* cocoapods
* ML Kit 

## Continuing development
<h4>Relevant Code for translation and spellcheck</h4>
Keyboard > Controllers > KeyboardViewController.swift

```Swift
func keyPress(sender: UIButton!) {
    ...
    translateText(text: newText)
    spellCheck(text: newText)
}
```
> translateText()
calls ML KIT to do translation
* working as intended

Documentation:
* [Migration Guide for on-device APIs including translation](https://developers.google.com/ml-kit/migration)
* [Tutorial: Translate text](https://firebase.google.com/docs/ml-kit/ios/translate-text)



> spellCheck()
calls UiTextChecker to do spellchecking
* incomplete functionality

NOTE: Library Availability from iOS 3.2+ Older articles may still be relevent
* [Apple Developer: Class documentation](https://developer.apple.com/documentation/uikit/uitextchecker)

Further resources for development:
* [Github: Swift compatible implementation of autocorrect for iOS](https://github.com/ansonl/ios-uitextchecker-autocorrect)
* [StackOverflow: How to use autocorrect in iOS8](https://stackoverflow.com/questions/24627616/how-to-use-autocorrection-and-shortcut-list-in-ios8-custom-keyboard)
* [StackOverflow: Custom keyboard suggestions with UiTextChecker](https://stackoverflow.com/questions/46153376/ios-custom-keyboard-suggestions-with-uitextchecker)


<h4>Onboarding Files</h4>
** Fill in details such as how/where to change graphic assets**