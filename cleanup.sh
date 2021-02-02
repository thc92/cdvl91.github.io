# extract front matter
find -path '*/_posts/*.html' | while read post; do sed -n '/---/,/---/p' "$post" > "$post.front" ; done

# extract content
find -path '*/_posts/*.html' | while read post; do sed '/---/,/---/d' "$post" > "$post.content" ; done

# tidy
[ ! disabled ] && find -path '*/_posts/*html' | while read post; do
  tidy -q -config tidyrc -o "$post.tidied" "$post.content"
  [ $? -eq 2 ] && echo "-------- failed to tidy $post.content --------"
done

# concatenate front matter and tidied HTML post
[ ! disabled ] && find -path '*/_posts/*.html' | while read post; do
  echo cat "$post.front"   > "${post::-5}.md"
  echo cat "$post.tidied" >> "${post::-5}.md"
done

# HTML2Markdown (gem install reverse_markdown)
find -path '*/_posts/*html' | while read post; do
  #reverse_markdown "$post.tidied"
  reverse_markdown "$post.content" > "$post.md"
done

# concatenate front matter and Markdown post
find -path '*/_posts/*.html' | while read post; do
  cat "$post.front"   > "${post::-5}-md.md"
  cat "$post.md" >> "${post::-5}-md.md"
done

# clean-up
find -path '*/_posts/*.front'   -delete
find -path '*/_posts/*.content' -delete
find -path '*/_posts/*.tidied'  -delete
find -path '*/_posts/*.html.md' -delete

