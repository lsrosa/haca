# Disclaimenr

This repo contains code obtained from [F. Zhou's webpage](http://www.f-zhou.com/tc_more_results.html)and is intendend for research purposes only.

Futher files, code, and tests are under GPLv3 license.

<HACA motion segmentation method and tests.>
    Copyright (C) 2022 - Leandro de Souza Rosa <l.desouzarosa@tudelft.nl>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>


# Original ACA README File Contents:

## Introduction

    This page contains software and instructions for Aligned Cluster Analysis (ACA) [1] and its hierarchical version (HACA) [2]. All the functions have been written and documented in Matlab format. We additionally provide C++ implementations of some dynamic programming routines which involve many loops and are notoriously slow in Matlab.

- [1] F. Zhou, F. de la Torre, and J. K. Hodgins, "Aligned cluster analysis for temporal segmentation of human motion," in International Conference on Automatic Face and Gesture Recognition (FG), 2008.
- [2] F. Zhou, F. de la Torre, and J. K. Hodgins, "Hierarchical Aligned cluster analysis for temporal segmentation of human motion," submitted to IEEE Transactions on Pattern Analysis & Machine Intelligence (PAMI), 2010.

## Installation

    1. unzip aca.zip to your folder;
    2. Run make.m to compile all C++ files;
    3. Run addPath.m to add sub-directories into the path of Matlab.
    4. Run demoXXX file.

## Instructions

    - The package of aca.zip contains three folders, two setup files and three demo files. ./data: This folder contains motion capture data.
    - ./src: This folder contains the main implmentation of ACA and HACA.
    - ./lib: This folder contains some necessary library functions.
    - ./make.m: Matlab makefile for C++ code.
    - ./addPath.m: Adds the sub-directories into the path of Matlab.
    - ./demoToy.m: Segmentation of a synthetic sequence by ACA.
    - ./demoToyH.m: Segmentation of a synthetic sequence by HACA.
    - ./demoMocap.m: Segmentation of motion capture sequence by ACA and HACA. By using this function, you can obtain results similar to those shown here.

## Other Tips

- For each C++ code, we provide its corresponding Matlab version. For instance, you can use "acaFordSlow.m" instead of "acaFord.cpp". They have the same interface in both input and output. The C++ code is faster to obtain result while the Matlab version is easier to understand and debug.
- For the DTAK algorithm and ACA algorithm, we also provide a version in which each searching step in dynamic programming can be locally constrained. Although we didn't use this feature in our paper, we found it is useful to obtain a robust alignment and to speedup the algorithm. Please refer to [3] [4] for more details on constraints in Dynamic Time Warping (DTW).
- [3] S. Salvador and P. Chan, "Toward accurate Dynamic Time Warping in linear time and space," in Intelligent Data Analysis, 2007, pp. 561-580.
- [4] L. Rabiner and B.-H. Juang, "Fundamentals of speech recognition," Prentice Hall, 1993.


## Copyright

    This software is free for use in research projects. If you publish results obtained using this software, please use this citation.
@inproceedings{Zhou_2008_6155,
   author    = {Feng Zhou and Fernando De la Torre and Jessica K. Hodgins},
   title     = {Aligned Cluster Analysis for Temporal Segmentation of Human Motion},
   booktitle = {IEEE Conference on Automatic Face and Gestures Recognition (FG)},
   month     = {September},
   year      = {2008},
} 

If you have any question, please feel free to contact Feng Zhou (zhfe99@gmail.com).
