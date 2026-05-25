## ----setup, include=FALSE-----------------------------------------------------
knitr::knit_hooks$set(purl = knitr::hook_purl)
knitr::opts_chunk$set(echo = TRUE, eval = TRUE)
library(JuliaCall)
julia_setup()


## using ICSTools
## 
## # Load dataset
## using Robustbase
## X=wood[:,1:5];

## ## Instantiate ICSModel object with all default parameters
## ics = ICSModel();
## show(ics)

## ## Alternative instantiations:
## 
## ## 1. With values for S1 and S2
## ics1 = ICSModel(S1=cov2, S2=cov4);
## 
## ## 2. With arguments for S2
## ics2 = ICSModel(S1=cov2, S2=covW, S2_args=Dict{Symbol, Any}(:alpha=>1, :cf=>2));
## 
## ## 3. With algorithm
## ics3 = ICSModel(S1=cov2, S2=covW, algorithm="standard");

## ## Fit the ICS model - equivalent of the function ICS-S3() from the R package ICS
## ICSTools.fit!(ics, X);
## show(ics)

## ## Predict using the fitted model
## scores=predict(ics, X);
## scores

## ## scree plot and 2-dimensional component plot
## using Plots
## gr()
## scree_plot(ics)
## component_plot2(ics)                # by default the first two components
## component_plot2(ics, select=[3,4])  # select components 3 and 4

## using DataFrames
## using GLMakie
## using PairPlots
## ss = DataFrame(scores, ["IC$i" for i=1:size(scores,2)]);
## fig = pairplot(ss, fullgrid=true);
## 
## fig = pairplot(
##     ss => (PairPlots.Scatter(markersize=10, color=:blue),
##           PairPlots.MarginDensity(color=:red)),
##           fullgrid=true
## )
## 
## save("wood-scores.png", fig)

## ## Load the penguins data from R
## using DataFrames
## using RCall
## Robj = R"data('penguins', package='datasets'); x=penguins";
## 
## ## Copy the contents of an R object into a corresponding canonical Julia type
## penguins = rcopy(Robj)
## size(penguins)
## penguins = dropmissing(penguins); # drop the missing values
## size(penguins)
## X = penguins[:,3:6];              # select only the quantative variables

## ## Tabulate species by sex
## gdf = groupby(penguins, [:species, :sex]);
## tt = combine(gdf, nrow);
## show(IOContext(stdout, :limit=>false), MIME"text/plain"(), tt)

## using ICSTools
## ics = ICSModel(S1=tcov, S2=cov2);
## scores = fit_predict!(ics, X);
## 
## using Plots
## gr()
## scree_plot(ics)

## ## Convert the categorical arrays species and sex to string arrays
## using CategoricalArrays
## species = unwrap.(penguins.species);
## sex = unwrap.(penguins.sex);

## ## Convert the categorical arrays species and sex to string arrays
## component_plot2(ics, clusters=species)

## ## Convert the categorical arrays species and sex to string arrays
## component_plot2(ics, clusters=sex, select=[4])

## using DataFrames
## using GLMakie
## using PairPlots
## 
## ss = DataFrame(scores, ["IC$i" for i=1:size(scores,2)]);
## 
## fig=pairplot(ss[species .== "Adelie", :] =>
##              (PairPlots.Scatter(markersize=10),
##               PairPlots.MarginDensity()),
##             ss[species .== "Gentoo", :] =>
##              (PairPlots.Scatter(markersize=10),
##               PairPlots.MarginDensity()),
##             ss[species .== "Chinstrap", :] =>
##              (PairPlots.Scatter(markersize=10),
##               PairPlots.MarginDensity()),
##           fullgrid=true)

## fig=pairplot(ss[sex .== "female", :] =>
##              (PairPlots.Scatter(markersize=10),
##               PairPlots.MarginDensity()),
##             ss[sex .== "male", :] =>
##              (PairPlots.Scatter(markersize=10),
##               PairPlots.MarginDensity()),
##           fullgrid=true)

