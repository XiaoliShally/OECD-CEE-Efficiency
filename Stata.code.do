xtset id year   
xtdes                                 
xtsum y x0 x1 x2 x3 x4 x5 x6 id year    
                 
xttobit y x0 x1 x2 x3 x4 x5 x6, ll(0)  nolog   

margins, dydx(*) predict(xb)

margins, dydx(*) predict(ystar(0, .))

margins, dydx(*) predict(e(0, .))

margins, dydx(*) predict(pr(0, .))

estimates store RETOBITll1



 
pwcorr x0 x1 x2 x3 x4 x5 x6, sig 

reg y x0 x1 x2 x3 x4 x5 x6 //* VIF

vif


reg y x0 x1 x2 x3 x4 x5 x6, vce(robust)   //OLS


xttobit y x0 x1 x2 x3 x4 x5 x6, ll(0) vce(bootstrap, reps(1000) seed(12345))  //bootstrap


gen x2_sq = x2^2  
xttobit y x0 x1 x2 x2_sq x3 x4 x5 x6, ll(0)
xttobit y x0 x1 x2 x2_sq x3 x4 x5 x6, ll(0) vce(bootstrap, reps(1000) seed(12345))  //bootstrap



graph box y, name(box_y, replace) 
graph box lnx3, name(box_lnx3, replace) 



reg y x0 x1 x2 x3 x4 x5 x6 
predict d1, cooksd  
count if d1 > (4/455) 
lvr2plot 
winsor2 y x0 x1 x2 x3 x4 x5 x6, replace cuts(1 99) 
xttobit y x0 x1 x2 x3 x4 x5 x6, ll(0) vce(bootstrap, reps(1000) seed(123)) 

xttobit y x0 x1 x2 x3 x4 x5, ll(0)  nolog   
xttobit y x0 x1 x2 x3 x4 x5, ll(0) vce(bootstrap, reps(1000) seed(12345))  