base:
  '*':
    - common
  '{{ cookiecutter.app_name }}*.dev':
    - flaskapp
  'postgres*':
    - postgres
