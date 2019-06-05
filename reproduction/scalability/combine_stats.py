import argparse
import os
import re

import numpy as np

parser = argparse.ArgumentParser(description='Combine cpu scalability results into csv')
parser.add_argument('--dir', dest='dir', type=str, required=True, help="directory where .cpu_data files live")
parser.add_argument('--dest', dest='dest', type=str, required=True, help="file to store the combined data")

FILE_NAME_REGEX = re.compile(r'(kernel|ccp)-(cubic|reno)-([0-9]+).cpu_data$')


def read_file(file_name):
    with open(file_name) as data_file:
        data = []
        for line in data_file:
            data.append(list(map(float, line.split())))

    return np.array(data)
    average = np.average(data, axis=0)
    return average
 

def combine_files(directory, dest):
    with open(dest + '-reno.csv', 'w+') as reno_dest_file:
        with open(dest + '-cubic.csv', 'w+') as cubic_dest_file:
            with open(dest + '-averaged.csv', 'w+') as averaged_dest_file:
                reno_dest_file.write('Impl NumFlows Type Value\n')
                cubic_dest_file.write('Impl NumFlows Type Value\n')
                averaged_dest_file.write('Impl Alg NumFlows Average StdDev\n')

                for file_name in os.listdir(directory):
                    match = FILE_NAME_REGEX.match(file_name)
                    if not match:
                        continue
                    
                    data = read_file(directory + '/' + file_name)

                    avgs = np.average(data, axis=0)
                    (user_avg, _, system_avg, _, _, _, interrupt_avg, _, _, _) = avgs
                    combined_avg = user_avg + system_avg + interrupt_avg

                    stds = np.std(data, axis=0)
                    (user_std, _, system_std, _, _, _, interrupt_std, _, _, _) = stds
                    combined_std = user_std + system_std + interrupt_std

                    (data_path, alg, num_flows) = match.groups()
                    num_flows = int(num_flows)
                    dest_file = reno_dest_file if alg == 'reno' else cubic_dest_file

                    dest_file.write('{} {} user {}\n'.format(data_path, num_flows, user_avg))
                    dest_file.write('{} {} system {}\n'.format(data_path, num_flows, system_avg))
                    dest_file.write('{} {} interrupt {}\n'.format(data_path, num_flows, interrupt_avg))
                    averaged_dest_file.write('{} {} {} {} {}\n'.format(data_path, alg, num_flows, combined_avg, combined_std))


if __name__ == '__main__':
    parsed = parser.parse_args()
    combine_files(parsed.dir, parsed.dest)

