# dsjParamSearch
This tool can be used to locate jobs which have any given parameter in the jobs properties. This applies to parameters that are not in a parameter set. 

To Do
High Priority:
  Use multiple threads so that the job.parameters cache file can be updated and allow the window to be moved/manipulated instead of locked. This is currently an issue as the winframe itself is running on the same thread that the update task gets executed on. I am not yet skilled enough to implement this change but and researching methods to make this work and allow data exchange between the threads.
  
Medium Priority:
  Utilize the DataStage SDK to list which individual stages in the jobs are actually using the parameter searched for.
