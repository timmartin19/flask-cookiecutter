from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

from setuptools import setup, find_packages

version = "0.0.1"

setup(
    author="{{ cookiecutter.author }}",
    author_email="{{ cookiecutter.author_email }}",
    classifiers=[  # For a full list of valid classifiers see https://pypi.python.org/pypi?%3Aaction=list_classifiers
        "Development Status :: 2 Pre-Alpha",
        "Framework :: Flask",
        "Programming Language :: Python",
    ],
    description="{{ cookiecutter.description }}",
    entry_points={
        'console_scripts': [
            'runserver = {{ cookiecutter.app_name }}.app:runserver',
        ]
    },
    extras_require={
        'dev': [
            'sphinx',
        ]
    },
    keywords='Flask Web',
    install_requires=[
        'click',
        'flask',
        'Flask-AppConfig',
        'Flask-Migrate',
        'Flask-SQLAlchemy',
    ],
    name="{{ cookiecutter.app_name }}",
    packages=find_packages(
        include=[
            "{{ cookiecutter.app_name }}",
            "{{ cookiecutter.app_name.* }}"
        ]
    ),
    tests_require=[
        'mock',
        'unittest2',
    ],
    test_suite="{{ cookiecutter.app_name }}_tests",
)
