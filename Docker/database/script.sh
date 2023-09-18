#!/bin/bash

set -eux

echo "Enter root password"
read PASSWORD

# create databases
mysqladmin  create exomehg19 -u root -p${PASSWORD}
mysqladmin  create exomehg19plus -u root -p${PASSWORD}
mysqladmin  create exomevcfe -u root -p${PASSWORD}
mysqladmin  create solexa -u root -p${PASSWORD}
mysqladmin  create hgmd_pro -u root -p${PASSWORD}
mysqladmin  create hg19 -u root -p${PASSWORD}

# import tables
mysql -L exomehg19  < exomehg19_nodata.dmp -u root -p${PASSWORD}
mysql -L exomehg19plus  < exomehg19plus_nodata.dmp -u root -p${PASSWORD}
mysql -L exomevcfe  < exomevcfe_nodata.dmp -u root -p${PASSWORD}
mysql -L solexa  < solexa_nodata.dmp -u root -p${PASSWORD}
mysql -L hgmd_pro  < hgmd_pro_nodata.dmp -u root -p${PASSWORD}

mysql -L solexa  < solexa_assay.dmp -u root -p${PASSWORD}
mysql -L solexa  < solexa_barcodes10x.dmp -u root -p${PASSWORD}
mysql -L solexa  < solexa_libpair.dmp -u root -p${PASSWORD}
mysql -L solexa  < solexa_libtype.dmp -u root -p${PASSWORD}
mysql -L solexa  < solexa_runtype.dmp -u root -p${PASSWORD}
mysql -L solexa  < solexa_tag.dmp -u root -p${PASSWORD}

mysql -L exomehg19  < exomehg19_organism.dmp -u root -p${PASSWORD}
mysql -L exomehg19  < exomehg19_tissue.dmp -u root -p${PASSWORD}
mysql -L exomehg19  < exomehg19_diseasegroup.dmp -u root -p${PASSWORD}

mysql -L hg19  < hg19_pph3_nodata.dmp -u root -p${PASSWORD}
mysql -L hg19  < hg19_sift_nodata.dmp -u root -p${PASSWORD}
mysql -L hg19  < hg19_cadd_nodata.dmp -u root -p${PASSWORD}
mysql -L hg19  < hg19_evs_nodata.dmp -u root -p${PASSWORD}
mysql -L hg19  < hg19_evsscores_nodata.dmp -u root -p${PASSWORD}
mysql -L hg19  < hg19_kaviar_nodata.dmp -u root -p${PASSWORD}
mysql -L hg19  < hg19_dgvbp_nodata.dmp -u root -p${PASSWORD}
mysql -L hg19  < hg19_hgnc_nodata.dmp -u root -p${PASSWORD}




# Modify the config file
#echo "[mysqld]" >> /etc/mysql/mariadb.conf.d/50-server.cnf
#echo "sql_mode=''" >> /etc/mysql/mariadb.conf.d/50-server.cnf
#echo "innodb_buffer_pool_size = 61G" >> /etc/mysql/mariadb.conf.d/50-server.cnf
#echo "innodb_buffer_pool_instances = 30" >> /etc/mysql/mariadb.conf.d/50-server.cnf
# Add other configuration settings...



# Restart the MySQL server to apply the changes
#mysqladmin -uroot -proot_password shutdown
#/script.sh mysqld

# Keep the container running
#tail -f /dev/null
