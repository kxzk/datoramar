# Example query using curl

```bash
curl -X POST -H "Content-Type: application/json" -H "token: aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee" -d 
                 '{
                 	"brandId": "271",
                 	"dateRange": "CUSTOM",
                 	"startDate": "2014-11-01",
                 	"endDate": "2014-11-05",
                 	"measurements":
                 	[
                 		{
                 			"name": "Clicks"
                 		},
                 		{
                 			"name": "Impressions"
                 		}
                 	],
                 	"dimensions":
                 	[
                 		"Day"
                 	],
                 	"groupDimensionFilters": [
                 		{
                 			"dimension": "Campaign Name",
                 			"operator": "IN",
                 			"vals":
                 			[
                 				"Superbowl"
                 			]
                 		}
                 	],
                 	"stringDimensionFilters": [
                 		{
                 			"dimension": "Creative Key",
                 			"operator": "STARTS_WITH",
                 			"val": "email"
                 		}
                 	],
                 	"stringDimensionFiltersOperator": "AND",
                 	"numberMeasurementFilter":
                 	[
                 		{
                 			"fieldName": "Impressions",
                 			"operator": "GREATER",
                 			"val": 1000
                 		}
                 	],
                 	"sortBy": "Day",
                 	"sortOrder": "ASC",
                 	"topResults": "50",
                 	"groupOthers": true,
                 	"topPerDimension": true,
                 	"totalDimensions": []
                 }'
```
