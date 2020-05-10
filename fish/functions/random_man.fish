function list_man1
  find /usr/share/man/man1 -type f \
    | awk -F '/' '/1/ {print $NF}'  \
    | sed 's/.gz//'
end

function random_man
  list_man1 | shuf | head -1 | xargs man
end
