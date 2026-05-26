## ----setup, include=FALSE-----------------------------------------------------
knitr::knit_hooks$set(purl = knitr::hook_purl)
knitr::opts_chunk$set(echo = TRUE, eval = TRUE)
library(JuliaCall)
julia_setup()


## import Pkg;
## Pkg.add("Robustbase"); using Robustbase
## Pkg.add("ICSTools"); using ICSTools
## Pkg.add("Plots"); using Plots
## Pkg.add("DataFrames"); using DataFrames
## Pkg.add("GLMakie"); using GLMakie       # for pairplots() and related
## Pkg.add("PairPlots"); using PairPlots   # for pairplots() and related
## Pkg.add("RCall"); using RCall           # To access R data sets; to perform tests
## Pkg.add("Clustering"); using Clustering # for kmeans() and randindex()
## Pkg.add("Test"); using Testing          # for testing against R
## Pkg.add("BenchmarkTools"); using BenchmarkTools # for benchmarking scatter functions
## Pkg.add("Random");Random                # for testing and benchmarking

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
## save("images/wood-scores.png", fig)

## 
## ## This is workaround for the errors in the show function for scatter
## ##in the current version of ICSTools
## 
## using ICSTools
## 
## function Base.show(io::IO, mime::MIME"text/plain", obj::ICSTools.Scatter)
##     #   you can add IO options if you want
##     #multiline = get(io, :multiline, true)
##     #print_object(io, obj, multiline = multiline)
## 
##     println(io, "-> Scatter: " , obj.label)
## 
##     if !isnothing(obj.location)
##         println(io, "Location:")
##         println(IOContext(io, :compact=>true), obj.location)
##     end
## 
##     println(io)
##     println(io, "Scatter:")
##     Base.show(io, mime, obj.scatter)
## end

## using ICSTools
## 
## # Load dataset
## using Robustbase
## X=wood[:,1:5];
## 
## cov4(X)

## covW(X, alpha=2, cf=4)

## ics1 = ICSModel(S1=cov2, S2=covW, S2_args=Dict{Symbol, Any}(:alpha=>2, :cf=>4));
## 
## ics2 = ICSModel(S1=mcd_raw, S2=cov2, S1_args=Dict{Symbol, Any}(:nsamp=>1000, :alpha=>0.75));

## using DataFrames
## using RCall
## using Test
## 
## ## Load R libraries
## R"library(ICSOutlier)";
## R"library(ICSClust)";
## 
## cc=R"ICS_cov4($X, location='mean')";    # call cov4() in R
## ss=cov4(X);                             # call cov4() in Julia

## ## Compare the returned labels, locations and scatters
## @test(ss.label == rcopy(cc)[Symbol("label")])
## @test(isapprox(ss.location, rcopy(cc)[Symbol("location")]))
## @test(isapprox(ss.scatter, rcopy(cc)[Symbol("scatter")]))

## using BenchmarkTools
## using ICSTools
## using Random
## 
## X = rand(1000, 10);
## 
## bb1 = @benchmark tcov(X) samples=19;
## bb1
## 

## ## Load the penguins data from R
## using DataFrames
## using RCall
## Robj = R"data('penguins', package='datasets'); x=penguins";
## 
## ## Copy the contents of an R object into a corresponding canonical Julia type
## penguins = rcopy(Robj);
## size(penguins)
## penguins = dropmissing(penguins); # drop the missing values
## size(penguins)
## X = penguins[:,3:6];              # select only the quantitative variables

## ## Tabulate species by sex
## gdf = groupby(penguins, [:species, :sex]);
## tt = combine(gdf, nrow);
## show(IOContext(stdout, :limit=>false), MIME"text/plain"(), tt)

## using ICSTools
## ics = ICSModel(S1=tcov, S2=cov2);
## scores = fit_predict!(ics, X);

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
## save("images/penguins-plot-species.png", fig)

## fig=pairplot(ss[sex .== "female", :] =>
##              (PairPlots.Scatter(markersize=10),
##               PairPlots.MarginDensity()),
##             ss[sex .== "male", :] =>
##              (PairPlots.Scatter(markersize=10),
##               PairPlots.MarginDensity()),
##           fullgrid=true)
## save("images/penguins-plot-sex.png", fig)

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
## save("images/philips-pairs.png", fig)

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
## save("images/philips-raw.png", fig_raw)

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
## save("images/philips-pairs_pca.png", fig_pca)

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
