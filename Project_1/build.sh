#!/bin/bash

# In case you use the provided ParseJSON.java code for preprocessing the wikipedia dataset, 
# uncomment the following two commands to compile and execute your modified code in this script.
#
 javac ParseJSON.java

# TASK 2A:
# Create and index the documents using the default standard analyzer
java ParseJSON task2a
curl -XDELETE localhost:9200/task2a?pretty
curl -XPUT localhost:9200/task2a?pretty
curl -s -H "Content-Type: application/json" -XPOST localhost:9200/_bulk?pretty --data-binary "@data/task2a.json"



# TASK 2B:
# Create and index with a whitespace analyzer
java ParseJSON task2b
curl -XDELETE localhost:9200/task2b?pretty
curl -XPUT localhost:9200/task2b?pretty -d'{
	"mappings":{
		"wikipage" : {
			"_all" : {"type" : "string", "analyzer": "whitespace"},
			"properties":{
				"abstract": {
					"type" : "string",
					"analyzer" : "whitespace"
				},
				"sections": {
					"type" : "string",
					"analyzer" : "whitespace"
				},
				"title": {
					"type" : "string",
					"analyzer" : "whitespace"
				},
				"url": {
					"type" : "string",
					"analyzer" : "whitespace"
				},
				"sublink" : {
					"properties" : {
						"linktype" : {
							"type" : "string",
							"analyzer" : "whitespace"
						}
					}
				}
			}
		}
	}
}
'
curl -s -H "Content-Type: application/json" -XPOST localhost:9200/_bulk?pretty --data-binary "@data/task2b.json"

# TASK 2C:
# Create and index with a custom analyzer as specified in Task 2C
java ParseJSON task2c
curl -XDELETE localhost:9200/task2c?pretty
curl -XPUT localhost:9200/task2c?pretty -d '
{
	"mappings" : {
		"wikipage" : {
			"_all" : {
				"type" : "string",
				"analyzer" : "task2c_analyzer"
			},
			"properties": {
				"abstract" : {
					"type" : "string",
					"analyzer" : "task2c_analyzer"
				},
				"sections": {
					"type" : "string",
					"analyzer" : "task2c_analyzer"
				},
				"title": {
					"type" : "string",
					"analyzer" : "task2c_analyzer"
				},
				"url": {
					"type" : "string",
					"analyzer" : "task2c_analyzer"
				},
				"sublink" : {
					"properties" : {
						"linktype" : {
							"type" : "string",
							"analyzer" : "task2c_analyzer"
						}
					}
				}
			}
		}
	},
	"settings": {
		"analysis": {
			"analyzer" : {
				"task2c_analyzer" : {
					"type" : "custom",
					"char_filter" : ["html_strip"],
					"tokenizer" : "standard",
					"filter": ["asciifolding", "lowercase", "stop", "snowball"]
				}
			}
		}
	}
}
'
curl -s -H "Content-Type: application/json" -XPOST localhost:9200/_bulk?pretty --data-binary "@data/task2c.json"
