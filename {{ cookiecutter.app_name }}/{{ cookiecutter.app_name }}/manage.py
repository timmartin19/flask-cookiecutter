from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

import os
import webbrowser

from flask import Flask
from flask.ext.migrate import Migrate, MigrateCommand
from flask.ext.script import Manager
from flask_appconfig import AppConfig

from .models import db


def create_app(config=None):
    """
    Creates a Flask instance ready for use

    :param unicode|str config: The path to the
        configuration file to use.
    :return: A flask instance
    :rtype: Flask
    """
    app = Flask('{{ cookiecutter.app_name }}')
    AppConfig(app, config)
    db.init_app(app)
    MIGRATE.init_app(app, db, directory=_MIGRATIONS_DIR)
    return app


_BASE_DIR = os.path.dirname(__file__)
_MIGRATIONS_DIR = os.path.join(_BASE_DIR, 'migrations')
MIGRATE = Migrate(directory=_MIGRATIONS_DIR)
MANAGER = Manager(create_app)
MANAGER.add_option('-c', '--config', dest='config', required=False,
                   default=None, help='The configuration file to use when'
                                      ' setting up the application')
MANAGER.add_command('db', MigrateCommand)


@MANAGER.option('-p', '--port', default=5000, dest='port', type=int,
                required=False, help='The port to run the server on')
@MANAGER.option('-d', '--debug', dest='debug', required=False, default=False,
                action='store_true', help='If specified the server will run in debug mode.')
def runapp(port=5000, debug=False):
    """
    Runs the application stand alone.  The application
    is responsible for providing a RESTful interface for
    creating and updating alert subscriptions
    """
    app = MANAGER()
    app.run(port=port, debug=debug)


def start_manager():
    """The manager is simply responsible for parsing cli commands"""
    MANAGER.run()


@MANAGER.command
def docs():
    docs_index = _run_sphinx(build='html')
    webbrowser.open(docs_index)


def _run_sphinx(build='html'):
    from sphinx.cmdline import Sphinx
    src_dir = _get_docs_src_dir()
    build_dir = _get_docs_base_dir()
    app = Sphinx(src_dir, src_dir, build_dir, src_dir, build)
    app.build(True, [])
    docs_index = os.path.join(build_dir, 'index.html')
    return docs_index


def _get_base_dir():
    return os.path.join(os.path.dirname(__file__), '..')


def _get_docs_base():
    base_dir = _get_base_dir()
    docs_base = os.path.join(base_dir, 'docs')
    return docs_base


def _get_docs_src_dir():
    docs_base = _get_docs_base()
    src_dir = os.path.join(docs_base, 'source')
    return src_dir


def _get_docs_base_dir():
    docs_base = _get_docs_base()
    build_dir = os.path.join(docs_base, 'build')
    return build_dir


@MANAGER.command
def autodoc():
    src_dir = _get_docs_src_dir()
    api_dir = os.path.join(src_dir, 'API')
    base_dir = os.path.join(_get_base_dir(), '{{ cookiecutter.app_name }}')
    os.system('sphinx-apidoc -o {0} {1}'.format(api_dir, base_dir))


@MANAGER.command
def doctest():
    _run_sphinx('doctest')


@MANAGER.command
def pylint():
    from pylint.lint import Run
    Run(['{{ cookiecutter.app_name }}', '--rcfile', os.path.join(_get_base_dir(), 'pylintrc')])


@MANAGER.command
def test_all():
    test()
    doctest()
    pylint()


@MANAGER.command
def test():
    base_dir = _get_base_dir()
    setup = os.path.join(base_dir, 'setup.py')
    os.system('python {0} test'.format(setup))


@MANAGER.command
def unittest():
    base_dir = _get_base_dir()
    unittests = os.path.join(base_dir, '{{ cookiecutter.app_name }}_tests', 'unit')
    os.system('python -m unittest discover "{0}"'.format(unittests))


if __name__ == '__main__':
    start_manager()
