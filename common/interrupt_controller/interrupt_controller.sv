// outputs:
//  - exception number
//  - isExceptionPending (the signal that causes CPU to handle exception)
// inputs:
//  - exception number
//  - clear/set pending (for specified exception number)
//  - enable/disable (for speciified exception number)

// CPU can make use of exception number to find instruction of handler:
//  - vector base value + (exception number * 4B) = next PC
