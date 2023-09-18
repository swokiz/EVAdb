
# create databases
mysqladmin  create exomehg19 -u root -p
mysqladmin  create exomehg19plus -u root -p
mysqladmin  create exomevcfe -u root -p
mysqladmin  create solexa -u root -p
mysqladmin  create hgmd_pro -u root -p
mysqladmin  create hg19 -u root -p

# import tables
mysql -L exomehg19  < database/  exomehg19_nodata.dmp -u root -p
mysql -L exomehg19plus  < database/  exomehg19plus_nodata.dmp -u root -p
mysql -L exomevcfe  < database/  exomevcfe_nodata.dmp -u root -p
mysql -L solexa  < database/  solexa_nodata.dmp -u root -p
mysql -L hgmd_pro  < database/  hgmd_pro_nodata.dmp -u root -p

mysql -L solexa  < database/  solexa_assay.dmp -u root -p
mysql -L solexa  < database/  solexa_barcodes10x.dmp -u root -p
mysql -L solexa  < database/  solexa_libpair.dmp -u root -p
mysql -L solexa  < database/  solexa_libtype.dmp -u root -p
mysql -L solexa  < database/  solexa_runtype.dmp -u root -p
mysql -L solexa  < database/  solexa_tag.dmp -u root -p

mysql -L exomehg19  < database/  exomehg19_organism.dmp -u root -p
mysql -L exomehg19  < database/  exomehg19_tissue.dmp -u root -p
mysql -L exomehg19  < database/  exomehg19_diseasegroup.dmp -u root -p

mysql -L hg19  < database/  hg19_pph3_nodata.dmp -u root -p
mysql -L hg19  < database/  hg19_sift_nodata.dmp -u root -p
mysql -L hg19  < database/  hg19_cadd_nodata.dmp -u root -p
mysql -L hg19  < database/  hg19_evs_nodata.dmp -u root -p
mysql -L hg19  < database/  hg19_evsscores_nodata.dmp -u root -p
mysql -L hg19  < database/  hg19_kaviar_nodata.dmp -u root -p
mysql -L hg19  < database/  hg19_dgvbp_nodata.dmp -u root -p
mysql -L hg19  < database/  hg19_hgnc_nodata.dmp -u root -p




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