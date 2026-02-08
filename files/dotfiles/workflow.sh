#!/bin/bash
# start yabai & skhd
init() {
   brew services start skhd
   brew services start yabai
}
# stop yabai & skhd
stop() {
    brew services stop skhd
    brew services stop yabai
}
