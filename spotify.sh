#!/bin/bash

# forever loop...
while true; do
        # retrieve song name along with artist
        song=$(osascript -e 'tell application "Spotify" to name of current track')
        artist=$(osascript -e 'tell application "Spotify" to artist of current track')

        # tell users what song is currently getting played
        echo "Now playing: $song by $artist"

        # if an ad is detected through this pattern matching
        if [[ "$artist" != "Ado"  && ( "$song" == *"Advertisement"* || "$artist" == "" ) ]]; then
                echo "Spotify ad detected!"

                # shut down spotify and wait for 0.1 seconds before reopening spotify back up
                killall Spotify 2>/dev/null
                sleep 0.1

                # open it back up
                open -a "Spotify"

                # wait for 1 second
                sleep 1

                echo "Song will play in a few seconds!"
                # tell spotify to play the music
                osascript -e 'tell application "Spotify" to play'
        fi
        sleep 1 # Check every second
done