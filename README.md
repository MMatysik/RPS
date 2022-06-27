# Rock-Paper-Scissors

### What is this?

RockPaperScissors is a web-based application that allows user to play rock-paper-scissors

## Technical Details

- Ruby version: 3.0.4
- Rails version: 6.0.5

## Local Installation

#### External tools needed
- [RVM](https://rvm.io/) or [rbenv](http://rbenv.org/) for managing ruby versions

### Linux

#### Setup process
```

# Get dependencies
# Update the packages index
$ sudo apt update
# Install ruby version 3.0.4
$ rvm install 3.0.4 # (or rbenv install 3.0.4)
$ sudo gem install bundler
$ sudo apt-get install git
$ apt-get install shared-mime-info

# Download the code and set up Rails.
$ git clone git@github.com:MMatysik/RPS.git
$ cd RPS

# Continue app setup
$ bundle install

# Start your local server!
$ rails s

### Windows
- #TODO

### MacOS
- #TODO
```

## Rules

- Rock beats scissors
- Scissors beats paper
- Paper beats rock
- Identical throws tie (rock == rock, etc.)

## Play the game

1. Open `localhost:3000`
2. Choose any option and click button `Go!`
3. See the game result.
