# Project: Labradoodle or Fried Chicken? In Black and White. 
![image](figs/poodleKFC.jpg)

### [Full Project Description](doc/project3_desc.md)

Term: Spring 2017

+ Team 1
+ Team members
	+ Nie, Kexin kn2403@columbia.edu    
	+ Schiltz, Marie ms5293@columbia.edu    
	+ Wei, Jihan jw3447@columbia.edu     
	+ Zhu, Chenyun cz2434@columbia.edu     
	+ Zhu, He hz2429@columbia.edu         

+ Project summary: In this project, we created a classification engine for grayscale images of poodles versus images of fried chickens. We set our baseline model using SIFT features and gradient boosting machine(GBM) classifier. Besides the SIFT features, we also tried GIST descriptor. In terms of classifiers, we considered SVM(linear and non-linear), Random Forest, XGBoost and GBM. After model evaluation and comparison, the final advanced model we selected is using GIST descriptor and XGBoost classifier. We increased the accuracy by 17.7% and only took 0.41% of running time as in baseline model.


+ The root code of our project is available at [Main.Rmd](doc/main.Rmd)

**Contribution statement**: ([default](doc/a_note_on_contributions.md)) All team members contributed equally in all stages of this project. All team members approve our work presented in this GitHub repository including this contributions statement. 
  
  Part of the project each member is responsible for:
   
     Baseline Model: Marie Schiltz
  
     SVM & Main File Construction: Jihan Wei
  
     Random Forest & Project Presentation: Chenyun Zhu
     
     XgBoost & Features: He Zhu
  
     Features Extraction: Kexin Nie

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
