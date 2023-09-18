# Use the latest Perl image as the base
FROM perl:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    apache2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#Install the required Perl modules
RUN cpan CGI
RUN cpan App::cpanminus
RUN cpan CPAN::DistnameInfo

#Install libcgi-pm-perl using apt-get
RUN apt-get update && apt-get install -y libcgi-pm-perl


#Install the required Perl modules
RUN cpan CGI::Safe
RUN cpan String::Util

#RUN cpan CGI::Plus
RUN cpan -T CGI::Plus


RUN cpan CGI::Session
RUN cpan DBI
RUN cpan Crypt::Eksblowfish::Bcrypt
RUN cpan File::Basename
RUN cpan Auth::Yubikey_WebClient
RUN cpan Tie::IxHash
RUN cpan Apache::Solr
RUN cpan HTML::Entities
RUN cpan WWW::CSRF
RUN cpan Crypt::Random
RUN cpan LWP::Simple
RUN cpan Text::NSP::Measures::2D::Fisher::twotailed
RUN cpan XML::Simple
RUN apt-get update && apt-get install -y r-base
RUN cpan Statistics::R
RUN cpan Cache::FileCache
RUN cpan Digest::MD5
RUN cpan Date::Calc
RUN cpan Data::Dumper
RUN cpan Text::ParseWords
RUN cpan Cwd
RUN cpan Log::Log4perl

# Install XML::DOM::XPath without testing
RUN perl -MCPAN -e "CPAN::Shell->notest('install', 'XML::DOM::XPath')"

# Install Bio::DB::Fasta
RUN cpan Bio::DB::Fasta

#Install Log::Dispatch::File
RUN cpan Log::Dispatch::File

# Copy your Perl web application files to the Apache document root
COPY ./cgi-bin /var/www/html/cgi-bin
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
 #RUN a2enmod cgid


# Set the executable permission on Perl scripts
#RUN chmod +x /var/www/html/cgi-bin/*.pl

# Set the executable permission on Perl scripts in the cgi-bin directory and its subdirectories
RUN find /var/www/html/cgi-bin -type f -name "*.pl" -exec chmod +x {} \;

# Expose port 80 for Apache
EXPOSE 80

# Start Apache web server
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]








# Make all .pl files executable in the cgi-bin directory and its subdirectories
#RUN find /srv/www/cgi-bin/mysql/. -type f -name "*.pl" -exec chmod +x {} \;



