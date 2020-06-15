import argparse
import numpy
import ipaddress
import sys

parser = argparse.ArgumentParser(description=\
	'Split a list of hosts or CIDR ranges into a designated number of files \
	with equal numbers of hosts. Input file must be line-separated IP addresses \
	or valid CIDR ranges only')
parser.add_argument('-l', '--list', metavar='', required=True, help='host list for input')
parser.add_argument('-s', '--splits', metavar='', required=True, type=int, help='number of split lists requested')

#catch if run without arguments
try:
	args = parser.parse_args()
except:
    parser.print_help()
    sys.exit(0)

# setting the arguments to objects
input_hostlist = args.list
input_splits = args.splits

master_list = []

# method to parse the input list and strip out the newline characters (needed for CIDR translation)
def create_master_list(hostlist):
	print(f"Creating hostlist from {input_hostlist}...")
	with open(hostlist) as file:
		hosts = file.read().splitlines()
	for addr in hosts:
		# if CIDR range (as indicated by slash), parse it through IPv4Network to translate to hosts
		if "/" in addr:
			cidr_range = [str(ip) for ip in ipaddress.IPv4Network(addr)]
			for ip in cidr_range:
				master_list.append(ip + "\n")
		else:
			master_list.append(addr + "\n")

# method for creating n equal-sized lists using numpy
def chunks(lst, num_chunks):
	print(f"Separating hostlist into {num_chunks} hostlist-output lists...")
	result = numpy.array_split(lst,num_chunks)
	for num in range(0,num_chunks):
		with open(f"hostlist-output-{num+1}.txt", "w") as file:
			file.writelines(result[num])

create_master_list(input_hostlist)
master_list.sort()
chunks(master_list,input_splits)


### To Do ##
# check the host file for valid IP addresses or CIDR ranges