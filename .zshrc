# Fix JAVA problem
export _JAVA_AWT_WM_NONREPARENTING=1

# Enable Powerlevel10k instant prompt. Should stay at the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



# Manual configuration
PATH=/home/s3rg4n/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/home/s3rg4n/.cargo/bin:/home/s3rg4n/Downloads/sonar-scanner-4.4.0.2170-linux/bin



# Functions
function mkt(){
	mkdir {nmap,content,exploits,scripts}
}

# Extract nmap information
function extractPorts(){
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
	echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
	echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
	echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
	echo $ports | tr -d '\n' | xclip -sel clip
	echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
	cat extractPorts.tmp; rm extractPorts.tmp
}

# Create web file wordlist from file
function wordlistGeneratorWeb(){

	WORD_LIST=$1
	OUTPUT_FILE=$2

	while read line;
	do
  		echo "Creating names for $line"
  		echo "$line.html" >> "$OUTPUT_FILE.txt"
  		echo "$line.php" >> "$OUTPUT_FILE.txt"
  		echo "$line.txt" >> "$OUTPUT_FILE.txt"
	done < $WORD_LIST

	echo "[+] Wordlist done!"
}

# Create wordlist from two files
function wordlistGenerator(){

		echo "2 files into 1"
        WORD_LIST1=$1
        WORD_LIST2=$2
		OUTPUT=$3

        while read line_wordlist_1;
        do
		while read line_wordlist_2;
		do
			echo $line_wordlist_1$line_wordlist_2 >> $OUTPUT
			echo $line_wordlist_2$line_wordlist_1 >> $OUTPUT
		done < $WORD_LIST2
        done < $WORD_LIST1

        echo "[+] Wordlist done!"
}

# Create wordlist from file adding 1234 123! 1234!
function wordlistGenerator1234(){

	WORD_LIST=$1
	OUTPUT=$2

	while read line;
	do
		echo $line"123" >> $OUTPUT
		echo $line"123!" >> $OUTPUT
		echo $line"1234" >> $OUTPUT
		echo $line"1234!" >> $OUTPUT
		echo "123"$line >> $OUTPUT
		echo "123!"$line >> $OUTPUT
		echo "1234"$line >> $OUTPUT
		echo "1234!"$line >> $OUTPUT
	done < $WORD_LIST

	echo "[+] Wordlist done!"
}

function rmk(){
	scrub -p dod $1
	shred -zun 10 -v $1
}

# Set 'man' colors
function man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}

# Run sonar scanner
function sonarCurrentDir(){
  sonar-scanner \
  -Dsonar.projectKey=test \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=82714b3da127b74365872a27bcf6eb4b8110634b
}

# Start Sonar
function sonarStart(){
  ~/Downloads/sonarqube-8.4.2.36762/bin/linux-x86-64/sonar.sh start
}

# Stop Sonar
function sonarStop(){
  ~/Downloads/sonarqube-8.4.2.36762/bin/linux-x86-64/sonar.sh stop
}

# Alias

alias ll='lsd -lhF --group-dirs=first'
alias la='lsd -aF --group-dirs=first'
alias l='lsd -F --group-dirs=first'
alias lla='lsd -lhaF --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias cat='bat'
alias catn='cat'
alias vim='vim -u ~/.vimrc'
