#! /bin/sh
if [ -f /tmp/noenglish ]; then
    rm /tmp/noenglish 
    notify-send "🇬🇧   ENGLISH ENABLED🇬🇸   "
else
    echo yes > /tmp/noenglish 
    notify-send "🇬🇧   ENGLISH DISAB 🇬"
fi

