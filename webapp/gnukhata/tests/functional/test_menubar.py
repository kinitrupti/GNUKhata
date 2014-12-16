from gnukhata.tests import *

class TestMenubarController(TestController):

    def test_index(self):
        response = self.app.get(url(controller='menubar', action='index'))
        # Test response...
