#include "mex.h"
#include "matrix.h"
#include "particle.hpp"


// input: particles (3xN), map (HxW), laserAngles (1,L)
// output: idealLaser (NxL)
void mexFunction(int nlhs, mxArray *plhs[ ], int nrhs, const mxArray *prhs[ ]) 
{
    if (nrhs != 3)
        mexErrMsgTxt("Three inputs required.");
    if(nlhs != 1) 
        mexErrMsgTxt("One output required.");
        
    if (mxGetM(prhs[0]) != 3)
        mexErrMsgTxt("Particles should be 3-dimensional (and matrix should be 3xN).");
    if (mxGetM(prhs[2]) != 1 || mxGetN(prhs[2]) < 1)
        mexErrMsgTxt("laserAngles should be a vector of radians in [0,2*pi].");
        
    mwSize N = mxGetN(prhs[0]);                 // number of particles
    double *particleMat = mxGetPr(prhs[0]);     // pointer to map data

    ParticleSet particleSet = ParticleSet(particleMat, N);
    //particleSet.print();
    
    //mexPrintf("got %d particles\n", nParticles);
    
    double *map = mxGetPr(prhs[1]);        // pointer to map data
    mwSize W = mxGetN(prhs[1]);            // map width
    mwSize H = mxGetM(prhs[1]);            // map height

    mwSize B = mxGetN(prhs[2]);            // number of beams
    double *angles = mxGetPr(prhs[2]);     // pointer to map data
    
    plhs[0] = mxCreateDoubleMatrix(N, B, mxREAL);
    double *idealLaser = mxGetPr(plhs[0]);
    
    if (!particleSet.getIdealLaserMeasurements(map, W, H, angles, 
                                               B, idealLaser))
    {
        mexPrintf("ERROR: Ideal laser measurement could not be computed.\n");
    }
    
// mexPrintf("Hello, world!\n");     
}