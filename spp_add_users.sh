#!/bin/sh

# file: spp_useradd.sh
#
# descriptions: _
#
# instructions:
#   sh spp_useradd.sh <users.txt ...>
#
# tested on:
#
# modification history:
#   20200716 (LB): intitial version
#

# make sure this script is run as root
#
if (test ${EUID} -ne 0)
then
    echo "spp_useradd: Permission denied."
    echo "try: sudo sh spp_useradd.sh <users.txt ...>"
    exit 1
fi

# loop throough each file passed
#
for file in "$@"
do
    # loop through each line of file
    #
    while read -r line
    do
	# create account if line is not empty
	#
	if echo $line | grep -lqve '^$'
	then
	    # extract rname name email group commentname from line
	    # line format: Firstname Lastname, email@example.com, group
	    #
	    real_name="$(echo $line | cut -f 1 -d ',')"
	    username="$(echo $line | cut -f 1 -d ',' | tr -d ' ' | tr 'A-Z' 'a-z' | sed 's/[^a-z|0-9]//g' | cut -c 1-16)"
	    email="$(echo $line | cut -f 2 -d ',' | tr -d ' ' | tr 'A-Z' 'a-z')"
	    group="$(echo $line | cut -f 3 -d ',' | tr -d ' ' | tr 'A-Z' 'a-z' | sed 's/[^a-z|0-9]//g')"
	    
	    # check if the account already exists
	    #
	    if grep -qle "^$email:" /etc/passwd
	    then
		echo "User $name already has an account($email)"
	    else
		# add the user with primary group $group 
		# add name and email to comment field
		#	    
		adduser -mc "${real_name}, ${email}" -g ${group} ${username}
		
		# generate and set one-time password
		#
		password="$(cat /dev/urandom | base64 | head -c20)"
		echo "${username}:${password}" | chpasswd
		chage -d 0 ${username} # force user to change password
		
		# copy .bashrc, .bash_profile, and .emacs.d/init.el files into
		#   the new user's home directory
		#
		cp ./spp_home/spp_bashrc /home/${username}/.bashrc
		cp ./spp_home/spp_bash_profile /home/${username}/.bash_profile
		cp -r ./spp_home/spp_emacs.d /home/${username}/.emacs.d
		
		# create ~/.ssh/ and ~/.ssh/authorized_keys
		#
		mkdir /home/${email}/.ssh
		touch /home/${email}/.ssh/authorized_keys
		chmod 700 /home/${email}/.ssh
		chmod 600 /home/${email}/.ssh/authorized_keys
		
		# give new user ownership of everthing in their home directory
		#
		chown -R ${username}:${group} /home/${username}
		
		# generate account information email
		#  email contents located in ./.ece_1111_account_email.txt
		#  ${email_var} and ${pass_var} replaced in file using sed -e
		#
	#	admin=help@nedcdata.org
	#	email_file=ece_1111_create_accounts_email.txt
	#	sed -e "s|USERNAME|$email|" -e "s|PASSWORD|$pass|" ${email_file} | mail -s "$(echo -e "Amazon AWS ECE Account\nFrom: NEDC Help <neuronix.nedcdata@gmail.com>\n")"  -c ${admin} ${email}@temple.edu

		# print status message
		#
		echo "Account ${username} created for ${real_name}"
	    fi
	fi
    done < ${file}
done
    
# exit normally
#
exit 0

#
# end of file
