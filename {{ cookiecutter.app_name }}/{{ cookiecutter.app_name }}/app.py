from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

from flask import Flask
from flask.ext.script import Manager
from flask.ext.migrate import Migrate, MigrateCommand

from .models import db

migrate = Migrate()


def create_app():
    app = Flask(__name__)
    db.init_app(app)
    migrate.init_app(app, db)
    return app


def run_manager():
    app = create_app()
    manager = Manager(app)
    manager.add_command('db', MigrateCommand)
    manager.run()


def runserver():
    app = create_app()
    app.run()
