#!/bin/bash
#PBS -l walltime=00:00:15:00   # WALLTIME limit
#PBS -l nodes=16:ppn=2          # Number of nodes, use 8 processes on each
                               # Specify :ppn=x in previous line if you want
                               #  to use a "x" processors on each node
                               #  if there are core/memory concerns
#PBS -M first.last@du.edu
#PBS -m be                     # (b) begin, (e) end, (a) abort

cd $PBS_O_WORKDIR
set -x

#module purge
#module load mpi2/openmpi-1.8.4-GCC.64.IB
#module load compilers64/gcc-4.9.2
#apps/R-3.2.2

INPUT_BASENAME=lmfit         # JOB NAME - USER INPUT PARAMETER
JOB_FILE=$INPUT_BASENAME.R
OUT_FILE=$INPUT_BASENAME.Rout

mpirun -np 32 Rscript $JOB_FILE > $OUT_FILE

