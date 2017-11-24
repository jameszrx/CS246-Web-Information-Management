#!/bin/bash

curl -XDELETE localhost:9200/task2a?pretty
curl -XPUT localhost:9200/task?pretty
curl -s -H "Content-Type: application/json" -XPOST localhost:9200/_bulk?pretty --data-binary "@data/task1a.json" > /dev/null