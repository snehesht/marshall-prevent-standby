#!/bin/sh

# /usr/local/bin/example-audio-playback

AUDIO_USER="st"
AUDIO_GROUP="Admin"
AUDIO_XRD="/run/user/$(id -u ${AUDIO_USER})"
AUDIO_FILE="/opt/marshall-prevent-standby/silent_audio.wav"

# playback using aplay
su \
  -P \
  -g "${AUDIO_GROUP}" \
  -G audio \
  "${AUDIO_USER}" \
  -c "XDG_RUNTIME_DIR=${AUDIO_XRD} aplay -q ${AUDIO_FILE}" \
|| echo 'Unable to play sound with aplay'

# playback using pw-play
su \
  -P \
  -g "${AUDIO_GROUP}" \
  -G audio \
  "${AUDIO_USER}" \
  -c "XDG_RUNTIME_DIR=${AUDIO_XRD} pw-play ${AUDIO_FILE}" \
|| echo 'Unable to play sound with pw-play'