## ## Load the penguins data from R
## using DataFrames
## using RCall
## RObj = R"data('data_philips', package='cellWise'); x=data_philips";
## 
## ## Copy the contents of an R object into a corresponding canonical Julia type
## X = rcopy(RObj)
## size(X)
## 
## ## Define the clusters
## clusters = repeat(["Group1"], outer=size(X, 1))
## clusters[1:100] .= "Group2"
## clusters[491:565] .= "Group3"
## 
## ## We will use these to validate the k-means
## true_labels = fill(1, size(X, 1))
## true_labels[1:100] .= 2
## true_labels[491:565] .= 3

## using ICSTools
## ics = ICSModel(S1=mcd_raw, S2=cov2);
## scores = fit_predict!(ics, X);
## 
## using Plots
## gr()
## scree_plot(ics)

## component_plot2(ics, clusters=clusters)

## using DataFrames
## using GLMakie
## using PairPlots
## 
## ss = DataFrame(scores[:,[1, 2, 3, 7, 8, 9]], ["IC$i" for i=[1, 2, 3, 7, 8, 9]]);
## ss_raw = DataFrame(X[:,[1, 2, 3, 7, 8, 9]], ["X$i" for i=[1, 2, 3, 7, 8, 9]]);
## 
## fig=pairplot(ss[clusters .== "Group1", :] =>
##              (PairPlots.Scatter(markersize=10),
##               PairPlots.MarginDensity()),
##             ss[clusters .== "Group2", :] =>
##              (PairPlots.Scatter(markersize=10),
##               PairPlots.MarginDensity()),
##             ss[clusters .== "Group3", :] =>
##              (PairPlots.Scatter(markersize=10),
##               PairPlots.MarginDensity()),
##           fullgrid=true)
## 

## fig_raw=pairplot(ss_raw[clusters .== "Group1", :] =>
##              (PairPlots.Scatter(markersize=10),
##               PairPlots.MarginDensity()),
##             ss_raw[clusters .== "Group2", :] =>
##              (PairPlots.Scatter(markersize=10),
##               PairPlots.MarginDensity()),
##             ss_raw[clusters .== "Group3", :] =>
##              (PairPlots.Scatter(markersize=10),
##               PairPlots.MarginDensity()),
##           fullgrid=true)

## using MultivariateStats
## Xtr=Matrix(X)'
## M = fit(PCA, Xtr; maxoutdim=9)
## Ytr = MultivariateStats.predict(M, Xtr)'
## ss_pca = DataFrame(Ytr[:,[1, 2, 3, 5, 6, 7]], ["PC$i" for i=[1, 2, 3, 5, 6, 7]]);
## 
## fig_pca=pairplot(ss_pca[clusters .== "Group1", :] =>
##              (PairPlots.Scatter(markersize=10),
##               PairPlots.MarginDensity()),
##             ss_pca[clusters .== "Group2", :] =>
##              (PairPlots.Scatter(markersize=10),
##               PairPlots.MarginDensity()),
##             ss_pca[clusters .== "Group3", :] =>
##              (PairPlots.Scatter(markersize=10),
##               PairPlots.MarginDensity()),
##           fullgrid=true)

## ## 1. Do k-means on the raw data
## using Clustering
## result = kmeans(X', 3);
## ri, ari_raw = randindex(result.assignments, true_labels);
## ari_raw
## 
## ## Do k-means on the first 3 ICs
## using Clustering
## Y=scores[:,1:3];
## result_ICS = kmeans(Y', 3);
## ri, ari_ICS = randindex(result_ICS.assignments, true_labels);
## ari_ICS
## 
## ##  Do k-means on the first 3 PCs
## using MultivariateStats
## using Clustering
## Xtr=Matrix(X)';
## M = fit(PCA, Xtr; maxoutdim=9);
## Ytr = MultivariateStats.predict(M, Xtr)';
## Ytr3 = Ytr[:,1:3]';
## result_PCA = kmeans(Ytr3, 3);
## ri, ari_PCA = randindex(result_PCA.assignments, true_labels);
## ari_PCA

## println("ari_raw:\t\t", ari_raw, "\nari_PCA_3:\t", ari_PCA, "\nari_ICS_3:\t", ari_ICS)
