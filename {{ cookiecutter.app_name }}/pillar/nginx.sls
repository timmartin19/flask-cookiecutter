nginx:
  install_from_source: True
  use_upstart: True
  use_sysvinit: False
  user_auth_enabled: True
  with_luajit: False
  with_openresty: True
  repo_version: development  # Must be using ppa install by setting `repo_source = ppa`
  set_real_ips: # NOTE: to use this, nginx must have http_realip module enabled
    from_ips:
      - 10.10.10.0/24
    real_ip_header: X-Forwarded-For
  modules:
    headers-more:
      source: http://github.com/agentzh/headers-more-nginx-module/tarball/v0.21
      source_hash: sha1=9146cb314cd3510d5fb7ac08e2027d1f24c924a0

# TODO Remove this
# ========
# nginx.ng
# ========
#
#nginx:
#  ng:
#    # PPA installing
#    install_from_ppa: True
#    # Set to 'stable', 'development' (mainline), 'community', or 'nightly' for each build accordingly ( https://launchpad.net/~nginx )
#    ppa_version: 'stable'
#
#    # These are usually set by grains in map.jinja
#    lookup:
#      package: nginx-custom
#      service: nginx
#      webuser: www-data
#      conf_file: /etc/nginx/nginx.conf
#      vhost_available: /etc/nginx/sites-available
#      vhost_enabled: /etc/nginx/sites-enabled
#      vhost_use_symlink: True
#      # This is required for RedHat like distros (Amazon Linux) that don't follow semantic versioning for $releasever
#      rh_os_releasever: '6'
#
#    # Source compilation is not currently a part of nginx.ng
#    from_source: False
#
#    package:
#      opts: {} # this partially exposes parameters of pkg.installed
#
#    service:
#      enable: True # Whether or not the service will be enabled/running or dead
#      opts: {} # this partially exposes parameters of service.running / service.dead
#
#    server:
#      opts: {} # this partially exposes file.managed parameters as they relate to the main nginx.conf file
#
#      # nginx.conf (main server) declarations
#      # dictionaries map to blocks {} and lists cause the same declaration to repeat with different values
#      config:
#        worker_processes: 4
#        pid: /run/nginx.pid
#        events:
#          worker_connections: 768
#        http:
#          sendfile: 'on'
#          include:
#            - /etc/nginx/mime.types
#            - /etc/nginx/conf.d/*.conf
#
#    vhosts:
#      disabled_postfix: .disabled # a postfix appended to files when doing non-symlink disabling
#      symlink_opts: {} # partially exposes file.symlink params when symlinking enabled sites
#      rename_opts: {} # partially exposes file.rename params when not symlinking disabled/enabled sites
#      managed_opts: {} # partially exposes file.managed params for managed vhost files
#      dir_opts: {} # partially exposes file.directory params for site available/enabled dirs
#
#      # vhost declarations
#      # vhosts will default to being placed in vhost_available
#      managed:
#        mysite: # relative pathname of the vhost file
#          # may be True, False, or None where True is enabled, False, disabled, and None indicates no action
#          available_dir: /tmp/sites-available # an alternate directory (not sites-available) where this vhost may be found
#          enabled_dir: /tmp/sites-enabled # an alternate directory (not sites-available) where this vhost may be found
#          disabled_name: mysite.aint_on # an alternative disabled name to be use when not symlinking
#          enabled: True
#
#          # May be a list of config options or None, if None, no vhost file will be managed/templated
#          # Take server directives as lists of dictionaries. If the dictionary value is another list of
#          # dictionaries a block {} will be started with the dictionary key name
#          config:
#            - server:
#              - server_name: localhost
#              - listen:
#                - 80
#                - default_server
#              - index:
#                - index.html
#                - index.htm
#              - location ~ .htm:
#                - try_files:
#                  - $uri
#                  - $uri/ =404
#                - test: something else
#
#          # The above outputs:
#          # server {
#          #    server_name localhost;
#          #    listen 80 default_server;
#          #    index index.html index.htm;
#          #    location ~ .htm {
#          #        try_files $uri $uri/ =404;
#          #        test something else;
#          #    }
#          # }
#
#    # If you're doing SSL termination, you can deploy certificates this way.
#    # The private one(s) should go in a separate pillar file not in version
#    # control (or use encrypted pillar data).
#    certificates:
#      'www.example.com':
#        public_cert: |
#          -----BEGIN CERTIFICATE-----
#          (Your Primary SSL certificate: www.example.com.crt)
#          -----END CERTIFICATE-----
#          -----BEGIN CERTIFICATE-----
#          (Your Intermediate certificate: ExampleCA.crt)
#          -----END CERTIFICATE-----
#          -----BEGIN CERTIFICATE-----
#          (Your Root certificate: TrustedRoot.crt)
#          -----END CERTIFICATE-----
#        private_key: |
#          -----BEGIN RSA PRIVATE KEY-----
#          (Your Private Key: www.example.com.key)
#          -----END RSA PRIVATE KEY-----
