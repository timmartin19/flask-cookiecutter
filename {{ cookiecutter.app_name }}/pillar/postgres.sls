postgres:
  pg_hba.conf: salt://postgres/pg_hba.conf
  postgresql_conf: /etc/postgresql/9.3/main/postgresql.conf

  use_upstream_repo: False

  lookup:
    pkg: 'postgresql-9.3'
    pkg_client: 'postgresql-client-9.3'
    pg_hba: '/etc/postgresql/9.3/main/pg_hba.conf'

  users:
    {{ cookiecutter.database_user }}:
      password: '{{ cookiecutter.database_password }}'
      createdb: True
      createroles: True
      createuser: True
      inherit: True
      replication: False

  # This section cover this ACL management of the pg_hba.conf file.
  # <type>, <database>, <user>, [host], <method>
  acls:
    - ['local', 'db1', 'localUser']
    - ['host', 'db2', 'remoteUser', '123.123.0.0/24']

  databases:
    {{ cookiecutter.app_name }}:
      owner: '{{ cookiecutter.database_user }}'
      user: '{{ cookiecutter.database_user }}'
      template: 'template0'
      lc_ctype: 'C.UTF-8'
      lc_collate: 'C.UTF-8'
      # optional extensions to enable on database
      # extensions:
      #   - uuid-ossp

  # This section will append your configuration to postgresql.conf.
  postgresconf: |
    listen_addresses = 'localhost,*'