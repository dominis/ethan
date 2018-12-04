import socket
import time
import urllib2
import random
import string
import numpy
import pprint
import redis
import os

config = {
    'redis_host': os.environ.get("REDIS_HOST"),
    'redis_password': os.environ.get("REDIS_PASSWORD"),
    'redis_port': os.environ.get("REDIS_PORT", 6379),
    'test_host': os.environ.get("TEST_HOST"),
    'availability_zone': os.environ.get("AVAILABILITY_ZONE"),
    'test_count': os.environ.get("TEST_COUNT", 25),
}

def profileQuery(host, queryString):
    dns_start = time.time()
    socket.gethostbyname(host)
    dns_end = time.time()

    url = 'https://%s/%s' % (host, queryString)
    req = urllib2.Request(url)

    handshake_start = time.time()
    stream = urllib2.urlopen(req)
    handshake_end = time.time()

    data_start = time.time()
    stream.read()
    data_end = time.time()

    return {
        'dns_resolution': ((dns_end - dns_start) * 1000),
        'tcp_handshake': ((handshake_end - handshake_start) * 1000),
        'data_transfer': ((data_end - data_start) * 1000),
        'total': ((data_end - dns_start) * 1000),
    }

def generateRandom(count):
    res = []
    letters = string.ascii_lowercase
    for a in range(0, count):
        res.append(''.join(random.choice(letters)
                           for i in range(random.randint(30, 150))))

    return res

def runProfiler(host, requestNum):
    print("Gathering data, running %s requests on %s" % (requestNum, host))
    qList = generateRandom(requestNum)
    data = {}
    stats = {}

    print("Generating statistics")
    retrySleep = 1
    res = {}
    for q in qList:
        while True:
            try:
                res = profileQuery(host, q)
                print(res)
                retrySleep = 1
            except urllib2.HTTPError as identifier:
                print("HTTP error sleeping %ds" % retrySleep)
                time.sleep(retrySleep)
                retrySleep = retrySleep*2
                if(retrySleep > 100):
                    retrySleep = 1
                pass
            break

        for k, v in res.items():
            if k in data:
                data[k].append(v)
            else:
                data[k] = []

    for k, v in data.items():
        stats["%s_mean" % k] = numpy.mean(v)
        stats["%s_95th" % k] = numpy.percentile(v, 95)
        stats["%s_max" % k] = numpy.max(v)
        stats["%s_min" % k] = numpy.min(v)

    return stats

def saveResults(results):
    r = redis.Redis(
        host=config.get("redis_host"),
        port=config.get("redis_port"),
        password=config.get("redis_password"))

    for k, v in results.items():
        r.hset(
            config.get("availability_zone"),
            k,
            v
        )

def main():
    print("Starting profiling")
    print("Config %s", config)
    out = runProfiler(
        config.get("test_host"),
        int(config.get("test_count")))
    saveResults(out)
    pprint.pprint(out)

if __name__ == "__main__":
  main()
