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
  
**for terminals unable to handle Japanese characters**     
```
set JD1=##class(Util.JDate).LogicalToDisplay(70000,1)
set JD2=##class(Util.JDate).LogicalToDisplay(70000,2)

zzdump JD1
0000: 52 31 34 30 38 32 36                                    R140826
zzdump JD2
0000: 4EE4 548C 0031 0034 5E74 0030 0038 6708                 令和14年08月
0008: 0032 0036 65E5                                          26日

write ##class(Util.JDate).DisplayToLogical(JD2,2)
70000
write ##class(Util.JDate).DisplayToLogical(JD1,1)
70000
```
### Prereqisites for Docker
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation 
Clone/git pull the repo into any local directory
```
git clone https://github.com/intersystems-community/JDate.git    
```
Run the IRIS container with your project: 
```
docker-compose up -d --build
```
## How to Test it
Connect to the container using [webterminal](http://localhost:52773/terminal/?ns=USER) or    
start an IRIS session in docker
```
   docker-compose exec iris iris session iris
```
or use    
[Demo Server SMP](https://jdate.community.intersystems.com/csp/sys/UtilHome.csp)   
[Demo Server WebTerminal](https://jdate.community.intersystems.com/terminal/)    **    

**Code Quality**   
<img width="85%" src="../../blob/master/CodeQuality.JPEG?raw=true">

