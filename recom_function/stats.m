thirty_districts = load("district_map01.mat");
csvwrite('prelim_stats.csv', thirty_districts.M);