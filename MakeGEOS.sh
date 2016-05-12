#!/bin/bash
# Source profile
export INTEL_LICENSE_FILE=/usr/local/flexlm/server.lic
source /home/jhbelle/.profile

## ---------------------
## Name: MakeGEOS.sh
## Program version: ifort 15.0.3
## Dependencies: GEOS-CHEM source code (copy located at /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01 - altered from main git repo for project)
## Author: J.H. Belle
## Purpose: Record of GEOS-CHEM 10-1 compilations and run directories where compiled code has been placed. 
# This script was run on source code version 10-01, edited to correct issue with initial starting values for TIME and etc. in Physproc.F - 03/16/2016
# Script was rerun on source code version 10-01, edited to correct issue with molecular weights - 03/17/2016
# Script was rerun on source code version 10-01, set up production run directories for tropchem models - 03/24/2016
# GEOS-FP 2x2.5 tropchem executable was recompiled on 05/02/2016 with debug and bounds turned on to confirm source of too many decreases in YFAC error; GEOS5_0.5x0.666_CH_tropchem runs were added into the set and this executable was compiled on 05/02 as well.
# All GEOS-FP geos executables for production runs (tropchem 2x2.5, and 0.25x0.3125 NA/CH) were recompiled after changes to the source code to fix an issue with cloud convection specific to GEOS-FP simulations - 05/02/2016.
# hcox_finn_mod.F90 replaced with new version; hcox_tools_mod.F90 was added to HEMCO/Extensions - 05/09/2016 - recompiling 4x5 tropchem model for testing of emissions - Fail - No longer using FINN issue unfixed
# Alpha for washout of aerosol tracers was constrainted to be less than 1 in GeosCore/convection_mod.F - 05/10/2016 and source was recompiled for geosfp 2x25 tropchem for testing
## ---------------------

## ----
## Official benchmark run: used for testing
## ----

# Clean out any old executable files
#make realclean
# Compile geos-chem for official benchmark
#make -j4 MET=geosfp GRID=4x5 CHEM=benchmark UCX=yes
# Copy executable over to run directory (/liu_group/remotesensing1/Jess/RunDir4x5/geosfp_4x5_benchmark)
#cp /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01/bin/geos /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/RunDirTesting/geosfp_4x5_benchmark/


## ----
## 4x5 full chemistry run: Used for testing
## ---- 

# Clean out any old executable files
#make realclean
# Compile 4x5 full chemistry run
#make -j4 MET=geosfp GRID=4x5 CHEM=NOx_Ox_HC_Aer_Br
#make -j4 MET=geosfp GRID=4x5 CHEM=NOx_Ox_HC_Aer_Br DEBUG=yes BOUNDS=yes TRACEBACK=yes
#chmod 666 /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/RunDirTesting/FixMolWts/geosfp_4x5_tropchem
# Copy executable over to run directoy (/liu_group/remotesensing1/Jess/RunDir4x5/geosfp_4x5_tropchem)
#cp /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01/bin/geos /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/RunDirTesting/geosfp_4x5_tropchem
#cp /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01/bin/geos /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/RunDirTesting/FixMolWts/geosfp_4x5_tropchem
#cp /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01/bin/geos /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/RunDirTesting/FINNTesting/geosfp_4x5_tropchem

## ----
## 2x2.5 full chemistry run (geos-fp): Used for production runs and to generate boundary condition files for NA and CH nested runs
## ----

# Clean out any old executable files
make realclean
# Compile 2x2.5 full chemistry simulation using geos-fp
#make -j4 MET=geosfp GRID=2x25 CHEM=NOx_Ox_HC_Aer_Br
make -j4 MET=geosfp GRID=2x25 CHEM=NOx_Ox_HC_Aer_Br DEBUG=yes BOUNDS=yes
# Change permissions in run directory
#chmod 666 /liu_group/climatechange2/GCRunDirs/geosfp_2x25_tropchem/*
# Copy executable over to run directory
#cp /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01/bin/geos /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/RunDirTesting/geosfp_2x25_tropchem
#cp /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01/bin/geos /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/RunDirTesting/FixMolWts/geosfp_2x25_tropchem
#cp /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01/bin/geos /liu_group/climatechange2/GCRunDirs/geosfp_2x25_tropchem/geos_convfix

## ----
## 2x2.5 full chemistry run (geos-5): Used for production runs and to generate boundary condition files for NA and CH nested runs
## ----

# Clean out any old executable files
#make realclean
# Compile 2x2.5 full chemistry run using geos-5
#make -j4 MET=geos5 GRID=2x25 CHEM=NOx_Ox_HC_Aer_Br
# Change permissions in run directory
#chmod 666 /liu_group/climatechange2/GCRunDirs/geos5_2x25_tropchem/*
# Copy executable over to run directory
#cp /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01/bin/geos /liu_group/climatechange2/GCRunDirs/geos5_2x25_tropchem

