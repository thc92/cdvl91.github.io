#!/bin/bash

# For each post
find -path '*/_posts/*.md' | while read post_old; do
  post_dir=$(dirname "$post_old")
  parent_dir=$(dirname "$post_dir")

  post="${post_old::-3}-new.md"
  cp "$post_old" "$post"

  stat_before=$(stat -c '%Y' "$post")

  # For each image in that post
  grep -oE 'https?:(\w|/|\.)+blogspot([^)]|\([^)]+\))+([jJ][pP][eE]?[gG]|[pP][nN][gG])' "$post" | uniq | while read image; do
    # extract extension, to lowercase and generate a unique name for it in the parent directory
    extension=$(expr "$image" : '.*\.\(.*\)')
    extension=${extension,,}
    unique_name="$(uuidgen).$extension"
    # download image
    curl -L -o "$parent_dir/$unique_name" "$image" || exit 0
    # update link to image in post
    #sed -i "s#$image#$unique_name#g" "$post"
    # sed has no literal option for s///, gotta use replace from mysql-server, sorry
    replace -v "$image" "$unique_name" -- "$post"
  done

  stat_after=$(stat -c '%Y' "$post")
  # file not modified (no image in file)
  [ $stat_before -eq $stat_after ] && rm "$post"

done

# overwrite posts
find -path '*/_posts/*-new.md' | while read post; do mv "$post" "${post::-7}.md"; done

# list orphan images
git status --untracked-files --porcelain | grep -v fetch | cut -d' ' -f2 | while read file; do
  match=$(echo $file | cut -d'/' -f2)
  grep -qF "$match" */_posts/*.md && echo $file OK || echo $file NOK
done

