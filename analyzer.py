import numpy
import pprint
import redis
import os
import csv

config = {
    'redis_host': os.environ.get("REDIS_HOST"),
    'redis_password': os.environ.get("REDIS_PASSWORD"),
    'redis_port': os.environ.get("REDIS_PORT", 6379),
}

r = redis.Redis(
    host=config.get("redis_host"),
    port=config.get("redis_port"),
    password=config.get("redis_password"))


def main():
    csvData = []
    keys = r.keys("*")
    with open('stats.csv', 'wb') as f:
        for i, k in enumerate(keys):
            azData = r.hgetall(k)
            if i == 0:
                fieldnames = ["AZ"] + azData.keys()
                writer = csv.DictWriter(f, fieldnames=fieldnames)
                writer.writeheader()

            azData["AZ"] = k
            writer.writerow(azData)


if __name__ == "__main__":
    main()