## ----
## 0.5x0.666 NA full chemmistry run: Used for production runs
## ----

# Clean out any old executables
#make realclean
# Compile 0.5x0.666 NA GEOS-5 full chemistry
#make -j4 MET=geos5 GRID=05x0666 NEST=NA CHEM=NOx_Ox_HC_Aer_Br
# Change permissions in run directory
#chmod 666 /liu_group/climatechange2/GCRunDirs/geos5_05x0666_tropchem_na/*
# Copy executable over to run directory
#cp /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01/bin/geos /liu_group/climatechange2/GCRunDirs/geos5_05x0666_tropchem_na
# Make folder usable by other users
#chmod 777 /liu_group/climatechange2/GCRunDirs/geos5_05x0666_tropchem_na

## ----
## 0.5x0.666 CH tropchem run: Used for production runs
## ----

# Clean out old executables
#make realclean
# Compile 0.5x0.666 CH GEOS-5 full chemistry executable
#make -j4 MET=geos5 GRID=05x0666 NEST=CH CHEM=NOx_Ox_HC_Aer_Br
# Change permissions for files in run directory
#chmod 666 /liu_group/climatechange2/GCRunDirs/geos5_05x0666_tropchem_ch/*
# Copy executable over to run directory
#cp /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01/bin/geos /liu_group/climatechange2/GCRunDirs/geos5_05x0666_tropchem_ch
# Change folder permissions
#chmod 777 /liu_group/climatechange2/GCRunDirs/geos5_05x0666_tropchem_ch

## ----
## 0.25x0.3125 NA full chemistry run: Used for production runs
## ----

# Clean out any old executables
#make realclean
# Compile 0.25x0.333 NA GEOS-FP full chemistry
#make -j4 MET=geosfp GRID=025x03125 NEST=NA CHEM=NOx_Ox_HC_Aer_Br
# Make sure all files in run directory are writable by all users
#chmod 666 /liu_group/climatechange2/GCRunDirs/geosfp_025x03125_tropchem_na/*
# Copy executable over to run directory
#cp /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01/bin/geos /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/RunDirTesting/FixMolWts/geosfp_025x03125_tropchem_na
#cp /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01/bin/geos /liu_group/climatechange2/GCRunDirs/geosfp_025x03125_tropchem_na

## ----
## 0.25x0.3125 CH full chemistry run: Used for production runs
## ----

# Clean out any old executables
#make realclean
# Compile 0.25x0.333 CH GEOS-FP full chemistry
#make -j4 MET=geosfp GRID=025x03125 NEST=CH CHEM=NOx_Ox_HC_Aer_Br
# Make sure all files in run directory are writable by all users
#chmod 666 /liu_group/climatechange2/GCRunDirs/geosfp_025x03125_tropchem_ch/*
# Copy executable over to run directory
#cp /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01/bin/geos /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/RunDirTesting/FixMolWts/geosfp_025x03125_tropchem_ch
#cp /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01/bin/geos /liu_group/climatechange2/GCRunDirs/geosfp_025x03125_tropchem_ch


## ----
## 2x2.5 full chemistry run (geos-fp) + SOAs: Used for production runs and to generate boundary condition files for NA and CH nested runs
## ----

# Clean out any old executable files
#make realclean
# Compile 2x2.5 full chemistry simulation using geos-fp
#make -j4 MET=geosfp GRID=2x25 CHEM=SOA
# Change permissions in run directory
#chmod 666 /liu_group/climatechange2/GCRunDirs/geosfp_2x25_tropchem/*
# Copy executable over to run directory
#cp /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01/bin/geos /liu_group/climatechange2/GCRunDirs/geosfp_2x25_soa
#cp /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01/bin/geos /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/RunDirTesting/TimedTrials_2x25/geosfp_2x25_soa

## ----
## 0.25x0.3125 full chemistry run, plus SOAs (geosfp): Testing directory, also used for production runs going forward
## ----

# Clean out exutable file
#make realclean
# Compile 0.25x0.3125 full cheimstry + SOA - NA
#make -j4 MET=geosfp GRID=025x03125 NEST=NA CHEM=SOA
# Change permissions in run directory
#chmod 666 /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/RunDirTesting/FixMolWts/geosfp_2x25_soa/*
#chmod 777 /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/RunDirTesting/FixMolWts/geosfp_2x25_soa
# Copy executable over to run directory
#cp /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/Code.v10-01/bin/geos /liu_group/remotesensing1/Jess/GEOS_CHEM_10_1/RunDirTesting/FixMolWts/geosfp_2x25_soa

