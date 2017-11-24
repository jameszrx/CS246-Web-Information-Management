#!/bin/bash

curl -XDELETE localhost:9200/task1b?pretty
curl -XPUT localhost:9200/task1b?pretty -d '{
	"settings":{
		"index":{
			"similarity":{
				"default":{
					"type": "classic"
				}
			}
		}
	}
}'

curl -s -H "Content-Type: application/json" -XPOST localhost:9200/task1b/_bulk?pretty --data-binary "@data/task1b.json" > /dev/null