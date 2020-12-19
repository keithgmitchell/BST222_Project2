
* logrank test for two or more groups;
proc import datafile="/folders/myfolders/Project2/simulated_data2.csv" 
out=sim dbms=csv replace;
datarow=2;
getnames=yes;
guessingrows=100;
run;



* Global test; 
proc lifetest data=sim plots=survival;*(atrisk=0 to 2500 by 500);  
time time*censor(1); 
strata haz_cat/test=(logrank TARONE PETO MODPETO  
FLEMING(0,1)    ); 
run;


proc phreg data = sim plots=survival;
  class haz_cat;
  model time*censor(1)=haz_cat;
run;

