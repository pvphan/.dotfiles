alias vim=nvim
alias vims="vim -S Session.vim"
alias goharvest="cd ~/git/harvest"
alias cleardocker='docker kill $(docker ps -q); docker rm $(docker ps -a -q)'
alias purgedocker='docker rmi $(docker images | grep "^<none>" | awk "{print $3}")'
alias rsync2="rsync -ah --progress --append-verify"
alias gtop="watch -n 1 nvidia-smi"
alias streamjetson='gst-launch-1.0 -v udpsrc port=1234  caps = "application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H264, payload=(int)96" !  rtph264depay ! decodebin ! videoconvert ! autovideosink'
