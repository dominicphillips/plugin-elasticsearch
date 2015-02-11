Boundary Elasticsearch Plugin
-------------------------

Collects metrics from a elastic search instance.

### Prerequisites

|     OS    | Linux | Windows | SmartOS | OS X |
|:----------|:-----:|:-------:|:-------:|:----:|
| Supported |   v   |    v    |    v    |  v   |

|  Runtime | LUA/luvit |
|:---------|:-------:|:------:|:----:|
| Required |    +    |        |      |


### Plugin Setup
None

#### Plugin Configuration Fields

|Field Name|Description                                                |
|:---------|:----------------------------------------------------------|
|Port      |The ELASTICSEARCH port.                                        |
|Host      |The ELASTICSEARCH hostname.                                    |

### Metrics Collected
|Metric Name          |Description                       |
|:--------------------|:---------------------------------|
| ELASTIC_CLUSTERNAME | The name of the cluster, defaults to elasticsearch
| ELASTIC_STATUS | The status of the cluster
| ELASTIC_TIMED_OUT | Timeout
| ELASTIC_NUMBER_OF_NODES | Number of Nodes
| ELASTIC_NUMBER_OF_DATA_NODES | Number of Data Nodes
| ELASTIC_ACTIVE_PRIMARY_SHARDS | Number of Primary Shards
| ELASTIC_ACTIVE_SHARDS | Number of Active Shards
| ELASTIC_RELOCATING_SHARDS | Number of Relocationg Shards
| ELASTIC_INITIAZING_SHARDS | Number of Initiliazing Shards
| ELASTIC_UNASSIGNED_SHARDS | Number of Unassigned Shards