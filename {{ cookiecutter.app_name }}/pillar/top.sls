base:
  '*':
    - common
    - postgres
  '{{ cookiecutter.app_name }}*.dev':
    - flaskapp
