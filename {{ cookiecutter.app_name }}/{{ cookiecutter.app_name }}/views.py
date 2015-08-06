from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

from flask import Blueprint, Response
import pkg_resources

{{ cookiecutter.app_name }}_blueprint = Blueprint('{{ cookiecutter.app_name }}', __name__,
                                                  template_folder='static', template_folder='static')

@{{ cookiecutter.app_name }}.route('/version')
def version():
    dist = pkg_resources.get_distribution("{{ cookiecutter.app_name }}")
    return Response(dist.version)
