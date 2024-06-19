# VIM
[ "$VIMRUNTIME" ] && [ "$VIRTUAL_ENV" ] && source "$VIRTUAL_ENV/bin/activate"

# RUST
. "$HOME/.cargo/env"

# LOAD DOTFILES
for file in ~/.{prompt,aliases,exports}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# ADD TAB COMPLETION FOR BASH COMMANDS
if which brew &> /dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
	# Ensure existing Homebrew v1 completions continue to work
	export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d";
	source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# TAB COMPLETION FOR SSH
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# AUTOCORRECT TYPOS WHEN CD
shopt -s cdspell;