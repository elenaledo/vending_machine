#define MAX_SIM 30
#include <math.h>
#include <unistd.h>
void set_random(Vtop *dut, vluint64_t sim_unit) {
  dut->nickel_i = random()%2;
  if(dut->nickel_i==1){
    dut->dime_i = 0;
    dut->quarter_i = 0;
  }
  else
    dut->dime_i = random()%2;
  if(dut->nickel_i==1){
    dut->dime_i = 0;
    dut->quarter_i = 0;
  }
  else if(dut->dime_i==1){
    dut->nickel_i =0;
    dut->quarter_i=0;
  }else
    dut->quarter_i = random()%2;
}
