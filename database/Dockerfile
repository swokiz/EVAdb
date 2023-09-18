# Use an official MariaDB as the base image
FROM mariadb:latest

# Set environment variables
ENV MYSQL_ROOT_PASSWORD=password

# Copy database dump files and Docker entry script
COPY *.dmp /docker-entrypoint-initdb.d/
COPY script.sh /docker-entrypoint-initdb.d/

# Grant execute permissions to the entry script
RUN chmod +x /docker-entrypoint-initdb.d/script.sh

# Expose the MySQL port
EXPOSE 3306

# Start the MySQL server
CMD ["mysqld"]

# End of Dockerfile