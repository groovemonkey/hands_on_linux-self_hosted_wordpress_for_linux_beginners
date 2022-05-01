# Basic php-fpm and PHP configuration

Execute all of the following commands as root (`sudo -i`).

## Install the PHP extensions we need for WordPress

    apt install php-curl php-common php-imagick php-mbstring php-xml php-zip php-json php-xmlrpc php-gd

Now ensure that the directory for php-fpm sockets exists

    mkdir /run/php-fpm


## Create the PHP and php-fpm configuration files (and back up the originals)

    mv /etc/php/8.1/fpm/php-fpm.conf /etc/php/8.1/fpm/php-fpm.conf.ORIG
    nano /etc/php/8.1/fpm/php-fpm.conf

Add the following content:

    [global]
    pid = /run/php/php8.1-fpm.pid
    error_log = /var/log/php-fpm.log
    include=/etc/php/8.1/fpm/pool.d/*.conf

Remove the original (default) pool:

    rm /etc/php/8.1/fpm/pool.d/www.conf



Create a *new* default pool configuration at /etc/php/8.1/fpm/pool.d/www.conf with the following content:

`nano /etc/php/8.1/fpm/pool.d/www.conf`

    [default]
    security.limit_extensions = .php
    listen = /run/php/yourserverhostname.sock
    listen.owner = www-data
    listen.group = www-data
    listen.mode = 0660
    user = www-data
    group = www-data
    pm = dynamic
    pm.max_children = 75
    pm.start_servers = 8
    pm.min_spare_servers = 5
    pm.max_spare_servers = 20
    pm.max_requests = 500

This new default pool won't be used, but I'm creating it here to prevent new students from getting confused when they try to restart php-fpm at this point in the course. We'll remove this file again later -- you don't REALLY need it.


## Copy php.ini

Rename the original file here and then create a new one:

    mv /etc/php/8.1/fpm/php.ini /etc/php/8.1/fpm/php.ini.ORIG
    nano /etc/php/8.1/fpm/php.ini

Paste in the content below:

    [PHP]
    engine = On
    short_open_tag = Off
    asp_tags = Off
    precision = 14
    output_buffering = 4096
    zlib.output_compression = Off
    implicit_flush = Off
    unserialize_callback_func =
    serialize_precision = 17
    disable_functions =
    disable_classes =
    zend.enable_gc = On
    expose_php = Off
    max_execution_time = 30
    max_input_time = 60
    memory_limit = 128M
    error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT
    display_errors = Off
    display_startup_errors = Off
    log_errors = On
    log_errors_max_len = 1024
    ignore_repeated_errors = Off
    ignore_repeated_source = Off
    report_memleaks = On
    track_errors = Off
    html_errors = On
    variables_order = "GPCS"
    request_order = "GP"
    register_argc_argv = Off
    auto_globals_jit = On
    post_max_size = 8M
    auto_prepend_file =
    auto_append_file =
    default_mimetype = "text/html"
    default_charset = "UTF-8"
    doc_root =
    user_dir =
    enable_dl = Off
    file_uploads = On
    upload_max_filesize = 25M
    max_file_uploads = 20
    allow_url_fopen = On
    allow_url_include = Off
    default_socket_timeout = 60
    [CLI Server]
    cli_server.color = On
    [Date]
    [filter]
    [iconv]
    [intl]
    [sqlite]
    [sqlite3]
    [Pcre]
    [Pdo]
    [Pdo_mysql]
    pdo_mysql.cache_size = 2000
    pdo_mysql.default_socket=
    [Phar]
    [mail function]
    SMTP = localhost
    smtp_port = 25
    mail.add_x_header = On
    [SQL]
    sql.safe_mode = Off
    [ODBC]
    odbc.allow_persistent = On
    odbc.check_persistent = On
    odbc.max_persistent = -1
    odbc.max_links = -1
    odbc.defaultlrl = 4096
    odbc.defaultbinmode = 1
    [Interbase]
    ibase.allow_persistent = 1
    ibase.max_persistent = -1
    ibase.max_links = -1
    ibase.timestampformat = "%Y-%m-%d %H:%M:%S"
    ibase.dateformat = "%Y-%m-%d"
    ibase.timeformat = "%H:%M:%S"
    [MySQL]
    mysql.allow_local_infile = On
    mysql.allow_persistent = On
    mysql.cache_size = 2000
    mysql.max_persistent = -1
    mysql.max_links = -1
    mysql.default_port =
    mysql.default_socket =
    mysql.default_host =
    mysql.default_user =
    mysql.default_password =
    mysql.connect_timeout = 60
    mysql.trace_mode = Off
    [MySQLi]
    mysqli.max_persistent = -1
    mysqli.allow_persistent = On
    mysqli.max_links = -1
    mysqli.cache_size = 2000
    mysqli.default_port = 3306
    mysqli.default_socket =
    mysqli.default_host =
    mysqli.default_user =
    mysqli.default_pw =
    mysqli.reconnect = Off
    [mysqlnd]
    mysqlnd.collect_statistics = On
    mysqlnd.collect_memory_statistics = Off
    [OCI8]
    [PostgreSQL]
    pgsql.allow_persistent = On
    pgsql.auto_reset_persistent = Off
    pgsql.max_persistent = -1
    pgsql.max_links = -1
    pgsql.ignore_notice = 0
    pgsql.log_notice = 0
    [Sybase-CT]
    sybct.allow_persistent = On
    sybct.max_persistent = -1
    sybct.max_links = -1
    sybct.min_server_severity = 10
    sybct.min_client_severity = 10
    [bcmath]
    bcmath.scale = 0
    [browscap]
    [Session]
    session.save_handler = files
    session.use_strict_mode = 0
    session.use_cookies = 1
    session.use_only_cookies = 1
    session.name = PHPSESSID
    session.auto_start = 0
    session.cookie_lifetime = 0
    session.cookie_path = /
    session.cookie_domain =
    session.cookie_httponly =
    session.serialize_handler = php
    session.gc_probability = 1
    session.gc_divisor = 1000
    session.gc_maxlifetime = 1440
    session.referer_check =
    session.cache_limiter = nocache
    session.cache_expire = 180
    session.use_trans_sid = 0
    session.hash_function = 0
    session.hash_bits_per_character = 5
    url_rewriter.tags = "a=href,area=href,frame=src,input=src,form=fakeentry"
    [MSSQL]
    mssql.allow_persistent = On
    mssql.max_persistent = -1
    mssql.max_links = -1
    mssql.min_error_severity = 10
    mssql.min_message_severity = 10
    mssql.compatibility_mode = Off
    mssql.secure_connection = Off
    [Assertion]
    [COM]
    [mbstring]
    [gd]
    [exif]
    [Tidy]
    tidy.clean_output = Off
    [soap]
    soap.wsdl_cache_enabled=1
    soap.wsdl_cache_dir="/tmp"
    soap.wsdl_cache_ttl=86400
    soap.wsdl_cache_limit = 5
    [sysvshm]
    [ldap]
    ldap.max_links = -1
    [dba]
    [opcache]
    [curl]
    [openssl]


## You're not done yet...

... but if you were, you'd restart php-fpm right now, with:

    systemctl restart php8.1-fpm

