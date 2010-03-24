case "$host" in
   "grok"|"gir"|"tamara"|"tanstaafl"|"zim")
      PGHOST="atlas"
      ;;
   "frell"|"pug")
      if [[ -n $SSH_CLIENT ]]; then
        echo m | fc -R /proc/self/fd/0
      fi
      ;;
esac

