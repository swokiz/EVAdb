#!/bin/bash

# Database user and password setup
mysql -u root -p mysql <<EOF
create user 'exomereadonly' IDENTIFIED BY 'exomereadonly';
update mysql.user set Host='localhost' where User='exomereadonly';
drop user exomereadonly;
insert into mysql.user (Host, User, Password) VALUES ('localhost', 'exomereadonly', 'exomereadonly');
insert into mysql.db (Host, Db, User, Select_priv) VALUES ('localhost', 'exomehg19', 'exomereadonly', 'Y');
insert into mysql.db (Host, Db, User, Select_priv) VALUES ('localhost', 'exomehg19plus', 'exomereadonly', 'Y');
insert into mysql.db (Host, Db, User, Select_priv) VALUES ('localhost', 'solexa', 'exomereadonly', 'Y');
insert into mysql.db (Host, Db, User, Select_priv) VALUES ('localhost', 'hgmd_pro', 'exomereadonly', 'Y');
insert into mysql.db (Host, Db, User, Select_priv) VALUES ('localhost', 'hg19', 'exomereadonly', 'Y');
insert into mysql.db (Host, Db, User, Select_priv, Insert_priv, Update_priv) VALUES ('localhost', 'exomevcfe', 'exomereadonly', 'Y', 'Y', 'Y');
create user exome IDENTIFIED BY 'exome';
update mysql.user set Host='localhost' where User='exome';
insert into mysql.db (Host, Db, User, Select_priv, Insert_priv, Update_priv) VALUES ('localhost', 'exomehg19', 'exome', 'Y', 'Y', 'Y');
insert into mysql.db (Host, Db, User, Select_priv, Insert_priv, Update_priv) VALUES ('localhost', 'exomevcfe', 'exome', 'Y', 'Y', 'Y');
insert into mysql.db (Host, Db, User, Select_priv, Insert_priv, Update_priv) VALUES ('localhost', 'solexa', 'exome', 'Y', 'Y', 'Y');
insert into mysql.db (Host, Db, User, Select_priv) VALUES ('localhost', 'exomehg19plus', 'exome', 'Y');
insert into mysql.db (Host, Db, User, Select_priv) VALUES ('localhost', 'hgmd_pro', 'exome', 'Y');
insert into mysql.db (Host, Db, User, Select_priv) VALUES ('localhost', 'hg19', 'exome', 'Y');
create user solexa IDENTIFIED BY 'solexa';
update mysql.user set Host='localhost' where User='solexa';
insert into mysql.db (Host, Db, User, Select_priv, Insert_priv, Update_priv) VALUES ('localhost', 'solexa', 'solexa', 'Y', 'Y', 'Y');
insert into mysql.db (Host, Db, User, Select_priv, Insert_priv, Update_priv) VALUES ('localhost', 'exomevcfe', 'solexa', 'Y', 'Y', 'Y');
insert into mysql.db (Host, Db, User, Select_priv) VALUES ('localhost', 'exomehg19', 'solexa', 'Y');
insert into mysql.db (Host, Db, User, Select_priv) VALUES ('localhost', 'hg19', 'solexa', 'Y');
flush privileges;
EOF

# Create three password files in /usr/tools
# File for application 'user' /usr/tools/textreadonly.txt
echo "dblogin:exomereadonly" > /usr/tools/textreadonly.txt
echo "dbpasswd:mysqlpassword" >> /usr/tools/textreadonly.txt
echo "csrfsalt:XXXXX" >> /usr/tools/textreadonly.txt

# File for application 'managment' /usr/tools/text.txt
echo "dblogin:exome" > /usr/tools/text.txt
echo "dbpasswd:exome" >> /usr/tools/text.txt
echo "csrfsalt:XXXXX" >> /usr/tools/text.txt

# File for application 'solexa' /usr/tools/solexa.txt
echo "dblogin:solexa" > /usr/tools/solexa.txt
echo "dbpasswd:solexa" >> /usr/tools/solexa.txt
echo "csrfsalt:XXXXX" >> /usr/tools/solexa.txt

# Create an admin user
mysql -u root -p exomevcfe <<EOF
insert into exomevcfe.user (name,password,role,edit,genesearch,yubikey) VALUES ('admin','$2a$08$pmAbhhM2wYD/G9oxziYV3.J9MHwOTG2edQP.RXX.YF2HAhWJ0L1Jm','admin',1,1,0);
quit
EOF

# Output instructions for the admin user
echo "Admin User Setup Completed."
echo "Login using the following credentials:"
echo "Username: admin"
echo "Password: Admintest1"
echo "Yubikey is disabled. Change the password and activate the Yubikey."
echo "Two-factor authentication with one-time-password can be enabled using a classical YubiKey."
echo "To enable this feature, provide the YubiKey ID and API key in /usr/tools/textreadonly2.txt."
echo "To disable this feature, set the 'user' field in exomevcfe.user to '0'."
echo "For YubiKey registration, visit: https://upgrade.yubico.com/getapikey/"
EOF