echo "Removing documentation..." >&2
find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true
find /usr/share/doc -empty|xargs rmdir || true
rm -rf /usr/share/man/man*/* \
   /usr/share/groff \
   /usr/share/info \
   /usr/share/lintian \
   /usr/share/linda \
   /var/cache/man

echo "Removing locales..." >&2
find /usr/share/locale -mindepth 1 -maxdepth 1 ! -name 'en' | xargs rm -r