#! /bin/sh
if [ -f /tmp/nospanish ]; then
    rm /tmp/nospanish 
    notify-send "🇪🇸   ✅SPANISH ENABLED✅🇪🇸   "
else
    echo yes > /tmp/nospanish 
    notify-send "🇪🇸  ❌SPANISH DISABLED❌ 🇪🇸   "
fi

