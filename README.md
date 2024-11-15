# normalize-audio-youtube

Normalize audio in videos before uploading to YouTube

A shell script that accepts one or more file-paths to videos
and normalizes the audio automatically.

The script automatically names the output file as "(filename)_normalized.(extension)" in the same directory as original file.

> Status: works on my machine!

Install the shell script using curl on MacOS:

```console
curl -o ~/bin/normalize-audio-youtube.sh https://raw.githubusercontent.com/hiway/normalize-audio-youtube/refs/heads/main/normalize-audio-youtube.sh

chmod +x ~/bin/normalize-audio-youtube.sh
```

Usage:

Open Terminal or iTerm app, type "norm", hit tab to complete the command name
and drag the file(s) on to the terminal window to add their paths as arguments,
then hit enter.

```console
normalize-audio-youtube.sh example.mp4
```

See the [releases](https://github.com/hiway/normalize-audio-youtube/releases/) page for getting/making a MacOS app that makes it trivial to drag-n-drop files to normalize their audio.

Uses: 
  - https://github.com/FFmpeg/FFmpeg/
  - https://github.com/slhck/ffmpeg-normalize/
  - https://github.com/sveinbjornt/Platypus/
