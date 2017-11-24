#!/bin/bash

curl -XDELETE localhost:9200/task2?pretty
curl -XPUT localhost:9200/task2?pretty
curl -s -H "Content-Type: application/json" -XPOST localhost:9200/task2/_bulk --data-binary "@data/task2.json" > /dev/null

curl -XPOST localhost:9200/task2/_close?pretty
curl -XPUT localhost:9200/task2/_settings?pretty -d '
	{
		"settings":{
			"index":{
				"similarity":{
					"default":{
						"type":"BM25",
						"b": 0.5,
						"k1": 0.8
					}
				}
			}
		}
	}'
curl -XPOST localhost:9200/task2/_open?pretty
./benchmark.sh task2
