from gnukhata.tests import *

class TestVoucherController(TestController):

    def test_index(self):
        response = self.app.get(url(controller='voucher', action='index'))
        # Test response...
