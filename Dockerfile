# Use the latest Perl image as the base
FROM evadb-base:latest AS buildBase

# Copy your Perl web application files to the Apache document root
# OLD: COPY ./cgi-bin /var/www/html/cgi-bin
COPY ./cgi-bin /usr/lib/cgi-bin
COPY ./css_js /var/www/html/css_js


# Copy your custom virtual host configuration into the container
COPY custom-vhost.conf /etc/apache2/sites-available/


# Set permissions for Apache user (www-data) to access the application files
RUN chown -R www-data:www-data /var/www/html/

#Enable your custom virtual host:
RUN a2ensite custom-vhost


# Enable CGI execution and set the handler for .cgi and .pl files
RUN sed -i 's/Options Indexes FollowSymLinks/Options Indexes FollowSymLinks ExecCGI/' /etc/apache2/apache2.conf
RUN echo 'AddHandler cgi-script .cgi .pl' >> /etc/apache2/apache2.conf

#Enable perl files 
RUN a2enmod cgid


# Set the executable permission on Perl scripts in the cgi-bin directory and its subdirectories
RUN find /usr/lib/cgi-bin -type f -name "*.pl" -exec chmod +x {} \;

# Expose port 80 for Apache
EXPOSE 80

# Start Apache web server
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
