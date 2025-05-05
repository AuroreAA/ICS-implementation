# Invariant Coordinate Selection (ICS) implementations

This repository is an attempt to present the latest advancements of the different
implementations of ICS in different programming languages: R, python and Julia.


## About ICS

Invariant Coordinate Selection (ICS) is a powerful unsupervised multivariate method designed to identify the structure of multivariate datasets on a subspace. It relies on the joint diagonalization of two scatter matrices and is particularly relevant as a dimension reduction tool prior to clustering or outlier detection.




## Implementations

### R packages


- [ICS](https://cran.r-project.org/web/packages/ICS/index.html) - Nordhausen, K., Alfons, A., Archimbaud, A., Oja, H., Ruiz-Gazen, A. and Tyler, D. E. (2023). R package version 1.4-2.

- [ICSNP](https://CRAN.R-project.org/package=ICSNP) -  Nordhausen K, Sirkia S, Oja H, Tyler D (2023). ICSNP: Tools for Multivariate Nonparametrics. R
  package version 1.1-2.

- [ICtest](https://CRAN.R-project.org/package=ICtest) - 
Nordhausen K, Oja H, Tyler D, Virta J (2022). ICtest: Estimating and Testing the Number of Interesting
  Components in Linear Dimension Reduction. R package version 0.3-5.

- [ICSClust](https://cran.r-project.org/web/packages/ICSClust/index.html) - 
Archimbaud, A., Alfons, A., Nordhausen, K., and Ruiz-Gazen, A. (2023a). ICSClust: Tandem Clustering with Invariant Coordinate Selection. R package version 0.1.0.


- [ICSOutlier](https://cran.r-project.org/web/packages/ICSOutlier/index.html) - 
 Archimbaud A, Nordhausen K, Ruiz-Gazen A (2016). ICSOutlier: Outlier Detection Using Invariant Coordinate Selection.
 R package version 0.4-0. 



- [ICSShiny](https://CRAN.R-project.org/package=ICSShiny) - 
Archimbaud A, May J, Nordhausen K, Ruiz-Gazen A (2017). ICSShiny: ICS via a Shiny Application. R package
version 0.6.

### Python package

- [ICSpyLab](https://icspylab.readthedocs.io/en/latest/) - Becquart, C., Abdelsameia, A. (2025). ICSpyLab: . Python package version 0.1.0


### Julia code

- [SimultaneousDiagonalisation](https://github.com/CClaassen/SimultaneousDiagonalisation.jl) - Claassen, C. (2023). Generalising invariant coordinate selection to a non-linear dimensionality reduction method. [Master’s thesis.](http://hdl.handle.net/2105/67214)



## References with replication files

- Archimbaud, A. (2024). [Generalized implementation of invariant coordinate selection with positive semi-definite scatter matrices](https://arxiv.org/abs/2409.02258) arXiv preprint arXiv:2409.02258. [Replication files - R ](https://github.com/AuroreAA/ICS_PSD_Replication)


- Becquart, C., Archimbaud, A., Ruiz-Gazen, A., Prilć, L., and Nordhausen, K. (2024).
[Invariant Coordinate Selection and Fisher discriminant subspace beyond the case of two groups](https://arxiv.org/abs/2409.17631) arXiv preprint arXiv:2409.17631.
 [Replication files - R and python](https://github.com/AuroreAA/ICS_FDS-Replication)
 
 - Alfons, A., Archimbaud, A., Nordhausen, K., and Ruiz-Gazen, A. (2024). [Tandem clustering with invariant coordinate selection.](https://doi.org/10.1016/j.ecosta.2024.03.002) Econometrics and Statistics, ISSN 2452-3062.
 [Replication files - R](https://github.com/aalfons/TandemICS-Replication)
 
- Archimbaud, A., Drmac, Z., Nordhausen, K., Radojicic, U. and Ruiz-Gazen, A. (2023). [Numerical Considerations and a New Implementation for Invariant Coordinate Selection.](https://doi.org/10.1137/22M1498759) SIAM Journal on Mathematics of Data Science (SIMODS), Vol.5(1):97–121. [Replication files - R](https://github.com/AuroreAA/NCICS)

- Ruiz-Gazen, A., Thomas-Agnan, C., Laurent, T., and Mondon, C. (2022). [Detecting outliers in compositional data using Invariant Coordinate Selection.](https://doi.org/10.1007/978-3-031-22687-8_10) In Robust and Multivariate Statistical Methods: Festschrift in Honor of David E. Tyler (pp. 197-224). Cham: Springer International Publishing. [Replication files - R](https://github.com/tibo31/ics_coda)


- Archimbaud, A., Nordhausen, K., and Ruiz-Gazen, A. (2018). [ICSOutlier: Unsupervised outlier detection for low-dimensional contamination structure.](https://doi.org/10.32614/RJ-2018-034) The R Journal, 10(1):234–250. [Replication files - R](https://journal.r-project.org/archive/2018/RJ-2018-034/RJ-2018-034.zip)

- Nordhausen K., Oja H., and Tyler D.E. (2008). [Tools for Exploring Multivariate Data: The Package ICS.](https://doi.org/10.18637/jss.v028.i06) Journal of Statistical Software, 28(6), 1-31. 
[Replication files - R](https://www.jstatsoft.org/index.php/jss/article/view/v028i06/1827)





## References with code available upon request

- Archimbaud, A., Boulfani, F., Gendre, X., Nordhausen, K., Ruiz-Gazen, A., and Virta, J. (2025). [ICS for multivariate functional anomaly detection with applications to predictive maintenance and quality control](https://doi.org/10.1016/j.ecosta.2022.03.003) Econometrics
and Statistics, 33:282–303.

- Archimbaud, A., Nordhausen, K., and Ruiz-Gazen, A. (2018). [ICS for multivariate outlier detection with application to quality control](https://doi.org/10.1016/j.csda.2018.06.011) Computational Statistics & Data Analysis, 128:184–199.


## Additional references

- Nordhausen, K. and Ruiz-Gazen, A. (2022). [On the Usage of Joint Diagonalization in Multivariate Statistics.](https://doi.org/10.1016/j.jmva.2021.104844)  Journal of Multivariate Analysis, 188, 104844.

- Fischer, D., Nordhausen, K. and Oja, H. (2020). [On Linear Dimension Reduction Based on Diagonalization of Scatter Matrices for Bioinformatics Downstream Analyses.](https://doi.org/10.1016/j.heliyon.2020.e05732) Heliyon, 6, e05732.

- Fischer, D., Honkatukia, M., Tuiskula-Haavisto, M., Nordhausen, K., Cavero, D., Preisinger, R. and Vilkki, J. (2017). [Subgroup Detection in Genotype Data Using Invariant Coordinate Selection.](https://doi.org/10.1186/s12859-017-1589-9) BMC Bioinformatics, 18, 173.

- Liski, E., Nordhausen, K. and Oja, H. (2014). Supervised Invariant Coordinate Selection. Statistics: A Journal of Theoretical and Applied Statistics, 48, 711-731.

- Ilmonen, P., Oja, H. and Serfling, R. (2012). On invariant coordinate system (ICS) functionals. International Statistical Review, 80, 93–110.

- Ilmonen, P., Nevalainen, J. and Oja, H. (2010). Characteristics of multivariate distributions and the invariant coordinate system. Statistics & Probability Letters, 80, no. 23, 1844–1853.

- Tyler, D. E., Critchley, F., Dümbgen, L. and Oja, H. (2009). [Invariant co-ordinate selection.](https://doi:10.1111/j.1467-9868.2009.00706.x.) Journal of the Royal Statistical Society:
Series B (Statistical Methodology), 71, no. 3, 549–592.

- Caussinus, H., Fekri, M., Hakam, S. A. Ruiz-Gazen, A. (2003). A monitoring display of multivariate outliers. Computational Statistics & Data Analysis, 44, no. 1, 237–252.

- Caussinus, H. and Ruiz-Gazen, A. (1993). Projection pursuit and generalized principal component analysis. New Directions in Statistical Data Analysis and Robustness., S. Morgenthaler, E. Ronchetti, and W. A. Stahel, Eds., Springer, Monte Verita, Proceedings of the Centro Stefano Franciscini Ascona Series. 

- Caussinus, H. and Ruiz, A. (1990). Interesting projections of multidimensional data by means of generalized principal component analyses. Compstat, K. Momirović and V. Mildner, Eds., Physica-Verlag HD, Heidelberg, 121–126.



## Contributors
Aurore Archimbaud, Colombe Becquart, Andreas Alfons,  Klaus Nordhausen, Anne M. Ruiz

## Contact

If you would like to add your work to this repository or contribute to developing new advancements, please open an issue.
