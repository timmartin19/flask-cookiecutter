{% raw %}{% from "flaskapp/map.jinja" import app, common with context %}

# Install the basic
python-pkgs:
  pkg.installed:
    - names:
      - build-essential
      - python-dev
      - python-pip
      - python-virtualenv
      - libxml2-dev
      - libxslt1-dev

# Create a virtualenv to install the packages in.
create-virtualenv:
  virtualenv.managed:
    - name: {{ app.virtualenvdir }}
    - user: {{ common.user }}
    - require:
      - pkg: python-pkgs

  # Upgrade pip and setuptools since they are very old versions by default
  pip.installed:
    - names:
      - pyOpenSSL
      - setuptools
      - pip
      - uwsgi
    {% if app.pypi_index %}- index_url: {{ app.pypi_index }}{% endif %}
    - user: {{ common.user }}
    - bin_env: {{ app.virtualenvdir }}
    #- upgrade: True
    - use_vt: True
    - upgrade: True
    - require:
      - virtualenv: create-virtualenv
      - pkg: python-pkgs

{{ app.name }}-wsgi:
  file.managed:
    - name: {{ app.wsgi_file }}
    - source: salt://flaskapp/templates/wsgi.jinja
    - template: jinja
    - user: {{ common.user }}
    - context:
      config_file: {{ app.config_file }}

wsgi-upstart-conf:
  file.managed:
    - name: {{ app.upstart_conf }}
    - souce: salt://flaskapp/templates/usptartconf.jinja
    - template: jinja
    - user: {{ common.user }}
    - context:
      virtualenvdrc: {{ app.virtualenvdir }}
      user: {{ common.user }}
      project_dir: {{ app.deployment_root }}
      uwsgi_ini: {{ app.wsgi_ini }}



install-package:
  pip.installed:
    - editable: '/vagrant'
    - user: {{ common.user }}
    - use_vt: True
    - require:
      - pip: create-virtualenv
    - bin_env: {{ app.virtualenvdir }}


{% endraw %}