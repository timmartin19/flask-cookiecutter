flaskapp:
  config_file: '/home/{{ cookiecutter.vagrant_user }}/{{ cookiecutter.app_name }}/config.py'
  deployment_root: '/home/{{ cookiecutter.vagrant_user }}/{{ cookiecutter.app_name }}'
  logdir: '/var/log/{{ cookiecutter.app_name }}'
  logfile: '/var/log/{{ cookiecutter.app_name }}/{{ cookiecutter.app_name }}.log'
  name: {{ cookiecutter.app_name }}
  package: {{ cookiecutter.app_name }}
  pypi_index: {{ cookiecutter.pypi_index }}
  upstart_conf: '/etc/init/{{ cookiecutter.app_name }}.conf'
  virtualenvdir: '/home/{{ cookiecutter.vagrant_user }}/{{ cookiecutter.app_name }}/env'
  wsgi_file: '/home/{{ cookiecutter.vagrant_user }}/{{ cookiecutter.app_name }}/wsgi.py'
  wsgi_ini: '/home/{{ cookiecutter.vagrant_user }}{{ cookiecutter.app_name }}/{{ cookiecutter.app_name }}_uswgi.ini'
