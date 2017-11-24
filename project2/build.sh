#!/bin/bash

# In case you use the provided ParseJSON.java code for preprocessing the wikipedia dataset, 
# uncomment the following two commands to compile and execute your modified code in this script.
#
javac ParseJSON.java
# java ParseJSON

# TASK 1A:
# Create index "task1a" with "wikipage" type using BM25Similarity 
java ParseJSON task1a
curl -XDELETE localhost:9200/task2a?pretty
curl -XPUT localhost:9200/task?pretty
curl -s -H "Content-Type: application/json" -XPOST localhost:9200/_bulk?pretty --data-binary "@data/task1a.json" > /dev/null

# TASK 1B:
# Create index "task1b" with "wikipage" type using ClassicSimilarity (Lucene's version of TFIDF implementation)
java ParseJSON task1b
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

# TASK 2:
# Create index "task2" with "wikipage" type using BM25Similarity with the best k1 and b values that you found
java ParseJSON task2
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

# Task 3:
# Create index "task3" with "wikipage"
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

# Task 3c:
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
	},
	"settings" : {
		"index" : {
			"similarity" : {
				"default" : {
					"type" : "cs246-similarity"
				}
			}
		}
	}
}
'

curl -s -H "Content-Type: application/json" -XPOST localhost:9200/task3b/_bulk --data-binary "@data/task3b.json" > /dev/null