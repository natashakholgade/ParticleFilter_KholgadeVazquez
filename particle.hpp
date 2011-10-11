#ifndef MYMEX_PARTICLE
#define MYMEX_PARTICLE

#include "mex.h"
#include "matrix.h"

class ParticleSet
{
public:
    
   double* particlePtr;
   int n;
   
   ParticleSet(double *p, int number);
   ~ParticleSet();
   
   bool getIdealLaserMeasurements(const double* map, int width, int height, 
                                  const double* angles, int beams, 
                                  double *&output);
   
   void print() const;
};


#endif