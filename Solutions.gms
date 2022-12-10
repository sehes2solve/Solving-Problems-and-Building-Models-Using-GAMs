set Ti  /1990 * 2000/
    MC /MC1  * MC10/;

$ONTEXT
set Illegale1 / A15BC*A10BC /
    Illegale2 / A1X1* A9X9 /
    Illegale3 / A1* B9 / ;
$OFFTEXT

set HHarea Household Area /UrbanHouseholdArea , RuralHouseholdArea/
    Sector                /GovernmentSector , PrivateSector/;

table LaborTable(HHarea , Sector) In Thousands
      
                            GovernmentSector    PrivateSector
    UrbanHouseholdArea                   400             1000
    RuralHouseholdArea                   350              700 ;
    
parameter LaborParameter(HHarea , Sector) In Thousands
   /UrbanHouseholdArea.GovernmentSector     400
    UrbanHouseholdArea.PrivateSector       1000
    RuralHouseholdArea.GovernmentSector     350
    RuralHouseholdArea.PrivateSector        700/;

set tii        time                  /2000 * 2005/
    StatIndi Statistical Indicator /Mean, Median, Variance, Maximum/;

table StatAtT(StatIndi , tii) Statistical Indicator Value At Time
      
                2000    2001    2002    2003    2004    2005
    Mean         500     600     700     800     900    1000
    Median       300     320     340     380     400     500
    Variance      10      12      16      18      20      20
    Maximum      800     900    1000    1200    1400    1800 ;

set i /1 * 3/
    j /a * c/;
alias(i,tiii);
alias(j,m);

scalar COUNT, EMP, OUTPUT;

parameter L(tiii)     /1 = 2, 2 = 4, 3 = 6/,
          MT(tiii)    /1 = 2, 2 = 4, 3 = 6/,
          INPUT(tiii) /1 = 2, 2 = 4, 3 = 6/,
          SHARE(tiii) /1 = 2, 2 = 4, 3 = 6/,
          TOTC(m);

table C(i , j)
      
        a   b   c    
    1   2   3   4
    2   3   4   5
    3   4   5   6 ;
table A(i , j)
      
        a   b   c
    1   2   3   4
    2   3   4   5
    3   4   5   6;

    
TOTC(m) = sum(i,C(i,m));
COUNT   = sum((i,j),A(i,j));
EMP     = sum(tiii,L(tiii) * MT(tiii));
OUTPUT  = prod(i,INPUT(i) ** SHARE(i));

Set t / 2000 * 2005 /;

Parameter pop(t)
          / 2000 90 /
          Growth(t)
          / 2000   2,
            2001 2.1,
            2002 2.2,
            2003 2.3,
            2004 2.4,
            2005 2.5 / ;

loop(t,pop(t+1) = pop(t) + pop(t) * (growth(t)/100));

scalar f /1/;

parameter p(i) /1 1,2 2,3 3/;

p(i) $(f le 0) = -1;
p(i) $((f gt 0) and (f lt 1)) = p(i) ** 2;
p(i) $(f gt 1) = p(i) ** 3; 