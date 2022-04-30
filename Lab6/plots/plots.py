import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

plt.xkcd()

blockSize = [16, 32, 64, 128, 256]

missRatesRow50 = {"2k": [6,3,2,1,0],
                  "4k": [6,3,2,1,0],
                  "8k": [6,3,2,1,0],
                  "16k": [6,3,2,1,0],
                  "32k": [6,3,2,1,0]
                  }

missRatesRow100 = {"2k": [6,3,2,1,0],
                  "4k": [6,3,2,1,0],
                  "8k": [6,3,2,1,0],
                  "16k": [6,3,2,1,0],
                  "32k": [6,3,2,1,0]
                  }

missRatesCol50 = {"2k": [60,92,73,37,20],
                  "4k": [36,60,73,37,20],
                  "8k": [35,34,28,15,11],
                  "16k": [6,3,2,1,0],
                  "32k": [6,3,2,1,0]
                  }

missRatesCol100 = {"2k": [98,98,98,77,37],
                   "4k": [83,98,83,77,38],
                   "8k": [83,91,83,77,38],
                   "16k": [83,91,83,77,38],
                   "32k": [83,91,83,28,14]
                   }

plt.plot(blockSize, missRatesRow50["2k"], "o-", label="2k")
plt.plot(blockSize, missRatesRow50["4k"], "o-", label="4k")
plt.plot(blockSize, missRatesRow50["8k"], "o-", label="8k")
plt.plot(blockSize, missRatesRow50["16k"], "o-", label="16k")
plt.plot(blockSize, missRatesRow50["32k"], "o-", label="32k")

plt.title("50 x 50 Row Major Averaging")
plt.xlabel("Block Size")
plt.ylabel("Miss Rate (%)")

plt.legend()

plt.show()

plt.plot(blockSize, missRatesRow100["2k"], "o-", label="2k")
plt.plot(blockSize, missRatesRow100["4k"], "o-", label="4k")
plt.plot(blockSize, missRatesRow100["8k"], "o-", label="8k")
plt.plot(blockSize, missRatesRow100["16k"], "o-", label="16k")
plt.plot(blockSize, missRatesRow100["32k"], "o-", label="32k")

plt.title("100 x 100 Row Major Averaging")
plt.xlabel("Block Size")
plt.ylabel("Miss Rate (%)")

plt.legend()

plt.show()

plt.plot(blockSize, missRatesCol50["2k"], "o-", label="2k")
plt.plot(blockSize, missRatesCol50["4k"], "o-", label="4k")
plt.plot(blockSize, missRatesCol50["8k"], "o-", label="8k")
plt.plot(blockSize, missRatesCol50["16k"], "o-", label="16k")
plt.plot(blockSize, missRatesCol50["32k"], "o-", label="32k")

plt.title("50 x 50 Column Major Averaging")
plt.xlabel("Block Size")
plt.ylabel("Miss Rate (%)")

plt.legend()

plt.show()

plt.plot(blockSize, missRatesCol100["2k"], "o-", label="2k")
plt.plot(blockSize, missRatesCol100["4k"], "o-", label="4k")
plt.plot(blockSize, missRatesCol100["8k"], "o-", label="8k")
plt.plot(blockSize, missRatesCol100["16k"], "o-", label="16k")
plt.plot(blockSize, missRatesCol100["32k"], "o-", label="32k")

plt.title("100 x 100 Column Major Averaging")
plt.xlabel("Block Size")
plt.ylabel("Miss Rate (%)")

plt.legend()

plt.show()

