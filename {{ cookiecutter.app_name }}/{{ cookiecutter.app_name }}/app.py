from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

import pkg_resources
from flask import Blueprint

{{ cookiecutter.app_name}}_blueprint = Blueprint("{{ cookiecutter.app_name }}", "{{ cookiecutter.app_name }}",
                                                 static_folder='static', template_folder='templates',
                                                 static_url_path='/static')

@{{ cookiecutter.app_name }}_blueprint.route('/version')
def version():
    return pkg_resources.get_distribution("{{ cookiecutter.app_name }}").version
