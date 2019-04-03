# JDate

Japanese Calendar Converter for InterSystems products

This tool helps to Convert a $horolog value to Japanese calendar format. Or vice versa.

### Installation:

Import and compile the files in the src directory to a given namespace.

### Examples:

```Write ##class(Util.JDate).LogicalToDisplay(70000,1)```

R140826


```Write ##class(Util.JDate).LogicalToDisplay(70000,2)```

令和14年08月26日


```Write ##class(Util.JDate).DisplayToLogical(“R140826”,1)```

70000
  
  
```Write ##class(Util.JDate).DisplayToLogical(“令和14年08月26日”,2)```

70000
  
  

