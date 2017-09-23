alias gco='git commit'
alias gg='git grep'
alias gpr='git pull --rebase'
alias gpfwl='git push --force-with-lease'
alias gst='git status'
alias jb='bundle exec jekyll build'
alias jbp='JEKYLL_ENV=production bundle exec jekyll build'
alias pua='pip freeze --user | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install --user -U'
alias vdv='vcsh dotfiles-vcsh'
# watch cpu frequency
alias wcf=' watch -n 0.3 cat /sys/devices/system/cpu/cpu{0..3}/cpufreq/scaling_cur_freq'
# wget mirror
alias wm='wget --recursive --no-parent --page-requisites --convert-links'
