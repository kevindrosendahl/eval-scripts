#!/usr/bin/python3

import sys
import subprocess

algs = {
    'reno': './generic-cong-avoid/target/release/reno',
    'cubic': './generic-cong-avoid/target/release/cubic',
#    'copa': './ccp_copa/target/release/copa',
# FIXME: uncomment to be able to use our buggy TCP Vegas implementation
#   'vegas': 'python ./reproduction/fidelity/src/vegas.py',
}

def start(dest, alg, ipc, name, args):
    subprocess.run('mkdir ./{} 2> /dev/null'.format(dest), shell=True)
    cmd = 'sudo {0} --ipc={4} {3} > ./{1}/ccp-tmp.log 2> ./{1}/{2}-ccp.log'.format(algs[alg], dest, name, args, 'char' if 'char' in ipc else ipc)

    # FIXME: Hack to use python reno instead of CCP Rust version
    # Note: this algorithm is somewhat buggy
    #if alg == 'reno':
    #    cmd = 'sudo python reno.py > ./{0}/ccp-tmp.log 2> ./{0}/{1}-ccp.log'.format(dest, name)

    print("> starting ccp: ", cmd)
    ccp_proc = subprocess.run(cmd, shell=True)

if __name__ == '__main__':
    dest = sys.argv[1]
    alg = sys.argv[2]
    name = sys.argv[3]
    ipc = sys.argv[4]
    args = ' '.join(sys.argv[5:])
    start(dest, alg, ipc, name, args)
