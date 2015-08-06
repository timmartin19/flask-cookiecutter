from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

import webbrowser
import os

import click

from flask import Flask
from flask_appconfig import AppConfig
from flask.ext.script import Manager
from flask.ext.migrate import Migrate, MigrateCommand
from sphinx.application import Sphinx

from .models import db

manager = Manager(usage="{{ cookiecutter.app_name }} easy commands")
migrate = Migrate()


@click.group()
@click.option('--settings')
@click.pass_context
def cli(ctx, settings):
    app = Flask(__name__)
    AppConfig(app, settings)
    db.init_app(app)
    migrate.init_app(app, db)
    ctx.obj['APP'] = app


@cli.commmand()
@click.pass_context
def runserver(ctx):
    app = ctx.obj['APP']
    app.run()


@cli.command()
@click.pass_context
def db(ctx):
    MigrateCommand.app = ctx['APP']
    MigrateCommand.run()


@cli.command()
@click.pass_context
def docs(ctx):
    docs_index = _run_sphinx(build='html')
    webbrowser.open(docs_index)


def _run_sphinx(build='html'):
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


@cli.command()
@click.pass_context
def autodoc(ctx):
    src_dir = _get_docs_src_dir()
    api_dir = os.path.join(src_dir, 'API')
    base_dir = os.path.join(_get_base_dir(), '{{ cookiecutter.app_name }}')
    os.system('sphinx-apidoc -o {0} {1}'.format(api_dir, base_dir))


@cli.command()
@click.pass_context
def doctest(ctx):
    _run_sphinx('doctest')
