from gnukhata.tests import *

class TestCustomizationController(TestController):

    def test_index(self):
        response = self.app.get(url(controller='customization', action='index'))
        # Test response...
