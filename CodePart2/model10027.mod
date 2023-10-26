# This is the model file
#-----------------------

# variables
set Lines = { "BASIC", "SHOWOFF", "LUXURIOUS", "NEWBASIC", "NEWSHOWOFF" } ordered;
set Cars = { "BASIC", "SHOWOFF", "LUXURIOUS" } ordered;

# parameters
param capacity{ j in Lines};
param cost{ j in Lines};
param profit{ i in Cars, j in Lines};
param demand{ i in Cars};
param conversionRates{ z in Cars, i in Cars};

# decision variables
var n{i in Cars, j in Lines} >=0 integer;
var w{j in Lines} binary;
var inc >=0;
var exp >=0;
var d{i in Cars} >=0 integer;

# maximize function
maximize totalProfit: inc - exp;

# restrictions
subject to income: inc = sum{ i in Cars, j in Lines} profit[i, j] * n[i,j];
subject to expenses: exp = sum{ j in Lines} cost[j] * w[j];
subject to upgradeBasicLine: w["BASIC"] + w["NEWBASIC"] <= 1;
subject to upgradeShowOffLine: w["SHOWOFF"] + w["NEWSHOWOFF"] <= 1;
subject to productionNumber{j in Lines}: (sum{i in Cars} n[i,j]) <= capacity[j] * w[j];
subject to unsatisfiedCustomers{i in Cars}: d[i] = demand[i] +( sum{z in Cars} conversionRates[z,i] * d[z])- (sum{j in Lines} n[i,j]);

