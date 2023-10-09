# vending_machine
Practice for FSM and system verilog
Vending Machine is a dispenser machine that receives coins or bills and dispenses soft
drinks or snacks.
In this problem, you will design a vending machine that satisfies the requirements be-
low:
1. It accepts coins: ¢5 (Nickel), ¢10 (Dime), ¢25 (Quarter), but only one coin at a
time (or clock).
2. When the deposit exceeds ¢20, it dispenses a soda and a change.
3. Change is a 3-bit data
000 ¢0
001 ¢5
010 ¢10
011 ¢15
100 ¢20
