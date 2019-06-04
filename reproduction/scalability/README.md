# Scalability chart reproduction

To reproduce the charts in `scalabilty/plots`, first collect data.

This is done by running tests of kernel and CCP. These can be collected by running different forms of

```bash
$ ./run-[kernel|ccp]-[reno|cubic].sh ${DEST_DIR} \
                                     ${SERVER_ADDRESS} \
                                     ${DURATION} \
                                     ${NUM_FLOWS}
```

For example, to run a test for CCP's cubic against a remote server `1.2.3.4` for 4 flows for 20 seconds, run:


```bash
$ ./run-ccp-cubic.sh ~/scalability-data \
                     1.2.3.4 \
                     20 \
                     4
```

Note no effort has been made to run multiple of these scripts sequentually, as the [bug](https://github.com/kevindrosendahl/eval-scripts/tree/master/reproduction/crash) we found will cause the VM to crash on GCP, so you can only collect one set of ccp data per reboot.

This will output a file `ccp-cubic-4.cpu_data` into `~/scalabilty-data`.

Once you've collected all of the data from the runs you desire, run:

```bash
$ python3 combine_stats.py --dir ~/scalability-data --dest ~/scalability-data/combined
```

This will output two files, `combined-cubic.csv` and `combined-reno.csv`.

Finally, you can use these files to produce the charts:

```bash
$ ./plot/grouped.r ~/scalability-data/combined-cubic.csv ~scalability-plots/output-cubic.pdf
```

