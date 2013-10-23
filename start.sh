# Create SSH user
SSH_USERPASS=`pwgen -c -n -1 8`
SSH_USER="admin"
mkdir /home/$SSH_USER
useradd -G sudo -d /home/$SSH_USER $SSH_USER
chown $SSH_USER /home/$SSH_USER
echo $SSH_USER:$SSH_USERPASS | chpasswd
echo ssh $SSH_USER password: $SSH_USERPASS
# Make ssh run dir
mkdir /var/run/sshd
# Run supervisor
supervisord -c/etc/supervisord.conf -n
