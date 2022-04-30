import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

sizeCount = ["16384/64", "4096/128", "2048/32"]

missRates = {"Direct": [2,37,92],
             "FullLRU": [2,37,92],
             "FullRandom": [2,33,88]}

missRates2 = {"Direct": [14,38,98],
              "FullLRU": [38,38,98],
              "FullRandom": [13,38,94]}

plt.plot(sizeCount, missRates["Direct"], "o-", label="Direct Mapped")
plt.plot(sizeCount, missRates["FullLRU"], "o-", label="Fully Associated / LRU")
plt.plot(sizeCount, missRates["FullRandom"], "o-", label="Fully Associated / Random")

plt.title("Cache Types")
plt.xlabel("Cache Size / Blocks")
plt.ylabel("Miss Rate (%)")

plt.legend()

plt.show()

plt.plot(sizeCount, missRates2["Direct"], "o-", label="Direct Mapped")
plt.plot(sizeCount, missRates2["FullLRU"], "o-", label="Fully Associated / LRU")
plt.plot(sizeCount, missRates2["FullRandom"], "o-", label="Fully Associated / Random")

plt.title("Cache Types")
plt.xlabel("Cache Size / Blocks")
plt.ylabel("Miss Rate (%)")

plt.legend()

plt.show()
