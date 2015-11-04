# fetch all zsh aliases
alias | awk -F'[ =]' '{print $1}'

# fetch all zsh functions
# http://superuser.com/questions/681575/any-way-to-get-list-of-functions-defined-in-zsh-like-alias-command-for-aliases
print -l ${(ok)functions}
