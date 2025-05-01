## ----setup, include=FALSE-------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, eval = FALSE)


## ----libs, message = FALSE------------------------------------------------------
library(ICS)
library(ICSOutlier)
library(ICSShiny)
library(ICSClust)


## ----ICS------------------------------------------------------------------------
out_ICS <- try(ICS(iris))
X <- iris[,-5]
out_ICS <- ICS(X)
out_ICS


## ----ICS_methods----------------------------------------------------------------
summary(out_ICS)
plot(out_ICS)
coef(out_ICS)
head(fitted(out_ICS))


## ----ICS_attributes-------------------------------------------------------------
# Generalized eigenvalues
out_ICS$gen_kurtosis
gen_kurtosis(out_ICS)
screeplot(out_ICS, type = "bar")
screeplot(out_ICS, type = "line")
select_plot(out_ICS)

# Extract the component OR scores
head(out_ICS$scores)
head(components(out_ICS))
head(components(out_ICS, select = 1:2))


## ----scatters-------------------------------------------------------------------
# By default - COV-COV4
out_ICS <- ICS(X, S1 = ICS_cov, S2 = ICS_cov4)
out_ICS
component_plot(out_ICS, clusters = iris$Species)

# MCD0.50-COV
out_ICS_mcd <- ICS(X, S1 = ICS_mcd_raw, S2 = ICS_cov)
out_ICS_mcd
component_plot(out_ICS_mcd, clusters = iris$Species)

# MCD0.25-COV
out_ICS_mcd <- ICS(X, S1 = ICS_mcd_raw, S2 = ICS_cov, S1_args = list(alpha = 0.25))
out_ICS_mcd
component_plot(out_ICS_mcd, clusters = iris$Species)



## ----algo-----------------------------------------------------------------------
out_ICS_std <- ICS(X, algorithm = "standard")
out_ICS_std
out_ICS_whiten <- ICS(X, algorithm = "whiten")
out_ICS_whiten
out_ICS_QR <- ICS(X, algorithm = "QR")
out_ICS_QR


## ----rank_deficiencies----------------------------------------------------------
# example of numerical inaccuracies
X_rank_deficient <- sweep(X, 2, c(10^(-12), 10^(-3), 1, 10^12), "*")

out_ICS_std <- try(ICS(X_rank_deficient, algorithm = "standard"))
out_ICS_whiten <- ICS(X_rank_deficient, algorithm = "whiten")
out_ICS_whiten
out_ICS_QR <- ICS(X_rank_deficient, algorithm = "QR")
out_ICS_QR


## ----select_comp----------------------------------------------------------------
# run ICS
out <- ICS(X, S1 = ICS_tcov, S2 = ICS_cov)
component_plot(out, clusters = iris$Species)

# selection of components
select_plot(out)

# med criterium
out_med <- med_crit(out, nb_select = 1)
select_plot(out_med)
select_plot(out_med, screeplot = FALSE)

# var criterium
out_var <- var_crit(out, nb_select = 1)
select_plot(out_var)

# normal criterium
out_normal <- normal_crit(out, level = 0.05, test = "anscombe.test",
                          max_select = 3)
out_normal
select_plot(out_normal)

# discriminatory criterium
out_disc <- discriminatory_crit(out, clusters = iris$Species, select_only = FALSE)
select_plot(out_disc)
select_plot(out_disc, screeplot = FALSE)

out_disc <- discriminatory_crit(out, clusters = iris$Species, select_only = FALSE,
                                nb_select = 1)
select_plot(out_disc)
select_plot(out_disc, screeplot = FALSE)



## ----clustering-----------------------------------------------------------------
# indicating the number of components to retain for the dimension reduction
# step as well as the number of clusters searched for.
# The default criterion is "med_crit" and clustering method is "kmeans_clust".
out <- ICSClust(X, ICS_args = list(S1 = ICS_tcov, S2 = ICS_cov), 
                nb_select = 1, nb_clusters = 3)
out
summary(out)
plot(out)
table(iris$Species, out$clusters)


## ----clustering_custom----------------------------------------------------------
# changing the scatter pair to consider in ICS
out <- ICSClust(X, nb_select = 1, nb_clusters = 3,
                ICS_args = list(S1 = ICS_tcov, S2 = ICS_cov))
summary(out)
plot(out)
table(iris$Species, out$clusters)

# changing the criterion for choosing the invariant coordinates
out <- ICSClust(X, nb_clusters = 3, criterion = "normal_crit",
                ICS_crit_args = list(level = 0.1, test = "anscombe.test", max_select = NULL))
summary(out)
plot(out)
component_plot(out$ICS_out, clusters = factor(out$clusters))


# changing the clustering method
out <- ICSClust(X, nb_clusters = 3, method  = "tkmeans_clust", 
                clustering_args = list(alpha = 0.1))
summary(out)
plot(out)



## ----HTP------------------------------------------------------------------------
data(HTP)
outliers <- c(581, 619)
boxplot(HTP)


## ----outlier_detection----------------------------------------------------------
icsOutlier <- ICS_outlier(HTP, method = "norm_test", test = "agostino.test",
                            n_eig = 10, level_test = 0.05, adjust = TRUE,
                            level_dist = 0.025, n_dist = 10)

plot(icsOutlier)
text(outliers, icsOutlier$ics_distances[outliers], outliers, pos = 2, cex = 0.9, col = 2)

# For using several cores and for using a scatter function from a different package
# Using the parallel package to detect automatically the number of cores
library(parallel)

# For demo purpose only small m value, should select the first seven components
# icsOutlier <- ICS_outlier(HTP, S1 = ICS_mcd_rwt, S2 = ICS_cov,
#                             S1_args = list(location = TRUE, alpha = 0.75),
#                             n_eig = 10, level_test = 0.05, adjust = TRUE,
#                             level_dist = 0.025, n_dist = 10,
#                             n_cores =  detectCores()-1, iseed = 123,
#                             pkg = c("ICSOutlier", "ICSClust"))
# icsOutlier
# plot(icsOutlier)






## ----colli----------------------------------------------------------------------
# Import data
data(HTP3)
X <- as.matrix(HTP3)
rownames(X) <- rownames(HTP3)
ind_outlier <- 32

# Run ICS
icsOutlier <- try(ICS_outlier(X, level_test = 0.025, adjust = TRUE,
                            level_dist = 0.025, n_dist = 10))
icsOutlier <- ICS_outlier(X, ICS_algorithm = "QR",
                          level_test = 0.05, adjust = TRUE,
                            level_dist = 0.001, n_dist = 10)
print(icsOutlier)
plot(icsOutlier)
text(outliers, icsOutlier$ics_distances[outliers], outliers, pos = 2, cex = 0.9, col = 2)


## ----shiny----------------------------------------------------------------------
# library(ICSShiny)
# ICSShiny(iris)


## ----mixture--------------------------------------------------------------------
X <- mixture_sim(pct_clusters = c(0.6, 0.4), n = 500, p = 5, delta = 10)


## ----plot-----------------------------------------------------------------------
component_plot(X, clusters = X$cluster)


