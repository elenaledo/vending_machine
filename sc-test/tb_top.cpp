#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cstdlib>
#include <string>
#include <iostream>
#include <verilated.h>
#include <verilated_fst_c.h>
#include "Vtop.h"
#include "driver.cpp"
#define f(x)*(float*)&x

//#define MAX_SIM       1000000
vluint64_t sim_unit = 0;
vluint64_t sim_time = 0;

void dut_clock(Vtop *dut, VerilatedFstC *vtrace);
//void set_random(Vtop *dut);
void get_expected(Vtop *dut);
void monitor_proc(Vtop *dut);
void monitor_outputs(Vtop *dut);
float convertToInt(long int* arr);

//--------------------------------- Binary to IEEE 754 FORMAT --------------------------------------------------------

void initial(Vtop *dut) {
}

void dut_clock(Vtop *dut, VerilatedFstC *vtrace) {
  sim_time = sim_unit * 10 + 1;
  if (vtrace)
    vtrace->dump(sim_time); // Dump values to update inputs

  sim_time = sim_time + 4;
  dut->clk_i = 0;
  dut->eval();
  if (vtrace)
    vtrace->dump(sim_time); // Dump values after negedge

  monitor_outputs(dut);        // Values are "stable" to monitor

  sim_time = sim_time + 5;
  dut->clk_i = 1;
  dut->eval();
  if (vtrace) {
    vtrace->dump(sim_time); // Dump values after posedge
    //vtrace->flush();
  }
}

//void set_random(Vtop *dut) {
//}

void get_expected(Vtop *dut) {
    printf("soda: %d\n",dut->soda_o);
    switch(dut->change_o){
      case(0):
        printf("change: 0 cent\n");
        break;
      case(1):
        printf("change: 5 cent\n");
        break;
      case(2):
        printf("change: 10 cent\n");
        break;
      case(3):
        printf("change: 15 cent\n");
        break;
      case(4):
        printf("change: 20 cent\n");
        break;
      default: break;
    }
}

void monitor_proc(Vtop *dut) {
    //printf("rs1: \t%032b\t\t rs2: %032b\t\t\n",dut->operand_a, dut->operand_b);
    printf("nick: %d\n",dut->nickel_i);
    printf("dime: %d\n",dut->dime_i);
    printf("quarter: %d\n",dut->quarter_i);
}

void monitor_outputs(Vtop *dut) {
}

int main(int argc, char **argv, char **env) {
	// Call commandArgs first!
	Verilated::commandArgs(argc, argv);

  // Instantiate the design
	Vtop *dut = new Vtop;

  // Trace generating
  Verilated::traceEverOn(true);
  VerilatedFstC *vtrace = new VerilatedFstC;
  dut->trace(vtrace, 2); // trace down to 2 hierarchy
  vtrace->open("wave.fst");
  vtrace->dump(0);

  // Initial setups
  srand(time(NULL));
  initial(dut);
  dut->eval();
  int n = 1;
  // Check procedure
  while (sim_unit < MAX_SIM){
    printf("\n------------------------ Pattern %d ------------------------\n\n",n);
    n++;
    dut_clock(dut, vtrace);
    monitor_proc(dut);
    set_random(dut, sim_unit);
    dut->eval();
    get_expected(dut);
    sim_unit++;
	}

  vtrace->close();
  delete dut;
  exit(EXIT_SUCCESS);
}
