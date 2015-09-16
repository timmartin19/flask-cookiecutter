{% raw %}{% from "nginx/map.jinja" import nginx with context %}
{% set htauth = nginx.get('htpasswd', '/etc/nginx/.htpasswd') -%}

htpasswd:
  pkg.installed:
    - name: apache2-utils

nginx-fonts:
  pkg.installed:
    - name: ttf-bitstream-vera
    - require:
      - pkg: htpasswd
    - require_in:
      - pkg: nginx

{% for name, user in pillar.get('users', {}).items() %}
{% if user['webauth'] is defined -%}

nginx_user_{{name}}:
  module.run:
    - name: basicauth.adduser
    - user: {{ name }}
    - passwd: {{ user['webauth'] }}
    - path: {{ htauth }}
    - require:
      - pkg: htpasswd

{% endif -%}
{% endfor %}
{% endraw %}