* Eksempel ifm. SAS Fans Programmerings Netværksmøde, 27-11-2020.;

proc sql noprint;
   select count(distinct type)
      into :n
      from sashelp.cars;
   select distinct type
      into :type1 - :type%left(&n)
      from sashelp.cars;
quit;

%macro type;
   %macro farvertak; %mend farvertak; /* Tilføj en tom makro i en anden makro, for at få farverne tilbage. */

   %do i=1 %to &n;
      data &&type&i (drop = type);
         set sashelp.cars;
         if type = "&&type&i";
      run;
   %end;
%mend type;

%type;
