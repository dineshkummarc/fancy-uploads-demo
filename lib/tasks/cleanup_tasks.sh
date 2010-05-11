cd $1

NOW=$(date +"%m-%d-%Y %H:%M:%S")

echo "$NOW >> Cleaning up stale uploads  >> $1"
/usr/bin/rake cleanup_fancy_uploads RAILS_ENV=$2



