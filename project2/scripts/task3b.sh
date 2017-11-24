#!/bin/bash

curl -XDELETE localhost:9200/task3b?pretty
curl -XPUT localhost:9200/task3b?pretty -d '{
	"mappings": {
		"wikipage":{
			"_all" : {"type" : "string"},
			"properties":{
				"abstract" : {
					"type": "text",
					"fields": {
						"keyword" : {
							"type" : "keyword",
							"ignore_above" : 256
						}
					}
				},
				"clicks" : {
					"type": "long",
					"doc_values": true
				},
				"sections" : {
					"type" : "text",
					"fields": {
						"keyword" : {
							"type" : "keyword",
							"ignore_above" : 256
						}
					}
				},
				"title" : {
					"type" : "text",
					"fields": {
						"keyword" : {
							"type" : "keyword",
							"ignore_above" : 256
						}
					}
				},
				"url" : {
					"type" : "text",
					"fields": {
						"keyword" : {
							"type" : "keyword",
							"ignore_above" : 256
						}
					}
				}
			}
		}
	}
}
'

curl -s -H "Content-Type: application/json" -XPOST localhost:9200/task3b/_bulk?pretty --data-binary "@data/task3b.json" > /dev/null