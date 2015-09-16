base:
  '*':
    - common
    - postgres
    - nginx
  '{{ cookiecutter.app_name }}*.dev':
    - flaskapp
