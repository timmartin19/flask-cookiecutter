from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

import webbrowser
import os


@cli.command()
def docs():
    docs_index = _run_sphinx(build='html')
    webbrowser.open(docs_index)


@cli.command()
@click.pass_context
def autodoc(ctx):
    src_dir = _get_docs_src_dir()
    api_dir = os.path.join(src_dir, 'API')
    base_dir = os.path.join(_get_base_dir(), '{{ cookiecutter.app_name }}')
    os.system('sphinx-apidoc -o {0} {1}'.format(api_dir, base_dir))


@cli.command()
def doctest():
    _run_sphinx('doctest')


@cli.command()
def pylint():
    from pylint.lint import Run
    Run(['{{ cookiecutter.app_name }}'])


@cli.command()
def test_all():
    pylint()
    doctest()
    test()


@cli.command()
def test():
    base_dir = _get_base_dir()
    setup = os.path.join(base_dir, 'setup.py')
    os.system('python {0} test'.format(base_dir))


@cli.command()
@click.pass_context
def unittest(ctx):
    base_dir = _get_base_dir()
    unittests = os.path.join(base_dir, '{{ cookiecutter.app_name }}_tests', 'unit')
    os.system('python -m unittest discover "{0}"'.format(unittests))
