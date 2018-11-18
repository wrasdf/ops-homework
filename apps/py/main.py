import falcon
from wsgiref import simple_server

class RootResource:
    def on_get(self, req, resp):
        resp.status = falcon.HTTP_200
        resp.body = "Hello world python"

class MetadataResource:
    def on_get(self, req, resp):
        resp.status = falcon.HTTP_200
        resp.body = """
{
    "version": "v0.0.2",
    "language": "python",
    "author": "kerry"
}
"""

class HealthyResource:
    def on_get(self, req, resp):
        resp.status = falcon.HTTP_200
        resp.body = ('ok')

api = falcon.API()
api.add_route('/py', RootResource())
api.add_route('/py/metadata', MetadataResource())
api.add_route('/py/health', HealthyResource())

if __name__ == '__main__':
    httpd = simple_server.make_server('0.0.0.0', 3003, api)
    httpd.serve_forever()
