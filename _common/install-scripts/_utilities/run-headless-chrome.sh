Xvfb :1 -screen 5 1024x768x8 >/dev/null 2>&1 &

export DISPLAY=:1.5
export CHROME_BIN=/usr/bin/chromium-browser
