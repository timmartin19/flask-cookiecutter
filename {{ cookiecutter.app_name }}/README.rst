{{ cookiecutter.app_name }}
{% for character in cookiecutter.app_name %}={% endfor %}

{{ cookiecutter.description }}

Installation
------------

To install the project locally for development and install all necesary dependencies,
cd into the root directory of the project and run the following.

.. code-block:: sh

    pip install -e .[dev]

Then copy the dev.py.example file to dev.py

.. code-block:: sh

    cp config/dev.py.example config/dev.py

Testing
-------

There are five different test commands for {{ cookiecutter.app_name }}: `test`, `unittest`, `pylint`, `doctest`, and `test_all`.

- `test`: Runs all of the python based tests in the `{{ cookiecutter.app_name }}_tests` folder.
- `unittest`: Runs a subset of the tests from tests by only running the tests in `{{ cookiecutter.app_name }}_tests/unit`
- `pylint`: Runs pylint on the package.  Ensures the code is pythonic.
- `doctest`: Runs the doctests that ensure your documentation is up to date
- `test_all`: Runs `test`, `doctest`, and `pylint` in that order.

 To run a test command simply call: ```{{ cookiecutter.app_name }} testcommand]```

Documentation
-------------

Building and opening the documentation is as simple as calling ```{{ cookiecutter.app_name }} docs```

If you would like to auto generate api documentation based the docstrings of your modules, classes, and methods
simply call ```{{ cookiecutter.app_name }} autodoc```
