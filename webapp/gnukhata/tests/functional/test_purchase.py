from gnukhata.tests import *

class TestPurchaseController(TestController):

    def test_index(self):
        response = self.app.get(url(controller='purchase', action='index'))
        # Test response...
