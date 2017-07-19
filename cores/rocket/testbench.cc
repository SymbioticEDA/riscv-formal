#include "Vtestbench.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int timer = 0;

double sc_time_stamp()
{
	return timer;
}

int main(int argc, char **argv, char **env)
{
	Verilated::traceEverOn(true);

	Verilated::commandArgs(argc, argv);
	Vtestbench *tb = new Vtestbench;

	VerilatedVcdC *tfp = new VerilatedVcdC;
	tb->trace(tfp, 99);
	tfp->open("testbench.vcd");

	tb->clock = 0;
	tb->eval();
	tfp->dump(timer++);

	while (tb->genclock)
	{
		if (timer > 1)
			tb->clock = ~tb->clock;

		tb->eval();
		tfp->dump(timer++);
	}

	tfp->close();

	delete tfp;
	delete tb;

	return 0;
}
