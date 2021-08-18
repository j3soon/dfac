REGISTRY = {}

from .rnn_agent import RNNAgent
from .iqn_rnn_agent import IQNRNNAgent
REGISTRY["rnn"] = RNNAgent
REGISTRY["iqn_rnn"] = IQNRNNAgent