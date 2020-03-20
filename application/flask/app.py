from flask import Flask
from flask_restful import Resource, Api
from os import getenv

app = Flask(__name__)
api = Api(app)

class Example(Resource):
    def get(self):
        if not (getenv('DEMO_USERNAME') and getenv('DEMO_PASSWORD')):
            content = 'not all variables are set'
            status = 500
        else:
            content = 'Welcome ' + str(getenv('DEMO_USERNAME'))
            status = 200
        return content,status

api.add_resource(Example, '/')

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
