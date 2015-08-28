from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

DEBUG = True

SECRET_KEY = 'notsecret'

LOGGING =  {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'standard': {
            'format': '%(asctime)s| %(name)s/%(process)d: '
                      '%(message)s @%(funcName)s:%(lineno)d #%(levelname)s'
        }
    },
    'handlers': {
        'console': {
            'formatter': 'standard',
            'class': 'logging.StreamHandler'
        }
    },
    'root': {
        'handlers': ['console'],
        'level': 'INFO'
    },
    'loggers': {
        '{{ cookiecutter.app_name }}': {
            'handlers': ['console'],
            'level': 'DEBUG'
        }
    }
}
