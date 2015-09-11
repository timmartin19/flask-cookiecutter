app:
  config_file: '/home/{{ cookiecutter.vagrant_user }}/app/config.py'
  deployment_root: '/home/{{ cookiecutter.vagrant_user }}/app'
  logdir: /var/log/{{ cookiecutter.app_name }}
  logfile: /var/log/{{ cookiecutter.app_name }}/{{ cookiecutter.app_name }}.log
  name: {{ cookiecutter.app_name }}
  package: {{ cookiecutter.app_name }}
  pypi_index: {{ cookiecutter.pypi_index }}
