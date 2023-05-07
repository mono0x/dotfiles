if [ "$ZPROF" != "" ]
then
  zmodload zsh/zprof && zprof > /dev/null
fi

zsh-profiler() {
  ZPROF=1 zsh -i -c zprof
}
