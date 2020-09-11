import logging

import pybreaker


class CircuitBreakerListener(pybreaker.CircuitBreakerListener):

    def failure(self, cb, exc):
        logging.info("CRITICAL {0}: The last request caused a system error.".format(cb))
        pass

    def state_change(self, cb, old_state, new_state):
        logging.info("Circuit Breaker {0}: The {1} state changed to {2} state".format(cb, old_state, new_state))
        pass