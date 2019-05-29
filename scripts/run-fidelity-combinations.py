import argparse
import itertools
import sh

parser = argparse.ArgumentParser(description='Run combinations of CCP experiments')
parser.add_argument('--alg', dest='algs', action='append', type=str, nargs='+', default=['cubic'])
parser.add_argument('--num-flows', dest='flows', action='append', type=int, required=True) 
parser.add_argument('--delay', dest='delays', action='append', type=int, required=True)
parser.add_argument('--rate', dest='rate', action='append', type=int, required=True)
parser.add_argument('--qsize', dest='qsize', action='append', type=int, required=True)
parser.add_argument('--combine-results', dest='combine_results', action='store_true', default=False)


def run_combination(alg, num_flows, delay, rate, qsize):
	print("running combination alg: {alg}, num_flows: {num_flows}, delay: {delay}, rate: {rate}, qsize: {qsize}".format(alg=alg,
																														num_flows=num_flows,
																														delay=delay,
																														rate=rate,
																														qsize=qsize))
	sh.run('''python3 scripts/run-fidelity-exp.py \
			    --outdir {alg}/{num_flows}/{delay}/{rate}/{qsize} \
				--duration 15 \
				--alg {alg} \
				--scenario fixed \
				--ipcs netlink \
				--kernel \
				--delay {delay} \
				--rate {rate} \
				--qsize {qsize} \
				--iters 1 \
				--num-flows {num_flows}'''.format(alg=alg,
												  num_flows=num_flows,
												  delay=delay,
												  rate=rate,
												  qsize=qsize), 
			shell=True)


def combine_results(alg, num_flows, delay, rate, qsize):
	sh.run('''cp {alg}/{num_flows}/{delay}/{rate}/{qsize}/cubic-fixed-cwndevo.pdf \
	             fidelity-experiments/{alg}-{num_flows}-{delay}-{rate}-{qsize}-cwndevo.pdf'''.format(alg=alg,
																									 num_flows=num_flows,
																									 delay=delay,
																									 rate=rate,
																									 qsize=qsize), 
			shell=True)

	


if __name__ == '__main__':
	parsed = parser.parse_args()
	product = itertools.product(parsed.algs,
								parsed.flows,
								parsed.delays,
								parsed.rate,
								parsed.qsize)
	if parsed.combine_results:
		sh.run('mkdir -p fidelity-experiments', shell=True)

	for p in product:
		if parsed.combine_results:
			combine_results(*p)
		else:
			run_combination(*p)
