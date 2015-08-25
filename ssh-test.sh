
#ToDo
# requires time and pv
# does it really need pv? (use if there)
# requires an ssh key
# requires key to be in authorize keys
# connects locally using $LOGNAME or $USER
# check sshd is running?
# list of all ciphers? ssh -Q cipher only works on new systems
# Thank http://blog.famzah.net/2015/06/26/openssh-ciphers-performance-benchmark-update-2015/


# uses "/tmp/dd.txt" as a temporary file!
for cipher in aes128-cbc aes128-ctr aes128-gcm@openssh.com aes192-cbc aes192-ctr aes256-cbc aes256-ctr aes256-gcm@openssh.com arcfour arcfour128 arcfour256 blowfish-cbc cast128-cbc chacha20-poly1305@openssh.com 3des-cbc ; do
    for i in 1 2 3 ; do
        echo
        echo "Cipher: $cipher (try $i)"
        dd if=/dev/zero bs=1M count=1024 2>/tmp/dd.txt | pv --size 1G | time -p ssh -c "$cipher" pi@localhost 'cat > /dev/null'
        grep -v records /tmp/dd.txt
    done
done
