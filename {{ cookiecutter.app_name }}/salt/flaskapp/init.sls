{% raw %}
{% from "flaskapp/map.jinja" import app, common with context %}

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

  # Upgrade pip and setuptools since they are very low versions
  pip.installed:
    - pkgs:
      - setuptools>=18
      - pip>=7
    - index_url: {{ app.pypi_index }}
    - bin_env: {{ app.virtualenvdir }}
    - require:
      - virtualenv: create_virtualenv
    - user: {{ common.user }}
{% endraw %}