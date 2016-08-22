{application,test,  
  [{description,"Test application"},  
    {vsn,"1.0.0"},  
    {modules,[test_app,test_handler,test_server,test_sup]},  
    {registered,[test_app]},  
    {mod,{test_app,[]}},  
    {env,[]},  
    {applications,[kernel,stdlib]}
  ]
}.  
