{% raw %}{% from "flaskapp/map.jinja" import app, common with context %}

# Install the basic
python-pkgs:
  pkg.installed:
    - names:
      - build-essential
      - python-dev
      - python-pip
      - python-virtualenv

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
      - setuptools
      - pip
    {% if app.pypi_index %}- index_url: {{ app.pypi_index }}{% endif %}
    - user: {{ common.user }}
    - bin_env: {{ app.virtualenvdir }}
    #- upgrade: True
    - use_vt: True
    - upgrade: True
    - require:
      - virtualenv: create-virtualenv
      - pkg: python-pkgs
{% endraw %}