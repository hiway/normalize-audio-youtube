# normalize-audio-youtube

Normalize audio in videos before uploading to YouTube

A shell script that accepts one or more file-paths to videos
and normalizes the audio automatically.

The script automatically names the output file as "<filename>_normalized.<extension>" in the same directory as original file.

> Status: works on my machine!

See the [releases](https://github.com/hiway/normalize-audio-youtube/releases/) page for getting/making a MacOS app that makes it trivial to drag-n-drop files to normalize their audio.

Uses: 
  - https://github.com/FFmpeg/FFmpeg/
  - https://github.com/slhck/ffmpeg-normalize/
  - https://github.com/sveinbjornt/Platypus/
