# Open Source Card Collector

A digital trading card browser that uses simple files to create its cards. This is meant to be a free and open alternative to real trading cards, so you can create, trade and collect cards you like with friends.

### Getting Started

Go to the release tab on the right to download a build of this project!

If you want to edit this project, you'll need to install Godot. Go to godotengine.org/download and look for the 4.4 or 4.4.1 release - to my knowledge there shouldn't be any problems using either version. Download and install the engine, then import the project.

And if you want some cards to get you started, here's a google drive folder with five cards drawn by yours truly! [Starting Cards (Google Drive)](https://drive.google.com/drive/folders/1cQIi5QAIVI3DZ2Ajb1G3zAy2T-qoDVkT?usp=sharing)

## Requirements

For using the Godot Engine:

* Recommended: Vulkan 1.0 compatible hardware
* Minimal: OpenGL 3.3 / OpenGL ES 3.0 compatible hardware

Additional requirements for the .NET version of the engine:

* .NET SDK

### Usage

Once you have a build of Open Source Card Collector, you need some cards! And while you can get some from the folder linked above, half the fun is making your own!

## Making Cards

(You can use the included Template Character as a base for making new cards!)

Create a new folder in your computer and name it whatever you want. Inside it, put a .png or .jpg file named "sprite" with a 1:1 ratio (the template image is 288x288). Keep in mind that this image will be displayed as both a square and a rectangle (look at the Template Character sprite for reference)
In addition to that, put a file named info.json. This will contain all the info for the character.
```json
{
"name":"Example",
"subtitle":"Fun subtitle here!",
"credits":"Game's Dev",
"description":"A template character! Use this as a base when creating new characters!",
"tags":["example", "template", "yipee"]
}
```
Remember:
* Use the Credits to properly credit the author of the used image. Don't share around uncredited images!
* Descriptions will only show in the image when its Focused, so there's a lot more space to write in.
* Use the tags to make searching characters easier, and remember to tag sensitive topics so they can be blocked if needed (nsfw, gore, eyestrain, etc)

## Loading Cards

Once you have your cards, create a folder in your computer- name it anything.  Place all the card folders inside.

Now run the build of this program, go to settings and copy the address of the new folder.

Finally, click "Load Characters" and the program should load the cards from the folder!

One they're loaded, you can search your character list using the search bar. The search bar looks through the characters' names, credits and tags! Use commas when searching under multiple tags at once.

(Remember you can block certain tags in the Settings, hiding the images on those cards)

## Built With

* [Godot Engine](https://godotengine.org/download)

### Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

This is still very early and there's a lot of ambitious ideas i am considering. I want to see how people react to this first build and what sort of features are most wanted before i implement anything beyond the core of "glorified png browser".

## Authors

* **HelloThePixel** - *Initial work* - [HelloThePixel](https://github.com/HelloThePixel)

## License

[MIT](https://choosealicense.com/licenses/mit/)

